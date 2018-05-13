 {-

Am vazut cum se poate tokeniza un sir de caractere.

In continuare, vom trece la partea de parsare propriu-zisa: vom face o
functie parse care transforma un sir de tokenuri intr-o expresie
aritmetica.

Vom implementa un parser recursiv descendent foarte simplu.

-}

-- vom avea nevoie de modulul Data.Char petru diverse functii utile
import Data.Char
--import part1
data Token = TInt String
           | TSuma
           | TProdus
           | TParenLeft
           | TParenRight
             deriving Show

data Exp = Numar Int
         | Suma Exp Exp
         | Produs Exp Exp
         deriving Show

{-

Exercitiul 1

Pentru inceput, vom scrie un parser care va putea parsa produse de
factori, iar prin factor vom intelege pentru moment numere intregi.

Definiti functia parseFactor care primeste o lista de tokenuri si
intoarce o valoare de tip Maybe (Exp, [Token]) in felul urmator:

- Nothing daca lista de tokenuri primita ca argument nu incepe cu un
numar intreg

- Just (e, tl) daca lista de tokenuri primita ca argument incepe cu un
token de forma TInt s, e :: Exp este expresie formata doar din numarul
s iar tl sunt celelalte tokenuri (fara primul).

Exemple:

-- > parseFactor [TInt "123", TSuma, TInt "23"]
-- Just (Numar 123, [TSuma, TInt "23"])
-- > parseFactor [TSuma, TInt "23"]
-- Nothing
-- > parseFactor [TInt "23"]
-- Just (Numar 23, [])

Hint: pentru a converti un String intr-un Int, puteti folosi functia
predefinita read.

-- > read "123" :: Int
-- 123
-- > read "123" :: Float
-- 123.0
-- > :t read
-- > :i String

-}
parseFactor :: [Token] -> Maybe (Exp, [Token])
parseFactor [] = Nothing
parseFactor (x:xs) = case x of
                    TProdus->Nothing
                    TSuma->Nothing
                    (TInt x)->Just ( Numar (read x::Int), xs)

{-

Exercitiul 2

Completati definitia functiei parseTerm de mai jos.

Scopul functiei este sa parseze un termen dintr-o lista de
tokenuri. Prin termen se intelege un produs de factor.

Functia intoarce Nothing daca lista de tokenuri nu incepe cu un termen
sau Just (e, tl) daca lista de tokenuri data ca argument incepe cu
termenul e si mai contine in plus tokenurile tl.

Exemple:

-- > parseTerm [TInt "123", TProdus, TInt "23"]
-- Just (Produs (Numar 123) (Numar 23), [])
-- > parseTerm [TInt "123", TProdus, TInt "23", TProdus, TInt "12"]
-- Just (Produs (Numar 123) (Produs (Numar 23) (Numar 12)), [])
-- > parseTerm [TInt "123"]
-- Just (Numar 123, [])
-- > parseTerm [TInt "123", TProdus]
-- Just (Numar 123, [TProdus])
-- > parseTerm [TProdus]
-- Nothing

Hint: variabilele sunt denumite in felul urmator:
1) te = tokens expression
2) el = expression left
3) trest = tokens rest
4) ter = tokens expression right
5) er = expression right

Mai aveti completat cazurile cand: 1) trest este lista vida si
respectiv 2) cand trest nu este lista vida, dar incepe cu altceva
decat TProdus.

-}

parseTerm :: [Token] -> Maybe (Exp, [Token])
parseTerm te = case parseFactor te of
                 Just (el, trest) ->
                   case trest of
                     (TProdus:ter) -> case parseTerm ter of
                                       Nothing -> Just (el, TProdus:ter)
                                       Just (er, tl) -> Just ((Produs el er), tl)
                     []->Just( el, [])
                     (TSuma:ter)->Just (el, TSuma:ter)
                     ((TInt x):ter)->Nothing
                 Nothing -> Nothing

