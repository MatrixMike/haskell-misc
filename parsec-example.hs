{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.ParserCombinators.Parsec
import Control.Monad
 
arbitaryCoin = do 
 x <- string "("
 y <- manyTill ( arbitaryCoin <|>  (anyChar >>= return . (:[])) ) (string ")") 
 return (x++(concat y)++")")
  
parser = do
  b <- many1 arbitaryCoin 
  eof
  return (concat b)
  
main = print $ map (parse parser "") [ "((((dd))))" , "(((())))" ,"()()"]
fail =  print $ map (parse parser "") ["(((()))"]
