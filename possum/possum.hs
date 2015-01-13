import Text.EditDistance
import System.Random
import Control.Arrow
import Data.Char
import Data.List
import Data.Ord
import Data.Maybe
import Data.Tuple
import System.IO
--import QuickTrace

levenshtein = levenshtein' 0
levenshtein' x s1 "" = x + length s1
levenshtein' x "" s2 = x + length s2
levenshtein' x s1 s2 = minimum ([tryDelete,tryInsert,trySubstitute]++trySkip)
  where tryDelete = levenshtein' (x+1) (drop 1 s1) s2  
        tryInsert = levenshtein' (x+1) (take 1 s2 ++ drop 1 s1) (drop 1 s2)
        trySubstitute = levenshtein' (x+1) (drop 1 s1) (drop 1 s2)
        trySkip = if take 1 s1 == take 1 s2 then [levenshtein' x (drop 1 s1) (drop 1 s2)] else []

mutateList point mode injection xs =  {- qm (point ,mode,injection)  $ -}
 case mode of 
  0 -> h ++ drop 1 t -- deletion
  1 -> xs -- no change h ++ t
  2 -> (h ++ injection : t) -- insertion
  3 -> (h ++ injection : drop 1 t)  -- substitution
  where (h,t) = splitAt point xs

poolSize = 20 

randomMutate xs rands = let
  [x,y,z] = map abs $ take 3 rands
  mode = y `mod` 4 -- getMode y
  pointModulo = if mode == 2 then length xs else length xs + 1
  point = (if length xs == 0 then 0 else ((x::Int) `mod` pointModulo))
  injection = (letters !! (z `mod` (length letters))) 
  in mutateList point mode injection xs

selectOffspring :: String -> [String] -> String
selectOffspring dest offspring = minimumBy (comparing (levenshtein2 dest)) offspring

applyMutations parent mutations = map (randomMutate parent) mutations

selectMutation dest parent mutations = selectOffspring dest (  applyMutations parent mutations)

letters = ' ':['A'..'Z']

randomNumbers g = chunks poolSize $ chunks 4 $ randoms g 

test= "ME THINKS IT IS LIKE A POSSUM"
getIterations = newStdGen >>= return . scanl (selectMutation test) (replicate (length test) ' ')  . randomNumbers 
main = do
       hSetBuffering stdin  NoBuffering
       getIterations >>= \lines -> mapM_ (\(generation,line) ->  putStrLn ("genereration " ++ show generation   ++ ": distance: " ++ (show (levenshtein2 test line)) ++ " " ++ show line)   )
                                 (zip [1..] lines)

{- outer domain functions -}

levenshtein2 = levenshteinDistance (EditCosts (ConstantCost 1) (ConstantCost 1) (ConstantCost 1) (ConstantCost 1))

chunks n [] = []
chunks n xs = let firstChunk = take n xs in firstChunk : chunks n (drop n xs)

insertAt = (\n x xs -> case splitAt n xs of { (a, b) -> a ++ [x] ++ b })
