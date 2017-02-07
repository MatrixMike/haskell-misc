module Binary where

import Control.Monad
import Data.List

binariesPatterns =   map (\n -> replicateM n [0,1]) $ [1..]

grayCodes = iterate (\xs -> map (0:) xs ++ map (1:) (reverse xs)) [[]]

convert_binary_to_gray xs = zipWith (/=) xs (tail xs)

binaryNumbers = concat $ [[0]] : iterate (\xs -> map (1:) ((map ((0:) . tail) xs) ++ xs )) [[1]]
binaryNumbers' = concat $  zipWith (\xs x -> (drop (2^x) xs)) binariesPatterns [0..]



