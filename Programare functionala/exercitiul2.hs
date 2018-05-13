
-- Reminder (tipul parametrizat Maybe)
-- > :i Maybe
-- data Maybe a = Nothing | Just a
-- ...
-- Tipul "Maybe a" contine toate valorile tipului "a", protejate de constructorul "Just",
-- precum si inca o valoare "Nothing". De exemplu, valorile de tip Maybe Int sunt
-- Nothing, Just 0, Just (-2), Just 7, ...

{-

Exercitiul 1

Scrieti o functie care primeste doua valori de tip Maybe Int si
intoarce o valoare de tip Maybe Int care contine catul impartirii,
daca aceasta se poate calcula, sau Nothing in caz contrar.

-}

impartireMaybe :: Maybe Int -> Maybe Int -> Maybe Int
impartireMaybe (Just x) (Just 0) = Nothing
impartireMaybe (Just x) (Just y) = Just(x `div` y) 
{-

Exercitiul 2

Aceeasi cerinta pentru functia sumaMaybe.

-}

sumaMaybe :: Maybe Int -> Maybe Int -> Maybe Int
sumaMaybe (Just x) (Just 0) = Nothing
sumaMaybe (Just x) (Just y) = Just(x + y) 
minusUnarMaybe :: Maybe Int -> Maybe Int
minusUnarMaybe (Just x) = Just (-x)
{-

Mai jos avem un tip de date pentru expresii aritmetice cu numere
(intregi pe 32 de biti), "+" si "/".

-}

data Exp = Numar (Maybe Int)
         | Suma Exp Exp
         | Impartire Exp Exp
         | MinusUnar Exp
         deriving Show

{-

De exemplu, expresia matematica (3 + 4) / 5 este reprezentata de:
-- > Impartire (Suma (Numar 3) (Numar 4)) (Numar 5)
-- Impartire (Suma (Numar 3) (Numar 4)) (Numar 5)

Dandu-se o expresie aritmetica, putem calcula valoarea acesteia
folosind functia "eval":

-}


eval :: Exp -> Maybe Int
eval (Numar (Just n)) = Just n
eval (Suma e1 e2) = sumaMaybe (eval e1) (eval e2)
eval (Impartire e1 e2) = impartireMaybe (eval e1) (eval e2)
eval (MinusUnar e1) = minusUnarMaybe (eval e1)

{-

De data aceasta, functia "eval" intoarce o valoare de tip "Maybe Int".
Daca expresia nu contine erori de tipul impartirii prin zero, atunci
rezultatul este "Just n", unde n este un Int care este valoarea
expresiei.  In caz contrar, daca expresia contine erori de tipul
impartirii prin zero, rezultatul este "Nothing".

-}

{-

Exercitiul 3

Incercati sa evaluati, folosind functia de mai sus, expresiile
aritmetice 10 / (3 + -3) si (4 + 5) / 3. Atentie! -3 este numarul
intreg -3 :: Int, nu expresia - 3, adica operatorul minus unar (pe
care nu-l avem deocamdata) aplicat numarului 3.

eval (Impartire (Numar (Just 10)) (Suma (Numar (Just 3)) (Numar (Just (-3)))))
eval (Impartire (Suma (Numar (Just 4)) (Numar (Just 5))) (Numar(Just 3)))
-}

{-

Exercitiul 4

Extindeti tipul Exp cu constructori pentru: minus unar, minus binar,
produs, modulo, radical (intreg), exponentiere, factorial si eventual
alte operatii interesante.  Adaptati functia eval astfel incat sa
trateze si cazul noilor constructori. Testati pe cateva exemple
relevante functiile de mai sus.
{-

Pana acum am vazut cum se poate crea un tip de date algebric pentru
expresii aritmetice si cum se pot evalua astfel de expresii.

Dar este incomod sa le scriem de mana.

Am avea nevoie de un parser, adica de un program care sa transforme
un sir de caractere reprezentand o expresie aritmetica intr-o valoare
Haskell de tip Exp.

De exemplu, rezultatul parsarii sirului de caractere "(3 + 4) * 5" ar
trebui sa fie "Produs (Suma (Numar 3) (Numar 4))".

Vom implementa parsarea in doua etape:

1) etapa de tokenizare
2) etapa de parsare propriu-zisa

In acest fisier vom implementa prima etapa.

Tokenizarea, sau analiza lexicala, transforma un sir de caractere
intr-un sir de tokenuri. De exemplu, "(33 + 424) * 5" va fi transformat
in:

1) paranteza deschisa
2) numarul 33
3) caracterul '+'
4) numarul 424
5) paranteza inchisa
6) caracterul '*'
7) numarul 5

