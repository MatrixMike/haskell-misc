{-# LANGUAGE MultiParamTypeClasses #-}  
{-# LANGUAGE FlexibleInstances #-}  

module Isomorphism where

import Data.Array

class Isomorphism a b where
 from :: a -> b
 to :: b -> a
 
instance Isomorphism Bool Float where
  from True = 1.0
  from False = 0.0
  to 1.0 = True
  to 0.0 = False


instance Isomorphism [a] (Array Int a) where
  from xs = array (0,length xs-1) (zip  [0..] xs)
  to array = elems array
  
  {- example from [1,2,3::Integer] :: Array Int Integer -}
