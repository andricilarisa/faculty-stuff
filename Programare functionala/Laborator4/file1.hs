--Tema 4
data Lista = Vida | Cons Int Lista deriving Show

aduna x y = x + y
scade x y = x - y
unconvEl :: [Int]->Lista
unconvEl [] = Vida
unconvEl (x:l) = Cons x (unconvEl l)

par :: Int->Bool
par x | x `mod` 2 == 0 = True
      | otherwise = False
-- Ex1
map' f Vida = Vida
map' f (Cons x y) = Cons (f x) (map' f y)
--Ex2
foldl' f init Vida = init
foldl' f init (Cons x y) = f x ( foldl' f init y)
--Ex3
filter' f Vida = Vida
filter' f (Cons x y) | f x == True = Cons x (filter' f y)
                     | otherwise = filter' f y


