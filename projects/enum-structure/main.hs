{-# LANGUAGE NoMonomorphismRestriction #-}
import Data.List 
import Data.Tree
import Control.Monad
import Data.Functor
import QuickTrace

data BinaryTree = BNode (Maybe BinaryTree) (Maybe BinaryTree)
 deriving (Show ,Eq)

allTrees = concatMap generateTrees [1..]

generateTrees depth = case depth of
  --1 -> [ BNode Nothing Nothing ]
  _ -> concat [
           [
             BNode side1 side2 | side1 <- if d1 == 0 then [Nothing] else map Just (generateTrees d1)
                               , side2 <- if d2 == 0 then [Nothing] else map Just (generateTrees d2)
           ]
           | d1 <- [0..depth-1]
           , d2 <- [0..depth-1]
           , d1 + d2 == depth - 1
       ]

genTrees depth = case depth of 
  0 -> []
  1 -> [Node () []]
  2 -> [Node () [Node () []]]
  _ -> let dists' = dists d
           d = depth - 1 
       in  concatMap (map (\x -> Node () x)) (dists_ dists')


dists_ :: [[Int]] -> [[[Tree ()]]]
dists_ ds = (map sequence $ map (map genTrees) ds)
dists d = nub $ filter (  (==(d)) . sum) $ map (filter (not. (==0)) )$  replicateM (d) ([0..(d)])

draw = mapM_ putStrLn . map drawTree . map (fmap show) 

allTrees2 = concat (map genTrees [1..])


