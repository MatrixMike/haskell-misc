module Read_lambda where

import Data.Char 
import Data.Either

import Lambda_data_types

readLambdaExpression :: String -> LambdaExpression
readLambdaExpression str = either error id (readLambda str)

readLambda :: [Char] -> Either [Char] LambdaExpression
readLambda xs = readParens xs >>= readLambda'    

readLambda' :: [Char] -> Either [Char] LambdaExpression
readLambda' [] = Left "readLambda': empty List"
readLambda' (x:xs) | x == '\\' = do 
                                 (vars,bindings) <- readLambda'' (span (/='-') xs)
                                 argvars <- readVariables vars
                                 bounds <- readBoundVariables bindings
                                 return (Lambda argvars bounds)
                   | otherwise = Left "readLambda': lambda' should start with backslash '\\'"
          
readLambda'' :: (String,String) -> Either String (String,String)
readLambda'' (xs,('-':'>':ys)) = Right (xs,ys)
readLambda'' _ = Left "readLambda'': lambda should contain ->"

readBoundVariables :: [Char] -> Either [Char] Binding
readBoundVariables xs = readParens xs >>= readBoundVariables'

readBoundVariables' :: [Char] -> Either [Char] Binding
readBoundVariables' xs = do {
                            freeVars <- readFreeVariables xs;
                            return (BoundVariables freeVars);
                            }

readFreeVariables xs = do 
    vars <- readVariables xs
    return (map FreeVariable vars)

readVariables :: [Char] -> Either [Char] [Variable]
readVariables [] = Left "readVariables: empty List"
readVariables (x:xs) | isAlpha x = do { r <- readSpaced' readVariables xs ; return (Variable x : r) } 
                     | otherwise = Left ("readVariables: Should be alphabetical. Given"++[x])

readVariable :: [Char] -> Either String Variable
readVariable (x:xs) | isAlpha x = Right (Variable x)
                    | otherwise = Left ("readVariable: Should be alphabetical. Given "++[x])

readSpaced' :: ([Char] -> Either [Char] [a]) -> [Char] -> Either [Char] [a]
readSpaced' continue [] = Right []
readSpaced' continue (x:xs) | isSpace x = continue xs
                            | otherwise = Left "readVariables': Variables should be seperated by spaces"

readParens :: [Char] -> Either [Char] [Char]
readParens [] = Left "readParens: empty List"
readParens (x:xs) | x == '(' = readParenEnd xs
                  | otherwise = Left "readParens: parens should start with '('"

readParenEnd :: [Char] -> Either [Char] [Char]
readParenEnd [] = Left "readParensEnd: empty List"
readParenEnd xs = readParenEnd' (reverse xs)

readParenEnd' :: [Char] -> Either [Char] [Char]
readParenEnd' (y:ys) | y == ')' = (Right (reverse ys))
                     | otherwise = Left "readParensEnd': parens should end with ')'"