{-# LANGUAGE ImplicitParams #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
import Data.List (sortBy)

mymy = ?a ++ ?a

my = mymy


main = let ?a  = "hello" in putStrLn my
