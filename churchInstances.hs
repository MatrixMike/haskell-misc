{-# OPTIONS_GHC -fwarn-missing-signatures #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}

import Data.Monoid

main :: IO()
main =
  print
    [ 2 (+ (1 :: Integer)) (1 :: Integer) :: Integer
    , appEndo (appEndo 1 (Endo (+ 1))) 1
    ]

instance Num ((r -> r) -> r -> r) where
  m + n = \f x -> m f (n f x)
  m * n = \f -> m (n f)
  fromInteger 0 = \f x -> x
  fromInteger 1 = \f x -> f x
  fromInteger n = 1 + fromInteger (n - 1)

eg = appEndo (appEndo 1 (Endo (+ 1))) 1

instance Num (Endo (Endo r)) where
  fromInteger 0 = Endo (\(Endo f) -> (Endo (\x -> x)))
  fromInteger 1 = Endo (\(Endo f) -> (Endo (\x -> f x)))
  fromInteger n = 1 + fromInteger (n - 1)
  (Endo m) + (Endo n) = Endo (\(Endo f) -> (Endo (\x -> f x)))
  {-
  m * n = \f -> m (n f)
  -}
