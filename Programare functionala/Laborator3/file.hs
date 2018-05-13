data Zi = Luni | Marti | Miercuri | Joi | Vineri | Sambata | Duminica deriving Show
urm :: Zi -> Zi
urm Luni=Marti
urm Marti=Miercuri
urm Miercuri=Joi
urm Joi=Vineri
urm Vineri=Sambata
urm Sambata=Duminica
urm Duminica=Luni
-- negatia 
data ValAdev = Fals | Adevarat deriving Show
negatie :: ValAdev -> ValAdev
negatie Fals=Adevarat
negatie Adevarat=Fals
-- && logic 
conjunctie :: ValAdev->ValAdev->ValAdev
conjunctie Adevarat Adevarat = Adevarat
conjunctie _ Fals = Fals
conjunctie Fals _ = Fals
-- converteste ValAdev la Bool
convertValAdevtoBool :: ValAdev -> Bool
convertValAdevtoBool Fals = False 
convertValAdevtoBool Adevarat = True
-- Un tip de date care contine o valoare speciala pe langa cele existente
-- UnInt si NiciunInt sunt constructori pentru tippul OInt
-- Int este parametru pentru constructorul UnInt
data OInt = UnInt Int | NiciunInt deriving Show

impartire :: Int->Int->OInt
impartire _ 0 = NiciunInt
impartire x y = UnInt (div x y)

impartire' :: OInt->OInt->OInt
impartire' NiciunInt _ = NiciunInt
impartire' _ NiciunInt = NiciunInt
impartire' (UnInt x) (UnInt 0) = NiciunInt
impartire' (UnInt x) (UnInt y) = UnInt (div x y)
 
--Definitia numerelor naturale
data Nat = Zero | Succ Nat deriving Show 

add :: Nat -> Nat->Nat
add x Zero = x
add x (Succ y) = Succ(add x y)

prod :: Nat->Nat->Nat
prod x Zero = Zero
prod Zero x = Zero
prod x (Succ y) = add x (prod x y)

--convert Int to Nat
convertNatToInt :: Int->Nat
convertNatToInt 0 = Zero
convertNatToInt x = Succ(convertNatToInt(x-1))
-- convert Nat to Int 
unconvert :: Nat->Int
unconvert Zero = 0
unconvert (Succ x) = 1 + unconvert x

-- Construim un tip de date pentru liste de numere intregi 
data  Lista = Vida | Cons Int Lista deriving Show
-- Intoarce numarul de elemente din lista
nrEl :: Lista -> Int
nrEl Vida = 0
nrEl (Cons x y) = 1 + nrEl y
--Intoarce suma elementelor din lista
sumEl :: Lista -> Int
sumEl Vida = 0
sumEl (Cons x y) = x + sumEl y
--converteste tipul List in tipul [Int]
convEl :: Lista->[Int]
convEl Vida = []
convEl (Cons x y) = x:convEl y
--converteste tipul [Int] in tipul Lista
unconvEl :: [Int]->Lista
unconvEl [] = Vida
unconvEl (x:l) = Cons x (unconvEl l)

--Structura de pentru liste care isi aloca tipul dinamic
data Lista' a = Vida' | Cons' a (Lista' a) deriving Show
-- converteste o lista de tip Lista' a in lista de [a]
convEl' :: Lista' a ->[a]
convEl' Vida' = []
convEl' (Cons' x y) = x:convEl' y
-- converteste o lista de tip [a] intr-o lista de tipul Lista' a
unconvEl' :: [a]->Lista' a
unconvEl' [] = Vida'
unconvEl' (x:l) = Cons' x (unconvEl' l)

-- Tema 3
-- Ex1 Converteste
natToBinar :: Nat -> Lista
natToBinar Zero = Vida
natToBinar x = Cons ((unconvert x) `mod` 2) (natToBinar (convertNatToInt ((unconvert x) `div` 2))) 

-- Ex2
binarToNat :: Lista -> Nat
binarToNat Vida = Zero
binarToNat (Cons x y) = add (prod (convertNatToInt (2^((nrEl (Cons x y))-1))) (convertNatToInt x)) (binarToNat y)

--Ex3
data NatBinara = Zeroo | Unu | AUnu NatBinara | AZero NatBinara deriving Show

--Functii auxiliare temei------------------------------------------ 
convElBinar :: NatBinara->[Int]
convElBinar Zeroo = [0]
convElBinar Unu = [1]
convElBinar (AUnu y) = 1:convElBinar y
convElBinar (AZero y) = 0:convElBinar y

convElIntToBinar :: [Int]->NatBinara
convElIntToBinar [0] = Zeroo
convElIntToBinar [1] = Unu
convElIntToBinar (x:xs) | x == 0 = AZero (convElIntToBinar xs)
                        | x == 1 = AUnu (convElIntToBinar xs)

reverse_a [] = []
reverse_a (x:xs) = reverse_a xs ++ [x]

lgNatBinara :: NatBinara -> Int
lgNatBinara Zeroo = 1
lgNatBinara Unu = 1
lgNatBinara (AUnu x) = 1 + lgNatBinara x
lgNatBinara	(AZero x) = 1 + lgNatBinara x

reverseNatBinar :: NatBinara -> NatBinara
reverseNatBinar x = convElIntToBinar (reverse_a(convElBinar x))
-----------------------------------------------------------------------

natToNatBina :: Nat -> NatBinara
natToNatBina Zero = Zeroo
natToNatBina (Succ Zero) = Unu
natToNatBina x  | ((unconvert x) `mod` 2) == 0 = AZero (natToNatBina (convertNatToInt ((unconvert x) `div` 2))) 
                | otherwise = AUnu (natToNatBina (convertNatToInt((unconvert x) `div` 2)))
				
natToNatBinar :: Nat -> NatBinara
natToNatBinar x = reverseNatBinar (natToNatBina x)			  
--Ex4

natBinarToNat :: NatBinara -> Nat
natBinarToNat Zeroo = Zero
natBinarToNat Unu = (Succ Zero)
natBinarToNat (AZero x) = natBinarToNat x  
natBinarToNat (AUnu x) = add (convertNatToInt(2^(lgNatBinara x))) (natBinarToNat x)

--Ex5 add NatBinara 
addNatBinara :: NatBinara->NatBinara->NatBinara
addNatBinara x y = natToNatBinar (add (natBinarToNat x) (natBinarToNat y)) 

-- Tree area
--Ex 6
data Tree = EmptyTree | Node Int Tree Tree deriving Show


-- Insertia unei liste intr-un BST
treeInsert :: [Int]->Tree->Tree
treeInsert [] (Node a left right) = Node a left right
treeInsert (x:xs) EmptyTree = treeInsert xs (Node x EmptyTree EmptyTree)
treeInsert (x:xs) (Node a left right) | x==a = Node a left right
                                      | x<a = Node a (treeInsert (x:xs) left) right
                                      | x>a = Node a right (treeInsert (x:xs) left)
--Cauta un nod intr-un BST
findNode :: Int->Tree->Bool
findNode x EmptyTree = False
findNode x (Node a left right) | x == a = True
                               | x<a = findNode x left
                               | x>a = findNode x right
--Sterge un nod dintr-un BST

--BST to Balanced BST