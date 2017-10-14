import Control.Arrow
import Control.Monad
import Data.Char
import Data.Either
import Data.List

import ParseFunctions
import ReadMiniLang

main = do
  print $ readMulti readMLIntOrWordOrOp "$$$"
  print $ readMulti readMLIntOrWordOrOp "hello123+hello123"
  print $
    readMulti
      readMLIntOrWordOrOpWithOrSpacingOrComment
      "hello123 + /* testComment */  +  hello123"
