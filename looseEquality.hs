

{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

import Prelude hiding ((==))
import qualified Prelude as P 

class MyEq a b where
  (==) :: a -> b -> Bool

instance ( Num a, Eq a) => MyEq a [Char] where
  0 == "" = True
  _ == _ = False 
