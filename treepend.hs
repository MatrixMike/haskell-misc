
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


listToTree (x:xs) = foldl (\tree v-> Node v [tree]) (Node x []) (reverse xs)
