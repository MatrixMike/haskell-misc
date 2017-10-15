{-# LANGUAGE RankNTypes #-}
{-# OPTIONS_GHC -fwarn-missing-signatures #-}


b :: (forall a. Show a=> a -> String) -> (String, String)
b f = (f 1, f 'v')
