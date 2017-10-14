{- This is a work in progress -}
{-# OPTIONS_GHC -fwarn-missing-signatures #-}
{-# Language NoMonomorphismRestriction #-}
import Data.List.Split
import Data.List
import Control.Monad
import Data.Maybe
import Control.Monad.ST
import Data.STRef

horizontals = chunksOf 9 
verticals = transpose . chunksOf 9
squares =  
       concat 
     . map (map concat) 
     . map (chunksOf 3) 
     . transpose 
     . map (chunksOf 3) 
     . horizontals 

checkAreas f xs = all (all (==True)) (checkAreas' f xs)

checkAreas' f xs = map (map f) [verticals xs,horizontals xs,squares xs]

checkValidSudoku = checkAreas validArea 

validArea xs = length (nub xs) == length xs

if' True x y = x 
if' False x y = y

predicateToMaybe p v = case p v of 
   True -> Just v
   False -> Nothing
   
maybeToEither (Just x) = Left x
maybeToEither Nothing = Right ()

solver = head . solver'1

solver'1 xs = runST $ do
  result <- newSTRef []
  forM xs $ \v -> do

  return (filter checkValidSudoku $ sequence $ solver'2 xs)

solver'2 = map (either ((:[]) . id) (const [1..9])) . solver'3
solver'3 = map maybeToEither . solver'4
solver'4 = map (predicateToMaybe (not . (==0)))

sudokuMissing8 = concat [
	 [0,0,0,0,0,0,0,0,1]
	,[9,3,8,1,2,6,5,4,7]
	,[4,1,2,7,9,5,3,6,8]
	,[6,8,9,3,7,2,1,5,4]
	,[7,4,3,6,5,1,8,2,9]
	,[1,2,5,8,4,9,6,7,3]
	,[2,5,4,9,3,8,7,1,6]
	,[3,7,1,2,6,4,9,8,5]
	,[8,9,6,5,1,7,4,3,2]
  ]

sudokuMissing7 = concat [
	 [0,0,0,0,0,0,0,9,1]
	,[9,3,8,1,2,6,5,4,7]
	,[4,1,2,7,9,5,3,6,8]
	,[6,8,9,3,7,2,1,5,4]
	,[7,4,3,6,5,1,8,2,9]
	,[1,2,5,8,4,9,6,7,3]
	,[2,5,4,9,3,8,7,1,6]
	,[3,7,1,2,6,4,9,8,5]
	,[8,9,6,5,1,7,4,3,2]
  ]

sudokuMissing6 = concat [
	 [0,0,0,0,0,0,2,9,1]
	,[9,3,8,1,2,6,5,4,7]
	,[4,1,2,7,9,5,3,6,8]
	,[6,8,9,3,7,2,1,5,4]
	,[7,4,3,6,5,1,8,2,9]
	,[1,2,5,8,4,9,6,7,3]
	,[2,5,4,9,3,8,7,1,6]
	,[3,7,1,2,6,4,9,8,5]
	,[8,9,6,5,1,7,4,3,2]
  ]


sudokuMissing5 = concat [
	 [0,0,0,0,0,3,2,9,1]
	,[9,3,8,1,2,6,5,4,7]
	,[4,1,2,7,9,5,3,6,8]
	,[6,8,9,3,7,2,1,5,4]
	,[7,4,3,6,5,1,8,2,9]
	,[1,2,5,8,4,9,6,7,3]
	,[2,5,4,9,3,8,7,1,6]
	,[3,7,1,2,6,4,9,8,5]
	,[8,9,6,5,1,7,4,3,2]
  ]

sudokuMissing3 = concat [
	 [0,0,0,4,8,3,2,9,1]
	,[9,3,8,1,2,6,5,4,7]
	,[4,1,2,7,9,5,3,6,8]
	,[6,8,9,3,7,2,1,5,4]
	,[7,4,3,6,5,1,8,2,9]
	,[1,2,5,8,4,9,6,7,3]
	,[2,5,4,9,3,8,7,1,6]
	,[3,7,1,2,6,4,9,8,5]
	,[8,9,6,5,1,7,4,3,2]
  ]

sudokuMissing2 = concat [
	 [0,0,7,4,8,3,2,9,1]
	,[9,3,8,1,2,6,5,4,7]
	,[4,1,2,7,9,5,3,6,8]
	,[6,8,9,3,7,2,1,5,4]
	,[7,4,3,6,5,1,8,2,9]
	,[1,2,5,8,4,9,6,7,3]
	,[2,5,4,9,3,8,7,1,6]
	,[3,7,1,2,6,4,9,8,5]
	,[8,9,6,5,1,7,4,3,2]
  ]

sudokuMissing1 = concat [
	 [0,6,7,4,8,3,2,9,1]
	,[9,3,8,1,2,6,5,4,7]
	,[4,1,2,7,9,5,3,6,8]
	,[6,8,9,3,7,2,1,5,4]
	,[7,4,3,6,5,1,8,2,9]
	,[1,2,5,8,4,9,6,7,3]
	,[2,5,4,9,3,8,7,1,6]
	,[3,7,1,2,6,4,9,8,5]
	,[8,9,6,5,1,7,4,3,2]
  ]

sudokuCorrect = concat [
	 [5,6,7,4,8,3,2,9,1]
	,[9,3,8,1,2,6,5,4,7]
	,[4,1,2,7,9,5,3,6,8]
	,[6,8,9,3,7,2,1,5,4]
	,[7,4,3,6,5,1,8,2,9]
	,[1,2,5,8,4,9,6,7,3]
	,[2,5,4,9,3,8,7,1,6]
	,[3,7,1,2,6,4,9,8,5]
	,[8,9,6,5,1,7,4,3,2]
  ]
