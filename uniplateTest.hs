--import Data.Generics.Uniplate.Direct 

import Data.Generics.PlateDirect

data MyList = MyCons Char MyList 
            | MyEnd
  deriving Show



example = MyCons 'a' (MyCons 'b' MyEnd)
eg =  descend id example


instance Uniplate MyList where 
  uniplate (MyCons str rest) = (Two Zero (One rest),\(Two Zero (One rest)) -> (const $ MyCons str) Zero rest)
  uniplate MyEnd =  (Zero, const MyEnd)
  



