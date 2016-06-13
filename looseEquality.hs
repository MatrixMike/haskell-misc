{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverlappingInstances #-}
{-# LANGUAGE IncoherentInstances #-}


import Prelude hiding ((==))
import qualified Prelude as P 

class MyEq a b where
  (==) :: a -> b -> Bool

instance ( Num a, Eq a) => MyEq a [Char] where
  0 == "" = True
  _ == _ = False 

instance ( Real a, Real b) => MyEq a b where
  a == b = realToFrac a P.== realToFrac b
  

{-
0 == "" 
=> True

0 == 1.0
=> False
-}
