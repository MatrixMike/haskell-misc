data BinaryTree a = Branch (BinaryTree a) (BinaryTree a) | Leaf a
 deriving (Show,Ord,Eq)

prepend a b = concatenateTrees (Leaf a) b 
append a b = concatenateTrees b (Leaf a)

concatenateTrees a b = Branch a b

fromList (x:xs) = foldl (flip append) (Leaf x) xs

main = print $ (\x -> concatenateTrees x x) (fromList "ab")

sumTree (Branch x y) = sumTree x + sumTree y 
sumTree (Leaf x) = x

eg2 = sumTree $ concatenateTrees (fromList [1,2]) (fromList [3,4])
eg3 = treeToList $ concatenateTrees (fromList [1,2,3]) (fromList [10,20])

treeToList tree = (treeToList' tree) []
treeToList' (Branch x y) = \z -> (treeToList' x) ((treeToList' y) z)
treeToList' (Leaf x) = \y -> x :y 

data TreeZipper a = TreeZipper (BinaryTree a) (BinaryTree a)




