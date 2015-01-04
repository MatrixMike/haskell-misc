{-# Language NoMonomorphismRestriction #-}

import Data.Array
import Text.ParserCombinators.Parsec
import System.IO.Unsafe
import Data.Tree
import Data.Maybe

data BrainStarOp = 
   Program 
 | Increment 
 | Decrement
 | ShiftLeft
 | ShiftRight
 | PutChar
 | GetChar
 | DoUntilZero
 deriving (Show,Read)

exampleSource = unsafePerformIO (readFile "../brainf---/d.bf")

opDefs = [('+',Increment)
       ,('-' , Decrement)
       ,(',' , GetChar)
       ,('.' , PutChar)
       ,('<' , ShiftLeft)
       ,('>' , ShiftRight)
      ]

ops = oneOf (map fst opDefs) >>= \x -> return $ Node (fromJust $ lookup x opDefs) []

doUntilZero = do
  char '['
  (Node Program x) <- myParser  
  char ']'
  return (Node DoUntilZero x)  

myParser = many (ops <|> try doUntilZero) >>= return . Node Program

exampleAst = parse myParser "" exampleSource


