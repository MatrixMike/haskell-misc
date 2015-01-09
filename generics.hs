{-# OPTIONS_GHC -XDeriveDataTypeable #-}
import Data.Generics

data Expr = Var String
          | Lit Int
          | Call String [Expr]
            deriving (Data, Typeable,Show)

data Stmt = While Expr [Stmt]
          | Assign String Expr
          | Sequence [Stmt]
            deriving (Data,Typeable,Show)

extractLits :: Data a => a -> [Int]
extractLits = everything (++) ([] `mkQ` f)
     where f (Lit x) = [x]
           f _ = []
           
myStatement = While (Lit 1) [
                 Assign "myvar" (Lit 2)
                ,Assign "myvar2" (Var "myvar")
              ]
main = do
       print myStatement
       print $ extractLits myStatement
