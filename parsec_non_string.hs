{-# LANGUAGE FlexibleContexts #-}

import Text.ParserCombinators.Parsec

import Data.Char
import Text.Parsec.Pos
import Text.Parsec.Prim
import Control.Monad

q =  case (parse (mapM char "hello") "" "hello") of
        Right x -> True
        Left _ ->  False

g = case (parse (bool False >> sequence (replicate 3 (bool True)) ) [] [False,True,True,True]) of
        Right x -> True
        Left _ ->  False

main = do
 print q
 print g

bool c = satisfy' (==c)

satisfy' :: (Stream s m Bool) => (Bool -> Bool) -> ParsecT s u m Bool
satisfy' = (\f -> tokenPrim (const []) (\x y z->x) (\t -> if f t then Just t else Nothing))
