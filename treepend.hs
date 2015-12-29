
import Data.Tree


treePrepend tree@(Node v1 _) v2 = Node v2 [tree]

listToTree xs = foldr (flip treePrepend) (Node (last xs) []) (init xs)


listOverTree xs'@(x:xs) (Node x' ts) 
  | (x == x') = if (x `elem` (map rootLabel ts)) then (Node x' (map (listOverTree xs) ts))
                                                 else (Node x' ((listToTree xs):ts))
  | otherwise = (Node x' ((listToTree xs'):ts))
listOverTree [] tree = tree



treeToList (Node x []) = [x] 
treeToList (Node x xs) = x : concatMap treeToList xs



