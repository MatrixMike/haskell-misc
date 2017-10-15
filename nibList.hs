{-# OPTIONS_GHC -fwarn-missing-signatures #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleInstances #-}

import Data.List

data NibList a = Node a (NibList a) | Nib (NibList a)
  deriving (Eq, Read,Ord)

instance Show a => Show (NibList a) where
  show a = showNib False (lengthNib a+1) a

showNib _ 0 _ = ""
showNib b x (Node a nl) = if b then "("++t++")" else t
  where t =  "Node " ++ show a ++ showNib True (x-1) nl
showNib b x (Nib nl) = if b then  "("++t++")" else t
  where t = "Nib" ++ showNib True (x-1) nl

lengthNib       (Nib nl) = lengthNib'' nl
lengthNib             nl = lengthNib' nl
lengthNib'   (Node a nl) = lengthNib' nl
lengthNib'      (Nib nl) = lengthNib'' nl
lengthNib''  (Node _ nl) = 1 + lengthNib'' nl
lengthNib''      (Nib _) = 0

applyNTimes f n x = iterate f x !! n

tailNib (Nib nl) = nl
tailNib (Node _ nl) = nl

emptyNib = Nib emptyNib :: NibList Int

main = print emptyNib

nibList = Node 1 (Node 2 (Nib nibList))
nibList2 = Node 1 (Node 2 (Nib (Node 3 nibList2)))
nibList3 = Node 1 (Node 2 (Node 8 (Nib nibList3)))
nibList4 = Nib (Node 2 (Node 8 nibList4))

tests = do
        let a = Nib (a) in print $ (lengthNib a == 0) == True
        let a = Nib (Node 1 a) in print $ (lengthNib a == 1) == True
        let a = Node 1 (Nib (Node 2 a)) in print $ (lengthNib a == 2) == True



