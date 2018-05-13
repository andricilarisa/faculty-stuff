module MyParser (main) where

import Text.Megaparsec  
import Text.Megaparsec.String  
import System.Environment

data Exp = Var String
         | Numar Int
         | Suma Exp Exp
         | Diferenta Exp Exp
         | Produs Exp Exp deriving Show

data Instr = Atrib String Exp
         

main = do  
    input <- fmap head getArgs
    parseTest numar input


singleLetterP :: Parser String  
singleLetterP = string "=" 
 
varName :: Parser String
varName = some alphaNumChar 

variabila :: Parser Exp  
variabila = do
         skipMany spaceChar 
         x <- varName
         skipMany spaceChar
         return $ Var x

numar :: Parser Exp
numar = do
        skipMany spaceChar
        x <- some numberChar
        return $ Numar x