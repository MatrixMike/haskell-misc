import Data.Char
import Data.Either
import Data.List
import Control.Monad
import Control.Arrow

import ReadMiniLang
import ParseFunctions

                      
main = do 
       print $ readMulti readMLIntOrWordOrOp "$$$"
       print $ readMulti readMLIntOrWordOrOp "hello123+hello123"
       print $ readMulti readMLIntOrWordOrOpWithOrSpacingOrComment "hello123 + /* testComment */  +  hello123"
