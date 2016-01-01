--import Data.Generics.Uniplate.Direct 

--import Data.Generics.PlateDirect
import Data.Generics.Uniplate.Direct
import Data.Generics.Uniplate.Operations
import Data.Char
import Control.Monad.IO.Class

data MyList = MyCons Char MyList 
            | MyEnd
  deriving Show

example = MyCons 'a' (MyCons 'b' (MyCons 'c' MyEnd))

former (MyCons a rest) = MyCons (toUpper a) (former rest)
former x = x

eg = transform former example
eg2 = transformM (\x -> print 1 >> return x) example

instance Uniplate MyList where 
  uniplate (MyCons str rest) = plate (MyCons str) |* rest
  uniplate MyEnd =  plate MyEnd



{-
instance Uniplate MyList where 
  uniplate (MyCons str rest) = (Two Zero (One rest),\(Two Zero (One rest)) -> (const $ MyCons str) Zero rest)
  uniplate MyEnd =  (Zero, const MyEnd)
-}
  



