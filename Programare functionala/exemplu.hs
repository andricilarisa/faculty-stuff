module Main (main) where

import Control.Monad (void)
import Text.Megaparsec
import Text.Megaparsec.Expr
import Text.Megaparsec.String -- input stream is of type ‘String’
import qualified Text.Megaparsec.Lexer as L

data Exp = Var String 
          | Numar Int
		  | Suma ExpExp
		  | etc

varNume:: Parser String
varNume = some alphaNumChar

varExp:: Parser Exp
varExp = do 
         skipManySpaceChar
		 XF varNume
		 return $Var x
		 