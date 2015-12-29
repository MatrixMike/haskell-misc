
import Data.Tree


{-
listToTree xs@(x:_) = Just v
  where [v] = listToTree' xs
listToTree [] = Nothing
listToTree' (x:xs) = [Node x (listToTree' xs)]
listToTree' [] = []
-}




{-
listToTree xs@(x:_) = v
  where [v] = listToTree' xs
listToTree [] = error "Empty List"
listToTree' (x:xs) = [Node x (listToTree' xs)]
listToTree' [] = []
-}

treePrepend tree@(Node v1 _) v2 = Node v2 [tree]

listToTree xs = foldr (flip treePrepend) (Node (last xs) []) (init xs)

treeToList (Node x []) = [x] 
treeToList (Node x xs) = x : concatMap treeToList xs


-- treePend (Node x xs) (Node x' xs) = if x == 


-- zipBy p xs ys = xs >>= \x -> return $ filter (p x) ys



pairBy p xs = map (pairBy' p) (take (length xs) (iterate rotate xs))
pairBy' p (x:xs) = pairBy'' p x xs
pairBy'' p x xs = (x,filter (p x) xs)
rotate (x:xs) = xs ++ [x]