-}

-- vom avea nevoie de modulul Data.Char petru diverse functii utile
import Data.Char

-- valorile de tip Token corespund tuturor tokenurile de care avem nevoie
-- pentru inceput, vom trata doar '+', '*' si numerele intregi
data Token = TInt String
           | TSuma
           | TProdus
             deriving Show

{-

Exercitiul 1

Definiti functia skipWhiteSpace, care primeste la intrare un sir de
caractere si intoarce sirul de caractere fara spatiile de la inceput.

Exemple:
-- > skipWhiteSpace "  3 +  5 "
-- "3 +  5 "
-- > skipWhiteSpace "2 + 4 "
-- "2 + 4 "

In rezolvare, tineti cont ca String nu este altceva decat un sinonim
pentru [Char] (un String este o lista de Char).

-}
skipWhiteSpace :: String -> String

{-

Exercitiul 2

Definiti functia getInteger, care primeste la intrare un sir de caractere si
intoarce o pereche de siruri de caractere:

- prima componenta a perechii contine cifrele cu care incepe sirul
primit ca argument;
- a doua componenta, restul sirului.

Exemple:
-- > getInteger "123  + 23"
-- ("123", "  + 23")
-- > getInteger " 123 + 23 * 3"
-- ("", " 123 + 23 * 3")
-- > getInteger "123123123123 "
-- ("123123123123", " ")

Hint:
Ce face functia isDigit, care face parte din modulul Data.Char, pe care l-ati
importat la inceputul fisierului?
-- > isDigit '3'
-- > isDigit 'a'
-- > isDigit ' '
-}
getInteger :: String -> (String, String)

{-

Exercitiul 3

Definiti functia tokenNext, care primeste la intrare un sir de caractere si
intoarce o valoare de tip Maybe (Token, String):

- valoarea intoarsa este Nothing daca sirul primul ca argument nu
incepe cu unul din tokenurile valide
- valoare intoarsa este Just (x, y) daca sirul primul ca argument incepe
cu tokenul x :: Token si restul sirului este y

Exemple:

-- > tokenNext "+ * 123"
-- Just (TSuma, " * 123")
-- > tokenNext "123123 12 +"
-- Just (TInt "123123", " 12 +")
-- > tokenNext "* 1 + 2"
-- Just (TProdus, " 1 + 2")
-- > tokenNext "a + 1"
-- Nothing
-- > tokenNext " 1 + 2"
-- Nothing
-}

tokenNext :: String -> Maybe (Token, String)

{-
Exercitiul 4

Definiti functia tokenize, care primeste la intrare un sir de
caractere si intoarce o valoare de tip Maybe [Token]:

- Nothing daca sirul dat ca parametru nu contine tokenuri valide; 

- Just l daca l :: [Token] este chiar lista de tokenuri din sirul dat
la intrare.

Exemple:

-- > tokenize "1+2"
-- Just [TInt "1", TSuma, TInt "2"]
-- > tokenize "1+2*3"
-- Just [TInt "1", TSuma, TInt "2", TProdus, TInt "3"]
-- > tokenize "12+23*34"
-- Just [TInt "12", TSuma, TInt "23", TProdus, TInt "34"]
-- > tokenize "12 + 23 * 34"
-- Just [TInt "12", TSuma, TInt "23", TProdus, TInt "34"]
-- > tokenize " 12 + 23 * 34"
-- Just [TInt "12", TSuma, TInt "23", TProdus, TInt "34"]
-- > tokenize "     12 + 23 * 34"
-- Just [TInt "12", TSuma, TInt "23", TProdus, TInt "34"]
-- > tokenize "     12 +   23      *   34    "
-- Just [TInt "12", TSuma, TInt "23", TProdus, TInt "34"]
-- > tokenize "12+2 3*34"
-- Just [TInt "12", TSuma, TInt "2", TInt "3", TProdus, TInt "34"]
-- > tokenize "1 2 3 +"
-- Just [TInt "1", TInt "2", TInt "3", TSuma]
-- > tokenize "a1 2 3 +"
-- Nothing
-- > tokenize "1 _ 2 3 +"
-- Nothing
-- > tokenize "1 / 2"
-- Nothing

Incercati si alte exemple.

Hint: daca v este o valoare de tip Maybe a, puteti face o analiza de cazuri folosind
constructia "case" in felul urmator:

case v of
  Just x  -> 1
  Nothing -> 2

Expresia de mai sus se evalueaza la 1 daca v este de forma Just x si
la 2 daca v este Nothing.

-}
tokenize :: String -> Maybe [Token]