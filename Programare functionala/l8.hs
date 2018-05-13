{-

In acest laborator, vom face urmatoarele imbunatatiri:

- vom extinde instructiunile tratate cu instructiuni conditionale si
instructiunea repetitiva

- vom extinde functia de executie a unei instructiuni

La sfarsitul laboratorului, ar trebui sa avem un interpretor pentru
program care folosesc instructiuni de atribuire, conditionale si
repetitive.

Veti putea folosi interpretorul pentru a executa un program care
calculeaza suma primelor n numere naturale.

Ex 1. Completati functia de evaluare pentru expresii conditionale (nu
uitati sa testati pe cateva exemple)

Ex 2. Adaugati o instructiune pentru bucle de tip "while" (nu uitati
sa testati pe cateva exemple + exemplul prog2)

Ex 3. Adaugati o instructiune pentru bucle "for"

Ex 4. (optional) Completati parserul pentru a parsa instructiuni si
secvente de instructiuni.

-}

{-

Tipul expresiilor de program.

-}

data Exp = Var String
         | Numar Int
         | Suma Exp Exp
         | Diferenta Exp Exp
         | Produs Exp Exp deriving Show


{-

Un sinonim de tip pentru valuatii partiale.

-}
type ValuationPar = String -> Maybe Int

{-

Valuatia "vida".

-}
empty :: ValuationPar
empty _ = Nothing

-- functia de actualizare a unei valuatii din laboratorul procedent
update :: ValuationPar -> String -> Maybe Int -> ValuationPar
update f variabila valoare = \x -> if x == variabila then valoare else f x 

-- functii ajutatoare din laboratorul precedent
lift2 :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
lift2 f Nothing _ = Nothing
lift2 f _ Nothing = Nothing
lift2 f (Just x) (Just y) = Just (f x y)

sumaMaybe :: Maybe Int -> Maybe Int -> Maybe Int
sumaMaybe = lift2 (+)

diferentaMaybe :: Maybe Int -> Maybe Int -> Maybe Int
diferentaMaybe = lift2 (-)

produsMaybe :: Maybe Int -> Maybe Int -> Maybe Int
produsMaybe = lift2 (*)

-- functia de evaluare care asociaza unei expresii si unei valuatii
-- partiale o valoare de tip Maybe Int reprezentand fie rezultatul
-- evaluarii (sub forma Just x), fie faptul ca in timpul evaluarii a
-- avut loc o eroare (Nothing).

evalp :: Exp -> ValuationPar -> Maybe Int
evalp (Numar x) _ = Just x
evalp (Var y) valp = valp y
evalp (Suma e1 e2) valp = sumaMaybe (evalp e1 valp) (evalp e2 valp)
evalp (Diferenta e1 e2) valp = diferentaMaybe (evalp e1 valp) (evalp e2 valp)
evalp (Produs e1 e2) valp = produsMaybe (evalp e1 valp) (evalp e2 valp)

-- tipul de date pentru un program
type Program = [Instr]

executaProgram :: ValuationPar -> Program -> Maybe ValuationPar
executaProgram valuatie [] = Just valuatie
executaProgram valuatie (i:is) = case executaInstr valuatie i of
Nothing  -> Nothing
Just valuatie' -> executaProgram valuatie' is

-- tipul de date pentru instructiuni
data Instr = Atrib String Exp
| Cond Exp Program Program

-- functia de executie a unei instructiuni
executaInstr :: ValuationPar -> Instr -> Maybe ValuationPar
executaInstr valuatie (Atrib x e) = Just (update valuatie x (evalp e valuatie))
executaInstr valuatie (Cond e p1 p2) = case (evalp e valuatie) of
Nothing   -> Nothing
Just 0    -> executaInstr( 0 p1 p2 )
otherwise -> executaInstr( valuatie p1 p2)

evalProgram :: Program -> Maybe Int
evalProgram prog = case (executaProgram empty prog) of
Just valuatie -> valuatie "result"
Nothing       -> Nothing

