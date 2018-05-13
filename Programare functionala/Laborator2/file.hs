--msdad
first (x,y,z)=x
--functie count 
count [] = 0
count (_:l) = 1 + count l
-- suma elementelor dintr-o lista
suma (x:l) = x + suma l
suma [] = 0
-- suma prim 
sump [x] = x
sumap (x:l) = x + sumap l
-- primeste o lista la intrare si aduna elementelor impare din acea lista
sumai [] = 0
sumai (x:l) =
         if x `mod` 2 == 1 then x + sumai l 
         else 0 + sumai l
--
sumaimpare [] = 0
sumaimpare (x:l) | x `mod` 2 == 1 = x + sumaimpare l 
                 | otherwise = suma l
-- primeste o lista si intoarce suma elementelor aflate pe pozitii impare
sumapoz [] = 0
sumapoz [x] = x
sumapoz (x:_:xs) = x + sumapoz xs
-- primeste un numar si intoarce o lista cu reprezentarea numarului in baza 2
listabaza2 0 = [0]
listabaza2 1 = [1]
listabaza2 a = ((a`mod`2):(listabaza2(a`div`2)))

-- primeste lista in baza 2 si intoarca numarul
 
binartonumber [0] = 0
binartonumber [1] = 1
binartonumber (x:l) = (2^(count(x:l)-1))*x + binartonumber l;

f (x:y) = x