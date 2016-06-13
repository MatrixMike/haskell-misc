{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverlappingInstances #-}
{-# LANGUAGE IncoherentInstances #-}
{-# LANGUAGE UndecidableInstances #-}

class Truthy a where
  truthy :: a -> Bool
   
instance Truthy Bool where 
  truthy = id
 
instance (Num a,Eq a) => Truthy a where 
  truthy = (/= 0)
  
instance (Num a,Eq a) => Truthy [a] where 
  truthy = not . null
