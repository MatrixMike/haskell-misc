data BinaryTree a = Branch (BinaryTree a) (BinaryTree a) | Leaf a
 deriving (Show,Ord,Eq)

prepend a b = concatenateTrees (Leaf a) b
append a b = concatenateTrees b (Leaf a)

concatenateTrees a b = Branch a b

fromList (x:xs) = foldr prepend (Leaf x) xs

main = print $ (\x -> concatenateTrees x x) (fromList "ab")
