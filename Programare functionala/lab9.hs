--lab9
import System.IO

main :: IO () 

--main = (putStrLn "Hello, World!") 
      -- >>getLine 
	  -- >> (putStrLn "Cool new stuff")
	   
--main' = (>>=) getLine (\ s -> putStrLn ("Hello World Again" ++s))
--main' = getLine >>= (\ s -> (putStrLn ("Hello World Again" ++ s)))

--main = putStrLn "Prenume: " >>=
       -- (\_ -> getLine) >>=
		--(\prenume -> (putStrLn "Nume" >>=
		--(\_ -> getLine) >>=
		-- \nume -> (putStrLn ("Salut" ++ nume ++ prenume))))
		
--main' = do 
     --putStrLn "Prenume: "
	 --prenume <- getLine
	-- putStrLn "Nume: "
	-- nume <- getLine
	-- putStrLn ("Hello" ++ prenume ++ nume)
	 
	 
--main = do 
     -- handle <- openFile "test.txt" ReadMode
	 -- contents <- hGetContents handle 
	 -- putStr contents
	  --hclose handle 

main = (openFile "test.txt" ReadMode) >>= 	
       (contents <- hGetContents handle) >>=
	   (\putStr contents) >>=
	   (\_ <- hclose handle)
		
        

	  
--2 fct diferite, se comporta diferit si returneaza o valoare de tip unit

f :: ()
f = ()

g :: ()
g = g

-- IO a sunt niste actiuni care atunci cand sunt executate returneaza valori de tip a 


--se citeste un nr n, urmat de n numere si o sa ret suma lor