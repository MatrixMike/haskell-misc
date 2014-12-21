{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleInstances #-}

import Data.List

data NibList a = Node a (NibList a) | Nib (NibList a) 
 deriving (Eq, Read,Ord)

instance Show a => Show (NibList a) where  
  show (Nib _) = "Nib"
  show a@(Node _ _) = showNib False (lengthNib a+1) a

showNib _ 0 _ = ""
showNib b x (Node a nl) = if b then "("++t++")" else t
  where t =  "Node " ++ show a ++ showNib True (x-1) nl  
showNib b x (Nib nl) = if b then  "("++t++")" else t
  where t = "Nib" ++ showNib True (x-1) nl  

lengthNib  (Node a nl) = lengthNib nl
lengthNib  (Nib nl) = lengthNib' nl
lengthNib' (Node _ nl) = 1 + lengthNib' nl
lengthNib' (Nib _) = 0

nibList = Node 1 (Node 2 (Nib nibList))
nibList2 = Node 1 (Node 2 (Nib (Node 3 nibList)))

emptyNib = Nib emptyNib :: NibList Int

main = print emptyNib
