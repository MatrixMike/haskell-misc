{-# OPTIONS_GHC -fwarn-missing-signatures #-}
import Data.Tree
import Data.List
import QuickTrace
import Control.Arrow
import Data.Either

printPeano e =  putStrLn $ drawTree $ fmap show e

type PeanoRoseTree = Tree ()
example = Node () [Node () [Node () [Node () [Node () [Node () []]],Node () []]],Node () [Node () [],Node () [],Node () [],Node () [],Node () [],Node () [],Node () [],Node () [],Node () [],Node () []]]

drawTreeAsSExpression (Node r s) = "(" ++ (concatMap drawTreeAsSExpression s) ++ ")"


main = do
       let sstring = drawTreeAsSExpression example
       let (Right (peanoTree,_)) = readPeano sstring
       let sstring' = drawTreeAsSExpression peanoTree
       print sstring
       print peanoTree
       print sstring'
       printPeano example
       printPeano peanoTree
       print (sstring == sstring')
       


isRight (Right x) = True
isRight _ = False

fromRight (Right x) = x
                  
readPeano ('(':')':_) = Right (Node () [] ,2)
readPeano ('(':xs) = do
        let innards = readMulti (combineParsers (fmap (first Right) .  readPeano) ( fmap (first Left) . readEndingBracket)) xs
        let rightInnards = rights $ takeWhile  (isRight. fst . fromRight) innards
        return (Node () (map ( fromRight . fst) rightInnards), sum (map snd rightInnards) + 2)
        
        
readPeano _ = Left ""

readEndingBracket (')':_) = Right ((),1)
readEndingBracket _ = Left ""


readPeanoTreeOrEndOfList  = (combineParsers (fmap (first Right) .  readPeano) ( fmap (first Left) . readEndingBracket))

readMultiSummated x y =  concatParsings $ readMulti x y

concatParsings = foldr conjoin (Right ([],0))
        where conjoin (Right (x,y)) (Right (x',y')) = Right ((x:x'),y+y')
  
  
readMulti _ [] = []
readMulti parser xs = case parser xs of    
        q@(Right (_,y)) -> q : readMulti parser (drop (fromIntegral y) xs)
        (Left _) -> [{-Left ((),length xs)-}]
          
      
      
combineParsers p1 p2 xs = case p1 xs of 
                            Right a -> Right a
                            Left x -> case p2 xs of
                                        Right b -> Right b
                                        Left x2 -> Left (x ++ " and " ++ x2)
