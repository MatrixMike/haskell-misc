{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE GADTs #-}

data Nat = S Nat | Z

data Vec :: Nat -> * where
  Nil  :: Vec Z
  Cons :: Int -> Vec n -> Vec (S n)

a = Cons 1 (Cons 2 Nil)

-- *Main> :t a
-- a :: Vec ('S ('S 'Z)) 
