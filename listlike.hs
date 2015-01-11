
{-# LANGUAGE NoMonomorphismRestriction #-}

-- import Data.List 
import Test.QuickCheck
import Test.QuickCheck.Gen
import Data.ListLike
import Prelude hiding ((++),head,tail,null)

(++) = append

make_list = generate arbitrary

qsort :: (ListLike full item, Ord item) => full -> full
qsort xs | null xs = empty
         | otherwise = qsort lts ++ singleton x ++ qsort gts
  where x = head xs
        (lts,gts) = partition (<x) (tail xs)
