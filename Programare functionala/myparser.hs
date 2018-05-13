
module MyParser (main) where

import Text.Megaparsec  
import Text.Megaparsec.String  
import System.Environment

main = do  
    input <- fmap head getArgs
    parseTest boldP input

boldP :: Parser String  
boldP = do  
    _ <- count 2 (char '*')
    txt <- some (alphaNumChar <|> char ' ')
    _ <- count 2 (char '*')
    return $ concat [ "<strong>", txt, "</strong>" ]