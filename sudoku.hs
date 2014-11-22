import Data.List.Split
import Data.List
--import Data.Monoid
import Control.Monad

sudoku = [
        8, 5, 0, 0, 0, 2, 4, 0, 0,
        7, 2, 0, 0, 0, 0, 0, 0, 9,
        0, 0, 4, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 1, 0, 7, 0, 0, 2,
        3, 0, 5, 0, 0, 0, 9, 0, 0,
        0, 4, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 8, 0, 0, 7, 0,
        0, 1, 7, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 3, 6, 0, 4, 0]


sudokuBad = [
        2, 5, 0, 0, 0, 2, 4, 0, 0,
        7, 2, 0, 0, 0, 0, 0, 0, 9,
        0, 0, 4, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 1, 0, 7, 0, 0, 2,
        3, 0, 5, 0, 0, 0, 9, 0, 0,
        0, 4, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 8, 0, 0, 7, 0,
        0, 1, 7, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 3, 6, 0, 4, 0]

horizontals = chunksOf 9 

verticals = transpose . chunksOf 9

validArea xs = length (nub (filterZeros xs)) == length (filterZeros xs)
 
filterZeros = filter (not . (==0))

totalyValidArea xs = sort xs == [1..9]

squares xs= concat $ map (map concat) $  map (chunksOf 3) (transpose ((map (chunksOf 3) (horizontals xs))))

checkAreas f xs =
  all (all (==True))
   (map (map f) [verticals xs,horizontals xs,squares xs])

checkValidSudoku xs = checkAreas validArea xs




