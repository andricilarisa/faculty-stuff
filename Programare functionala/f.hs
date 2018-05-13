--Laborator 1

f x = x + 2
g x y = x + y
a r = r * r * pi
p r = 2 * r * pi
fact 0 = 1
fact x = x * (fact (x - 1))
--suma :: Int -> Int
suma 0 = 0
suma n = n + suma( n - 1)
--functie reecursiva care calculeaza ridicarea la putere (2 parametrii) si sum primelor numere n impare
putere x 1 = x
putere x y = x * (putere x (y-1))

sum_impare 0 = 0
sum_impare 1 = 1
sum_impare n = sum_impare (n - 1) + n * 2 - 1

--if (expresie) then (expresie) else (expresie)
-- x=(a>b) ? a : b 

--Laborator 2
--valori tip tuplu (1,True) 
-- fst intoarce prima valoare a tuplului iar snd a doua valoare a tuplului


--cel mai mare divizor comun

cmmdc x y = if x == y then x else  if (x > y) then cmmdc (x - y) y else cmmdc x (y - x)

--sau 
--poate fi sters path-ul de la ultimile 2 linii de la cmmdc
cmmdc a b | a == b = a
cmmdc a b | a > b = cmmdc (a - b) b
cmmdc a b | a < b = cmmdc a (b - a)

--Listele sunt omogene [True, False, True, True] :: [Bool] ->Lista de bool. True: constructor pentru liste
--o lista de tip [a], a putand fi orice tip, este: Lista vida [] sau o lista x:l unde x->de tip a iar l este o alta lista de tipul a 
 
count [] = 0
count (x:l) = 1 + count l 

sumOfList [] = 0
sumOfList (x:l) = x + sumOfList l

--suma elementelor de pe pozitii impare

sumPozImpare [] = 0
sumPozImpare (x:[]) = x
sumPozImpare (x:y:xs) = x + sumPozImpare xs  

--se afiseaza doar elementele de pe pozitii impare dintr-o lista 

elemPozImpare [] = []
elemPozImpare (x:[]) = [x]
elemPozImpare (x:y:l) = x: elemPozImpare l


--elementele impare dintr-o lista

odd_elements [] = []
odd_elements (x:l) | mod x 2 == 1 = x: odd_elements l
                   |otherwise     = odd_elements l 
				   
--constructor pentru lista : -> cu argumente , [] fara argumente ; [2,3,4] -> 2:(3:(4:[]))


--functie care primeste o lista si pune la sfarsitul acesteia un elementele
--concatenare, primeste 2 liste, returneaza o lista
--inverseaza , primeste o lista si o returneaza inversata
-- esteVida primest eo lista si returneaza un bool


--se da un numar, se afiseaza reprezentarea binara a acestuia sub forma de lista

binar_nr 0 = []
binar_nr x = (mod x 2): binar_nr (x div 2)


--Laborator 3

--definirread tipurilor de date
data Zi = Luni | Marti | Miercuri | Joi | Vineri | Sambata | Duminica deriving Show
urm :: Zi -> Zi
urm Luni = Marti
urm Marti = Miercuri
urm Miercuri = Joi
urm Joi = Vineri
urm Vineri = Sambata
urm Sambata = Duminica
urm Duminica = Luni

data ValAdev = Fals | Adevarat deriving Show
neg :: ValAdev -> ValAdev
neg Fals = Adevarat
neg Adevarat = Fals
si :: ValAdev -> ValAdev -> ValAdev
si Adevarat Fals = Fals
si Adevarat Adevarat = Adevarat
si Fals Fals = Fals
si Fals Adevarat = Fals

convert :: ValAdev -> Bool
convert Fals = False
convert Adevarat = True


data OINT = UnInt Int | NiciunInt deriving Show--costructori; Int e param pt constructorul UnInt

impartire :: Int -> Int -> OINT
impartire _ 0 = NiciunInt
impartire x y = UnInt (div x y)

impartire' :: OINT -> OINT -> OINT
impartire' NiciunInt _ = NiciunInt
impartire' _ NiciunInt = NiciunInt
impartire' (UnInt x) (UnInt 0) = NiciunInt
impartire' (UnInt x) (UnInt y) = UnInt (div x y) 

data Nat = Z | S Nat deriving Show
--reprezentarea unara a nr naturale
add :: Nat -> Nat -> Nat
add x Z = x
add x (S y) = S (add x y)

--inmultireaa
inm :: Nat -> Nat -> Nat
inm x Z = Z
inm x (S y) = add x (inm x y)

conv :: Int -> Nat
conv 0 = Z
conv x = S (conv (x-1))

unconv :: Nat -> Int
unconv Z = 0
unconv (S x) = 1 + unconv x


data Lista = Vida | Cons Int Lista  deriving Show

nrElem :: Lista -> Int
nrElem Vida = 0
nrElem (Cons x y) = 1 + nrElem y

sumaElem :: Lista -> Int
sumaElem Vida = 0
sumaElem (Cons x y) = x + sumaElem y

conv1 :: Lista -> [Int]
unconv1 :: [Int] -> Lista

conv1 Vida = []
conv1 (Cons x y) = x : conv1 y

unconv1 [] = Vida
unconv1 (x : y) = Cons x (unconv1 y)

data Lista1 a = Vida1 | Cons1 a (Lista1 a) deriving Show 

convert' :: Lista1 a -> [a]
convert' Vida1 = []
convert' (Cons1 x y) = x : convert' y

data Bst = Null | Fork Bst Int Bst deriving (Show, Ord, Eq)

search :: Bst ->Int->Bool
search Null=False
search (Fork l k r) x
       | x == k = True
	   | x < k = search l x
	   | otherwise = search r x

insert :: Int -> Bst -> Bst
insert x Null = Fork Null x Null
insert x (Fork l k r) | x == k = (Fork l k r)
                      | x < k = (Fork (insert x l) k r)
					  | x > k = (Fork l k (insert x r))
					  

--Laborator 4
-- o clasa de tipuri este 

--data Zi = Luni | Marti | Miercuri | Joi | Vineri | Sambata | Duminica deriving Eq

sumaF x y = x + y
					  

	   
	   










   
























