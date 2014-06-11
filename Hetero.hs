{-# LANGUAGE GADTs #-}

data Hetero where
  Cons :: Show b => b -> Hetero -> Hetero
  Empty :: Hetero

instance Show Hetero where
 show (Cons x m)  = show x ++ show m
 show Empty  = ""
