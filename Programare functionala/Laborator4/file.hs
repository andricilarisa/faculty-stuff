--Laborator 4
data Zi = Lu|Ma|Mi|Jo|Vi|Sa|Du

instance Eq Zi where 
    (/=) Lu Lu = False
    (/=) Ma Ma = False
    (/=) Mi Mi = False
    (/=) Jo Jo = False
    (/=) Vi Vi = False
    (/=) Sa Sa = False
    (/=) Du Du = False
    (/=) _ _ = True

suma x y = x + y

dubleaza x = x + x
tripleaza x = x + x + x
lapatrat x = x * x
invers x = -x
dubleaza' (x,y) = (dubleaza x, dubleaza y)
tripleaza'(x,y) = (tripleaza x, tripleaza y)
aplicatuplu (x,y) f = (f x, f y) 

par x | x `mod` 2 == 0 = True
      | x `mod` 2 == 1 = False
	  
aplica2 (x,y) f = (f (f x) , f (f y)) --apelam functia de 2 ori

--o functie care intoarce o functie 

func True = dubleaza
func False = tripleaza
f = func True
g = func False
map' f [] = []
map' f (x:xs)= (f x):map' f xs

filter' f [] = []
filter' f (x:xs) | f x == True = x:filter' f xs
                 | otherwise = filter' f xs
				 
sumdubl (x:xs) = foldl (+) 0 (map' dubleaza (filter' par (x:xs)))

foldl' f init [] = init
foldl' f init (x:xs) = f x ( foldl' f init xs)

comp f g = f.g

comp' f g x = f(g x)

impar = not.par
-- functie anonima 
impar' = comp' not par

convert [] = show ""
convert x:xs = show x (++) convert xs