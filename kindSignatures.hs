{-# Language KindSignatures #-}
                                                                                                                                                                                                                   
class MMonad (m :: * -> *) where                                                                                                                                                                                   
  rreturn :: a -> m a                                                                                                                                                                                              
  bind :: m a -> (a -> m b) -> m b                                                                                                                                                                                 
  tthen :: m a -> m b -> m b
