{-# OPTIONS_GHC -fwarn-missing-signatures #-}
import Data.Tree
import Data.List

instance Ord a => Ord (Tree a) where
  compare (Node x xs) (Node y ys) = case compare x y of
    LT -> LT
    GT -> GT
    EQ -> compare xs ys

tree1 :: Tree Integer
tree1 = Node 1 [
  Node 2 [],Node 3 [ Node 5 [] , Node 4 []]
  ]
tree2 :: Tree Integer
tree2 = Node 1 [
  Node 2 [],Node 3 [ Node 4 [] , Node 5 []]
  ]

main :: IO()
main = mapM_ putStrLn $ map drawTree $ map (fmap show) $ sort [tree1,tree2]

-- main = mapM_ (putStrLn . map . drawTree . fmap show)  (sort [tree1,tree2])
