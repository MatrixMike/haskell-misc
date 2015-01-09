{-# LANGUAGE NoMonomorphismRestriction #-}

module Data.SuperList.UnboundSuperList where 

{- functions for flattening trees to lists of different nesting levels -}

import qualified Data.List as Data.List
import Prelude hiding (head,last)
import Data.Tree
import Data.Maybe
import System.Random

flatten' (Node x xs) = [x] ++ concatMap flatten' xs

fromSuperList1 = catMaybes . flatten'
fromSuperList2 (Node x xs) = map fromSuperList1 xs
fromSuperList3 (Node x xs) = map fromSuperList2 xs
fromSuperList4 (Node x xs) = map fromSuperList3 xs

toNode x = Node (Just x) []
makeSuperList1 xs = Node Nothing (map toNode xs)
makeSuperList2 xs = Node Nothing (map makeSuperList1 xs)
makeSuperList3 xs = Node Nothing (map makeSuperList2 xs)
makeSuperList4 xs = Node Nothing (map makeSuperList3 xs)

infinTree = Node (Just 1) (repeat infinTree)

randomInfinTree = newStdGen >>= return . randomInfinTree'
randomInfinTree' g = Node (Just $ fst $ random g1) (map randomInfinTree' (iterate (snd.next) g2))
  where (g1,g2) = split g

takeDepth 0 (Node a _) = Node a []
takeDepth x (Node a children) = Node a (map (takeDepth (x-1)) children)
