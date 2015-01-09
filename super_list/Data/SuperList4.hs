
{- doesn't work  -}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverlappingInstances #-}

class SuperList f a where
 map :: (a -> b) -> f a -> f b  

type List = []
type ListList = List List

{-
instance SuperList (ListList a) where
  map f xs = undefined
-}

instance Functor [[]] where
  fmap f xs = undefined

