    import System.IO
    main :: IO()
    --main = do
    --    handle <- openFile "fisier.txt" ReadMode
    --    contents <- hGetContents handle
    --    putStr contents
    --    hClose handle
    main =  openFile "fisier.txt" ReadMode >>=
        (\handle-> hGetContents handle >>=
        (\contents -> putStr contents >>=
        (\_ -> hClose handle)))

--Citeste de la tastatura un numar n si afiseaza suma lor