{-

Exercitiul 3.

Completati definitia functiei parseExp de mai jos.

Scopul functiei este sa parseze o expresie dintr-o lista de
tokenuri. Prin expresie se intelege o suma de termeni.

Exemple:

-- > parseExp [TInt "123", TProdus, TInt "1", TSuma, TInt "23"]
-- Just ((Suma (Produs (Numar 123) (Numar 1)) (Numar 23)), [])
-- > parseExp [TInt "123", TProdus, TInt "1"]
-- Just ((Produs (Numar 123) (Numar 1)), [])
-- > parseExp [TInt "123", TProdus, TInt "1", TProdus, TInt "2", TSuma, TInt "23"]
-- Just ((Suma (Produs (Numar 123) (Produs (Numar 1) (Numar 2))) (Numar 23)), [])
-- > parseExp [TInt "123", TProdus, TInt "1", TProdus, TInt "2", TSuma, TInt "23", TProdus, TInt "2"]
-- Just ((Suma (Produs (Numar 123) (Produs (Numar 1) (Numar 2))) (Produs (Numar 23) (Numar 2))), [])
-- > parseExp [TInt "123", TProdus, TInt "1", TProdus, TInt "2", TSuma, TInt "23", TProdus, TInt "2", TSuma, TInt "1"]
-- Just ((Suma (Produs (Numar 123) (Produs (Numar 1) (Numar 2))) (Suma (Produs (Numar 23) (Numar 2)) (Numar 1))), [])
-- > parseExp [TInt "123", TSuma, TSuma]
-- Just ((Numar 123), [TSuma, TSuma])
-- > parseExp [TInt "123"]
-- Just ((Numar 123), [])
-- > parseExp [TInt "123", TProdus, TInt "1"]
-- Just ((Produs (Numar 123) (Numar 1)), [])
-- > parseExp [TInt "123", TProdus]
-- Just ((Numar 123), [TProdus])

Hint: la fel cu parseTerm parseaza un produs de factori, la fel
parseExp trebuie sa parseze o suma de termeni, deci definitiile
functiilor parseExp si parseTerm seamana ca structura.

-}
parseExp :: [Token] -> Maybe (Exp, [Token])
parseExp te = case parseTerm te of
              Just(el, trest)->  
                case trest of
                     ((TInt x):ter)->Nothing
                     (TProdus:ter) -> Just(el,TProdus:ter)
                     (TSuma:ter) -> case parseExp ter of
                                       Nothing -> Just (el, TSuma:ter)
                                       Just (er, tl) -> Just ((Suma el er), tl)
                     
                     []->Just( el, [])
              Nothing->Nothing



parseFactor1 :: [Token] -> Maybe (Exp, [Token])
parseFactor1 [] = Nothing
parseFactor1 (x:xs) = case x of
                    TProdus->Nothing
                    TSuma->Nothing
                    TParenRight->Nothing
                    (TInt x)->Just ( Numar (read x::Int), xs)
                    TParenLeft->case parseExp1 xs of
                                Nothing->Nothing
                                Just(y,ter)-> case ter of
                                                        []->Nothing
                                                        TParenLeft:ts->Nothing
                                                        TParenRight:ts->Just ( y, ts)
                                                        TProdus:ts->Nothing
                                                        TSuma:ts->Nothing
                                                        (TInt x):ts->Nothing
                                                                                                                                                
parseTerm1 :: [Token] -> Maybe (Exp, [Token])
parseTerm1 te = case parseFactor1 te of
                 Just (el, trest) ->
                   case trest of
                     (TParenLeft:ter)->Nothing
                     (TParenRight:ter)->Just(el,TParenRight:ter)
                     (TProdus:ter) -> case parseTerm1 ter of
                                       Nothing -> Just (el, TProdus:ter)
                                       Just (er, tl) -> Just ((Produs el er), tl)
                     []->Just( el, [])
                     (TSuma:ter)->Just (el, TSuma:ter)
                     ((TInt x):ter)->Nothing
                 Nothing -> Nothing


parseExp1 :: [Token] -> Maybe (Exp, [Token])
parseExp1 te = case parseTerm1 te of
              Just(el, trest)->  
                case trest of
                     (TParenLeft:ter)->Nothing
                     (TParenRight:ter)->Just(el,TParenRight:ter)
                     ((TInt x):ter)->Nothing
                     (TProdus:ter) -> Just(el,TProdus:ter)
                     (TSuma:ter) -> case parseExp1 ter of
                                       Nothing -> Just (el, TSuma:ter)
                                       Just (er, tl) -> Just ((Suma el er), tl)
                     
                     []->Just( el, [])
              Nothing->Nothing

{-

Exercitiu 6

In acest moment, functia parseExp apeleaza recursiv parseTerm, care
apeleaza recursiv parseFactor, care apeleaza recursiv parseExp. Avem
deci 3 functii mutual recursive care pot parsa o expresie, oricat de
mare ar fi inaltimea arborelui sintactic al expresiei.

Folositi parseExp pentru a parsa lista de tokenuri din expresiile aritmetice:
1) 3 + 4 * (2 + 6);
2) (2 + 4) * (5 + 6) + 2 * 3;
3) 1 + (2 * 3 + 4) * (2 + 4 * 5);
4) 1 + 2 + 3 * (4 + 5 * (2 + 2 * (1 + 1))).


-}