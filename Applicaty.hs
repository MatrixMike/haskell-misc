module Applicaty where

 -- define applicatives in terms of monads

import Control.Monad

class (Monad m,Functor m) => Applicaty m where
  app :: m (a->b) -> m a -> m b
  app x y = join (fmap (\z -> fmap z y) x)
  purey :: a -> m a
  purey = return

instance Applicaty [] where

