import Data.List
import Data.Ord
import qualified Data.Sequence as Sequence
import Data.Sequence ((|>))
import Data.Foldable

reverse_slow (x: xs) = reverse_slow xs ++ [x]
reverse_slow [] = []
reverse_medium xs = map snd $ sortBy (comparing snd) $ zip xs [1..]
reverse_fast xs = reverse_fast' [] xs
reverse_fast' accum (x:xs) = reverse_fast' (x:accum) xs
reverse_fast' accum [] = accum
reverse_other xs = toList $ reverse_other' xs
reverse_other' (x:xs) = reverse_other' xs |> x
reverse_other' [] = Sequence.empty
