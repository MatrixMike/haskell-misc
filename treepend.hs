
import Data.Tree
import Control.Monad.Writer
 
treePrepend tree@(Node v1 _) v2 = Node v2 [tree]

listToTree xs = foldr (flip treePrepend) (Node (last xs) []) (init xs)

listOverTree xs'@(x:xs) (Node x' ts) 
  | (x == x') = if (x `elem` (map rootLabel ts)) 
                then (Node x' (map (listOverTree xs) ts))
                else (Node x' ((listToTree xs):ts))
  | otherwise = (Node x' ((listToTree xs'):ts))
listOverTree [] tree = tree

treeToLists tree = map reverse $ treeToLists' [] tree
treeToLists' buf (Node x []) = [x:buf]
treeToLists' buf (Node x xs) = concatMap (treeToLists' (x:buf)) xs

treeMerge tree1 tree2 = foldr listOverTree tree1 (treeToLists tree2)

tree1 = (Node 1 [Node 2 [],Node 3 [Node 4 []]])

tree2 = (Node 1 [Node 2 [Node 20 [Node 200 []] , Node 22 [Node 220 []] ]])

main = print $ treeMerge tree1 tree2