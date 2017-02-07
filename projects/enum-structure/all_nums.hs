import Control.Monad
import Data.List

powerSet = filterM (const [True,False])

all_sets = concat all_sets'

all_sets' = map fun [1..]
 where fun x = (powerSet ([x,(x-1)..0]))

all_numbers = map (\xs -> let g = length xs in zipWith subtract [(g-1),(g-2)..0] xs ) all_sets 

all_permutations' = map permutations all_sets

all_permutations= concat all_permutations'
