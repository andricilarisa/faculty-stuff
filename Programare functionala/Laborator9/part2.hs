main::IO()
main = putStrLn "Prenume" >>=
    (\_ -> getLine) >>=
    (\prenume -> (putStrLn "Nume" >>=
     (\_ -> getLine) >>= 
     (\nume-> putStrLn ("Salut" ++ nume ++ prenume))))
   
