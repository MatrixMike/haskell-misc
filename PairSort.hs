{-# Language NoMonomorphismRestriction #-} 

module PairSort where

import Prelude
import qualified Data.List

consAsPair n xss = case xss of 
                [[]] -> [[n]]
                ([x]:xs) -> [n,x]:xs
                _ -> [n] : xss

groupAdjacent = foldr consAsPair [[]]

groupAdjacentRightLoping = reverse . groupAdjacent . reverse

invertAdjacent xs = invertAdjacent' (groupAdjacent xs)
invertAdjacent' ([x,y]:xs) = [[x]] ++ (groupAdjacentRightLoping (y:concat xs))
invertAdjacent' ([x]:[y,z]:xs) = [[x,y]] ++ groupAdjacentRightLoping (z: concat xs)
invertAdjavent' xs = xs

sortingPass  = concat . map Data.List.sort . invertAdjacent . concat . map Data.List.sort . groupAdjacent
converge f = until (\x -> f x == x) f

sort = converge sortingPass
