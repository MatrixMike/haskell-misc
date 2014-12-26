{-# LANGUAGE NoMonomorphismRestriction #-}

import Data.Sequence
import Data.Traversable
import Data.Foldable
import Data.Monoid

concatenate = Data.Foldable.foldl (<>) mempty
flatten = Data.Foldable.foldl (<>) mempty

eg =  Data.Traversable.sequenceA $ Data.Sequence.fromList [Data.Sequence.fromList [1,2],Data.Sequence.fromList [1,2]]
eg' = flatten eg
eg'' = Data.Foldable.foldl (+) 0 eg'

main = print eg''
