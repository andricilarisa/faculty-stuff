--Exercitiul1
--Se da o un integer si o lista ( sa se insereze acel integer la sfarsitul listei)
insert x [] = x:[] 
insert x (y:ys) = (y:ys) ++ (x:[])

--Exercitiul2
--[a]->a->Bool (Sa se verifice daca elementul a se afla in lista)
verifica_a_lista :: [Int]->Int->Bool
verifica_a_lista [] a = False
verifica_a_lista (x:xs) a | a==x = True
                          | otherwise = verifica_a_lista xs a
--Exercitiul3
--[a]->[a]->[a] primeste 2 liste si le concateneaza
concateneaza [] [] = []
concateneaza [] (x:xs) = (x:xs)
concateneaza (x:xs) [] = (x:xs)
concateneaza (x:xs) (y:ys) = (x:xs) ++ (y:ys)
--Exercitiul4
--Primeste o lista si intoarce inversul listei
reverse_a [] = []
reverse_a (x:xs) = reverse_a xs ++ [x]
--Exercitiul15
--Primeste o lista si o pozitie si intoarce elementul de la pozitie a
value_of_index (x:xs) a = (x:xs) !! a
--Exercitiul15
--Intoarce elementele impare din lista
get_impare [] = []
get_impare (x:xs) | x `mod` 2 == 1 = (x:[]) ++ get_impare(xs)
                  | otherwise = get_impare(xs)
--Exercitiul16
--Intoarce elemente de pe pozitii impare
get_impare_index [] = []
get_impare_index (x:xs) = (x:[]) ++ get_impare_index(drop 1 xs) 