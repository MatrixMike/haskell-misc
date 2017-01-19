{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}

import Data.Monoid

type Church = forall r. (r -> r) -> (r -> r)

instance Num ((r -> r) -> r -> r) where
  m + n = \f x -> m f (n f x)
  m * n = \f -> m (n f)
  fromInteger 0 = \f x -> x
  fromInteger 1 = \f x -> f x
  fromInteger n = 1 + fromInteger (n-1)

instance Num (Endo (Endo r)) where
  fromInteger 1 = Endo (\(Endo f) -> (Endo (\x -> f x)))
  {-
  m + n = \f x -> m f (n f x)
  m * n = \f -> m (n f)
  fromInteger 0 = \f x -> x
  fromInteger n = 1 + fromInteger (n-1)
  -}

