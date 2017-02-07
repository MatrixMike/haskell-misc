module Numeral where

import Data.List
import Binary

runLengthDecode = map ((subtract 1) . length ) . groupBy (==)
numerals  = map runLengthDecode binaries


listNumsToBooleans xs = concat $ zipWith (\x y -> replicate (y+1) x) (cycle [1,0]) xs
booleansToNumberList bs = map ( (subtract 1) . length ) . groupBy (==) $ bs



