module ReadMiniLang where

import Data.Char
import Data.Either
import Data.List
import Control.Monad
import Control.Arrow
import MiniLang
import ParseFunctions

readMLWord str = case readMLWord' str of
  [] -> Left "readMLWord: No word"
  a -> Right (MLWord a,length a)
readMLWord' str = takeWhile isAlpha str

readMLInt str = case readMLInt' str of
  [] -> Left "readMLInt: No Int"
  a -> Right (MLInt (read a),length a)
readMLInt' str = takeWhile isDigit str

readMLOp str = case str of
    ('+':_) -> Right (MLOp Plus,1)
    ('-':_) -> Right (MLOp Minus,1)
    _ -> Left "readMLOp: No operator"
    
readSpacing str = case takeWhile isSpace str of 
  [] -> Left "readSpacing: No spacing"
  a -> Right (a,length a)
  
readComment xs = case xs of
  (a:b:xs) | [a,b] == "/*" -> case  readComment' [a,b] xs of 
        Right q -> Right q
        _ -> Left "readComment: No comment"
  _ -> Left "readComment: should start with /*"

  
readComment' ys xs = do { comment <- readComment'' ys xs ; return (comment,length comment) }
readComment'' comment xs = case xs of
    (a:b:_) | [a,b] == "*/" -> Right (comment ++ [a,b])
    (x:xs) -> readComment'' (comment ++ [x]) xs
    _ -> Left "readCommentEnd: no comment"
  


readMLIntOrWordOrOp = readListOfParsers [readMLInt,readMLWord,readMLOp]

readMLIntOrWordOrOpWithOrSpacingOrComment =  combineParsers (liftM (fmap (first Left)) readSpacingOrComment) (liftM (fmap (first Right)) readMLIntOrWordOrOp) 

readSpacingOrComment = combineParsers readSpacing readComment