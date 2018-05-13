main :: IO()
main = do
    _ <- putStrLn "Prenume"
    prenume <- getLine
    _ <- putStrLn "Nume"
    nume <- getLine
    putStrLn ("Hello " ++ nume ++ " " ++ prenume )