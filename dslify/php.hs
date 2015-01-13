{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE NoMonomorphismRestriction #-}

import Data.List
import Data.Monoid

data PHP = Doc [Statement]

data Statement = Echo Arg
               | CallFunction String [Arg]

data Arg = ArgVar Var 
         | ArgString String
         | ArgInt Int

data Var = Var String

renderPHP (Doc statements) = "<?php\n" ++ concat (intersperse "\n" (map renderStatement statements)) ++ "\n?>"

demarkedStatement = (++";")

renderStatement (Echo x) = demarkedStatement $ "echo " ++  renderArg x 

renderArg (ArgString x) = "\"" ++ x ++ "\""
renderArg (ArgInt x) = show x

class ToArg a where
  toArg :: a -> Arg

instance ToArg Int where
  toArg = ArgInt

instance ToArg [Char] where
  toArg = ArgString

echo = Echo . toArg

doc = Doc

example = doc $ 
      [echo (1::Int)]
   <> [echo "hi"]

main = putStrLn $ renderPHP example

