{-# LANGUAGE RankNTypes #-}

b :: (forall a. Show a=> a -> String) -> (String, String)
b f = (f 1, f 'v')
