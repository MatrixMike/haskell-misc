{-# OPTIONS_GHC -fwarn-missing-signatures #-}
module MiniLang where

data MiniLang = MLWord String | MLInt Int | MLOp MiniOp
    deriving(Read)

data MiniOp = Plus | Minus
    deriving(Read)
    
instance Show MiniLang where 
  show (MLWord xs) =  xs
  show (MLInt i) = (show i)
  show (MLOp i) = (show i)
  
  
instance Show MiniOp where
  show Plus = "+"
  show Minus = "-"
