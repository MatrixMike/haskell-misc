{-# Language NoMonomorphismRestriction #-}

import Data.Array
import Text.ParserCombinators.Parsec
import System.IO.Unsafe
import Data.Tree
import Data.Maybe
import Control.Monad
import Data.Char

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
 

exampleSource = filter (/=' ') $ unsafePerformIO (readFile "../brainf---/zero-to-nine.bf")

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

myParser = sepBy (many (try doUntilZero <|> try ops)) newline >>= return . Node Program . concat

exampleAst = parse myParser "" exampleSource

initArray = listArray (0,1000) (replicate 1000 0)

runAst = runAst' (0,initArray) ((\(Right x) -> x) exampleAst) >> return ()

runAst' (cursor,array) l@(Node DoUntilZero xs) = 
  if (array!cursor == 0) then do
                              return (cursor,array) 
                         else do 
                              s <- foldM runAst' (cursor,array) xs 
                              runAst' s l
runAst' (cursor,array) (Node Program xs) = foldM runAst' (cursor,array) xs
runAst' (cursor,array) (Node Increment _) = do putStr "" >> return (cursor,array// [(cursor,array!cursor +1)])
runAst' (cursor,array) (Node Decrement _) = do putStr "" >> return (cursor,array// [(cursor,array!cursor -1)])
runAst' (cursor,array) (Node ShiftLeft _) = do putStr "" >> return (cursor-1,array)
runAst' (cursor,array) (Node ShiftRight _) = do putStr "" >> return (cursor+1,array)
runAst' (cursor,array) (Node GetChar _) = do getChar >>= \c -> return (cursor,array // [(cursor,ord c)])
runAst' (cursor,array) (Node PutChar _) = do putChar (chr$ array ! cursor) >> return (cursor,array)



