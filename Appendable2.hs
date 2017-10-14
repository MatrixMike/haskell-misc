{-# OPTIONS_GHC -fwarn-missing-signatures #-}

data BinaryTree a
  = Branch (BinaryTree a)
           (BinaryTree a)
  | Leaf a
  deriving (Show, Ord, Eq)

prepend :: a -> BinaryTree a -> BinaryTree a
prepend a b = concatenateTrees (Leaf a) b

append :: a -> BinaryTree a -> BinaryTree a
append a b = concatenateTrees b (Leaf a)

concatenateTrees :: BinaryTree a -> BinaryTree a -> BinaryTree a
concatenateTrees a b = Branch a b

fromList :: [a] -> BinaryTree a
fromList (x:xs) = foldl (flip append) (Leaf x) xs

main :: IO ()
main = print $ (\x -> concatenateTrees x x) (fromList "ab")

sumTree :: Num p => BinaryTree p -> p
sumTree (Branch x y) = sumTree x + sumTree y
sumTree (Leaf x) = x

eg2 :: Integer
eg2 = sumTree $ concatenateTrees (fromList [1, 2]) (fromList [3, 4])

eg3 :: [Integer]
eg3 = treeToList $ concatenateTrees (fromList [1, 2, 3]) (fromList [10, 20])

{-
treeToList tree = (treeToList' tree) []
treeToList' (Branch x y) = \z -> (treeToList' x) ((treeToList' y) z)
treeToList' (Leaf x) = \y -> x :y 
-}
data TreeZipper a =
  TreeZipper (BinaryTree a)
             (BinaryTree a)

treeToList :: BinaryTree a -> [a]
treeToList tree = treeToList' [] tree

treeToList' :: [a] -> BinaryTree a -> [a]
treeToList' s (Branch x y) = treeToList' (treeToList' s x) y
treeToList' s (Leaf x) = x : s

{-
in repl try fromList [6,1,2,3,4,5]
-}

