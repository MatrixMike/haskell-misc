{-# LANGUAGE MultiParamTypeClasses #-}  
{-# LANGUAGE FlexibleInstances #-} 
{-# LANGUAGE NoMonomorphismRestriction #-} 
{-# LANGUAGE IncoherentInstances #-}

module Isomorphism where

import Data.Array

class Isomorphism a b where
 to :: a -> b
 from :: b -> a

isomorphic :: (Eq a,Eq b,Isomorphism a b) => a -> b -> Bool
isomorphic a b = to a == b || a == from b
  
instance Enum a => Isomorphism a Bool where
  to = toEnum . fromEnum
  from = toEnum . fromEnum
  
instance Isomorphism [a] Bool where
  to [] = False
  to _ = True
  from True = (undefined:[])
  from False = []
 
instance Isomorphism [a] (Array Int a) where
  to xs = array (0,length xs-1) (zip  [0..] xs)
  from array = elems array
  
main = do 
  print (from False::[Int])
  print (0.0 `isomorphic` False)
  print ([8::Int] `isomorphic` listArray (0,0::Int) [8::Int])
