count [] = 0
count (x:l) = 1 + count l
--sumaPozImpare [] = 0
--sumaPozImpare (x:[]) = x
--sumaPozImpare (x:y:xs) = x + sumPozImpare xs
--elemImpare [] = []
--elemImpare (x:[]) = [x]
--elemImpare (x:y:l) = x : elemImpare l
--odd_elements [] = []
--odd_elements (x:l) | mod x 2 = x: odd_elements l
--                   |otherwise = odd_elements l
-----------------------------------------------------
--tema 2
--rightinsert [] x = [x]
--rightinsert (x:xs) y = x: rightinsert xs y
--inverseaza [] = []
--inverseaza (x:l) = right_insert(inverseaza l) x
-------------------------------------------------------------------
--Lab3
-------------------------------------------------------------------
--tipuri de date algebrice
data Zi = Luni | Marti | Miercuri | Joi | Vineri | Sambata | Duminica deriving Show--- pentru a putea afisa
urm Luni = Marti
urm Duminica = Luni
data ValAdev = Fals | Adevarat deriving Show
neg Adevarat = Fals --negatie
neg Fals = Adevarat
sir Fals Fals = Fals --si logic
sir Adevarat Fals = Fals
sir Adevarat Adevarat = Adevarat
sir Fals Adevarat = Fals
convertor Adevarat = True ---Convertor din data ValAdev in bool
convertor Fals = False
-----un nou tip de date
data OInt = UnInt Int | NiciunInt deriving Show -- cei doi constructori pentru OInt , Int este parametru pentru constructorul UnInt
impartire _ 0 = NiciunInt
impartire x y = UnInt(div x y) --- Impartire sub data OInt
impartire' NiciunInt _ = NiciunInt
impartire' _ NiciunInt = NiciunInt
impartire' (UnInt _) (UnInt 0) = NiciunInt
impartire' (UnInt x) (UnInt y) = UnInt (div x y)
data Nat = Z | S Nat deriving Show
add x Z = x
add x (S y) = S (add x y)
produs x Z = Z--- produs
produs x (S y) = add x (produs x y)
convert 0 = Z---convertor int in data Nat
convert x = S(convert (x - 1))
convert1 Z = 0 --- convertor data NAt to Int
convert1 (S x) = 1 + convert1 x
----------------------------------------------
data Lista = Vida | Cons Int Lista deriving Show
nrElem Vida = 0
nrElem (Cons x y) = 1 + nrElem y
sumaLista::Lista->Int
sumaLista Vida = 0
sumaLista (Cons x y)= x + sumaLista y
---------------------convert si unconvert 
convertLista Vida = []---convert
convertLista (Cons x y) = x : convertLista y
uncov [] = Vida
uncov (x:l) = Cons x (uncov l)
data Lista' a = Vida' | Cons' a (Lista' a) deriving Show
convertin::Lista' a ->[a]
convertin Vida' = []
convertin (Cons' x l) = x : convertin l
-------------------TEMA!!!!
---- O functie in baza 2 care primeste un Nat si sa intoarca o lista' Int 
----- O functie Lista' Int -> Nat
---- 
