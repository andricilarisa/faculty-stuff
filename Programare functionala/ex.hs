suma x y = x + y
dubleaza x = x + x
tripleaza x = x + x + x
lapatrat x = x * x
--dubleaza' (x,y) = (dubleza x, dubleza y)
--tripleza' (x,y) = (tripleaza x, tripleaza y)
--laputere' (x,y) = (laputere x, laputere y)

--Functii de ordin superior

aplicatuplu (x,y) f = ( f x, f y)

par x = mod x 2 ==0 

aplica2 x f = f (f x)

func True = dubleaza
func False = tripleaza 
f = func True
g = func False

map' f [] = []
map' f (x:xs)= (f x) : map' f xs

--filter' f [] = []
--filter' f (x:xs) | f x = x filter' f xs
 --                | otherwise = filter' f xs
				 
--foldl' f init [] = init
--foldl' f init (x:xs) = f x (foldl' f init xs)

comp f g x = f ( g x)

--functii anonime
--(\x -> x + x) 2 


--map, foldl, filter pentru tipul de liste definit de utilizator