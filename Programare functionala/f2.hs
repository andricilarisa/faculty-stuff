
--f x = x + 2
--g x y = x + y
--perimetru raza = 2 * pi * raza
--aria raza = pi * raza * raza
--fact 0 = 1
--fact n = n * (fact (n-1))

----suma::Int->Int
--suma 0 = 0
--suma n = n + (suma (n-1))

--power _ 0 = 1
--power 0 _ = 0
--power x n  = x * (power x (n-1))

--suma2 n = n*n


--suma3 1 = 1
--suma3 n = 2 * n - 1 + suma3 (n - 1)



--cmmdc a b | a == b = a
--cmmdc a b | a > b = cmmdc (a-b) b
--cmmdc a b | True = cmmdc b (b-a)

--cmmdc a b = 
--	if a == b then a
--		else if a > b then cmmdc (a-b) b
--			else cmmdc a (b-a)

----nr de elemente intr-o lista
--count [] = 0
--count (x : l) = 1 + count l

--suma4 [] = 0
--suma4 (x : l) = x + suma4 l

--suma5 :: [Integer] -> Integer
----suma numere impare
--suma5 [] = 0
--suma5 (x : l) = 
--	if mod x 2 == 1 then x + suma5 l
--		else suma5 l

--sumaImpPos [] = 0
--sumaImpPos (x:[]) = x
--sumaImpPos (x:y:xs) = x + sumaImpPos xs

----lista cu elementele de pe pozitii impare
--imparePoz [] = []
--imparePoz (x:[]) = [x]
--imparePoz (x:y:l) = x:imparePoz l

----lista cu elementele impare
--lista [] = []
--lista (x:l) | mod x 2 == 1 = x:lista l
--            | otherwise    = lista l

----functie care adauga la sfarsit

----functie care primeste n si returneaza lista binar
----binar 0 = []
----binar x = (mod x 2):binar (x dim 2)

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