-- un program exemplu
--prog2 :: Program
--prog2 = [Atrib "n" (Numar 10),
--         Atrib "s" (Numar 0),
--         Bucla (Var "n") [Atrib "s" (Suma (Var "s") (Var "n")),
--                          Atrib "n" (Diferenta (Var "n") (Numar 1))
--                          ],
--         Atrib "result" (Var "s")]
{-

In acest laborator, vom face urmatoarele imbunatatiri:

- vom extinde instructiunile tratate cu instructiuni conditionale si
instructiunea repetitiva

- vom extinde functia de executie a unei instructiuni

La sfarsitul laboratorului, ar trebui sa avem un interpretor pentru
program care folosesc instructiuni de atribuire, conditionale si
repetitive.

Veti putea folosi interpretorul pentru a executa un program care
calculeaza suma primelor n numere naturale.

Ex 1. Completati functia de evaluare pentru expresii conditionale (nu
uitati sa testati pe cateva exemple)

Ex 2. Adaugati o instructiune pentru bucle de tip "while" (nu uitati
sa testati pe cateva exemple + exemplul prog2)

Ex 3. Adaugati o instructiune pentru bucle "for"

Ex 4. (optional) Completati parserul pentru a parsa instructiuni si
secvente de instructiuni.

-}

{-

Tipul expresiilor de program.

-}

data Exp = Var String
         | Numar Int
         | Suma Exp Exp
         | Diferenta Exp Exp
         | Produs Exp Exp deriving Show


{-

Un sinonim de tip pentru valuatii partiale.

-}
type ValuationPar = String -> Maybe Int

{-

Valuatia "vida".

-}
empty :: ValuationPar
empty _ = Nothing

-- functia de actualizare a unei valuatii din laboratorul procedent
update :: ValuationPar -> String -> Maybe Int -> ValuationPar
update f variabila valoare = \x -> if x == variabila then valoare else f x 

-- functii ajutatoare din laboratorul precedent
lift2 :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
lift2 f Nothing _ = Nothing
lift2 f _ Nothing = Nothing
lift2 f (Just x) (Just y) = Just (f x y)

sumaMaybe :: Maybe Int -> Maybe Int -> Maybe Int
sumaMaybe = lift2 (+)

diferentaMaybe :: Maybe Int -> Maybe Int -> Maybe Int
diferentaMaybe = lift2 (-)

produsMaybe :: Maybe Int -> Maybe Int -> Maybe Int
produsMaybe = lift2 (*)

-- functia de evaluare care asociaza unei expresii si unei valuatii
-- partiale o valoare de tip Maybe Int reprezentand fie rezultatul
-- evaluarii (sub forma Just x), fie faptul ca in timpul evaluarii a
-- avut loc o eroare (Nothing).

evalp :: Exp -> ValuationPar -> Maybe Int
evalp (Numar x) _ = Just x
evalp (Var y) valp = valp y
evalp (Suma e1 e2) valp = sumaMaybe (evalp e1 valp) (evalp e2 valp)
evalp (Diferenta e1 e2) valp = diferentaMaybe (evalp e1 valp) (evalp e2 valp)
evalp (Produs e1 e2) valp = produsMaybe (evalp e1 valp) (evalp e2 valp)

-- tipul de date pentru un program
type Program = [Instr]

executaProgram :: ValuationPar -> Program -> Maybe ValuationPar
executaProgram valuatie [] = Just valuatie
executaProgram valuatie (i:is) = case executaInstr valuatie i of
                                     Nothing        -> Nothing
                                     Just valuatie' -> executaProgram valuatie' is

-- tipul de date pentru instructiuni
data Instr = Atrib String Exp
           | Cond Exp Program Program

-- functia de executie a unei instructiuni
executaInstr :: ValuationPar -> Instr -> Maybe ValuationPar
executaInstr valuatie (Atrib x e) = Just (update valuatie x (evalp e valuatie))
executaInstr valuatie (Cond e p1 p2) = case (evalp e valuatie) of
                                         Nothing   -> Nothing
--                                       Just 0    -> ...
--                                       otherwise -> ...

evalProgram :: Program -> Maybe Int
evalProgram prog = case (executaProgram empty prog) of
                      Just valuatie -> valuatie "result"
                      Nothing       -> Nothing

-- un program exemplu
--prog2 :: Program
--prog2 = [Atrib "n" (Numar 10),
--         Atrib "s" (Numar 0),
--         Bucla (Var "n") [Atrib "s" (Suma (Var "s") (Var "n")),
--                          Atrib "n" (Diferenta (Var "n") (Numar 1))
--                          ],
--         Atrib "result" (Var "s")]
