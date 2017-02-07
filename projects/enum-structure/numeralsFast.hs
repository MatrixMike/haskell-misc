import Data.List

listNumsToBooleans xs = concat $ zipWith (\x y -> replicate (y+1) x) (cycle [1,0]) xs

booleansToNumberList bs = map ( (subtract 1) . length ) . groupBy (==) $ bs
