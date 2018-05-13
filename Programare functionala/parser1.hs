main = do  
    input <- fmap head getArgs
    parseTest singleLetterP input

singleLetterP :: Parser Char  
singleLetterP = char 'h' <|> char 'j'  