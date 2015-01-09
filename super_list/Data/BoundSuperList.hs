{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE NoMonomorphismRestriction #-}


{- this family of types provides list data types of custom nesting . This, through use of typeclasses facilitates the writing of polymorphic functions which act on any level of nesting while still retaining strong type information -}

module Data.SuperList.BoundSuperList where 

import qualified Data.List as Data.List
import Prelude hiding (head,last)

class SuperList f a where 
 toList1 :: f a -> [a]
 toList2 :: f a -> List2 a
 append :: f a -> f a -> f a

head1 = Data.List.head . toList1 
last1 = Data.List.last . toList1 

data List2 a = List2 [[a]]
  deriving Show
data List3 a = List3 [List2 a]
  deriving Show
data List4 a = List4 [List3 a]
  deriving Show
data List5 a = List5 [List4 a]
  deriving Show

makeList2 = List2
makeList3 = List3 . map makeList2
makeList4 = List4 . map makeList3
makeList5 = List5 . map makeList4

toList1' = concatMap toList1
toList2' x = foldl append (List2 []) (map toList2 x)

instance SuperList [] a where
 toList1 = id 
 toList2 x = List2 [x]
 append = (++)

instance SuperList List2 a where
 append (List2 x) (List2 y) = List2 (append x y)
 toList1 (List2 x) = toList1' x
 toList2 = id

instance SuperList List3 a where
 append (List3 x) (List3 y) = List3 (append x y)
 toList1 (List3 x) = toList1' x
 toList2 (List3 x) = toList2' x

instance SuperList List4 a where
 append (List4 x) (List4 y) = List4 (append x y)
 toList1 (List4 x) = toList1' x
 toList2 (List4 x) = toList2' x

instance SuperList List5 a where
 append (List5 x) (List5 y) = List5 (append x y)
 toList1 (List5 x) = toList1' x
 toList2 (List5 x) = toList2' x
