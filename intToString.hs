import Data.List
import Data.Char  

intToString x = map intToDigit $ reverse $ unfoldr (\x -> case divMod x 10 of (0,0) -> Nothing; (x,y) -> Just (y, x) ) x      

main = print (intToString 1234)

