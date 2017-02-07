import Control.Monad
import Data.List

main = print (component_sequences 4)

-- *Main> :ma
-- [[4],[3,1],[2,1,1],[2,2],[1,1,2],[1,1,1,1],[1,2,1],[1,3]]
--

component_sequences_normalised = sort . nub .  map sort . component_sequences 
component_sequences n =  map (map length) $ components' n 
components'   n = map (groupBy (==)) (components'' n)
components''  n = map (0:) (components''' n)
components''' n = replicateM (n-1) [0,1]



