
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE RankNTypes #-}

-- import Data.List 
import Test.QuickCheck
import Test.QuickCheck.Gen
import Data.ListLike
import Prelude hiding ((++),head,tail,null)
import Test.Benchmark.Function 
import qualified Data.DList
import qualified Data.Sequence

(++) = append

make_list = generate arbitrary

qsort :: (ListLike full item, Ord item) => full -> full
qsort xs | null xs = empty
         | otherwise = qsort lts ++ singleton x ++ qsort gts
  where x = head xs
        (lts,gts) = partition (<x) (tail xs)
        
rlist = [1,2,3,4,12,41,24,125,12,4512,52,52,34,24,23,42,42,42,4,234,24,2,42,42,42,4124,124,12,41,241243,123,12,312,312,312,3,123,123,13,12,312,3,123,123,12,312,312,312,3,123,123,1,2,2,32,31,123,12,31,2312,31,231,3123,13,2,32]
rlist2 = (Prelude.take 1000 (Prelude.cycle rlist))

fromListToList :: [a] -> [a]
fromListToList = fromList

fromListToSeq :: [a] -> Data.Sequence.Seq a
fromListToSeq = fromList

fromListToDList :: [a] -> Data.DList.DList a
fromListToDList = fromList

testListType :: Show a => ([a] -> [a]) -> [a] -> IO ()
testListType function list = do 
  timeAndPrintDataWithMessage "Testing []" (function (fromListToList list))

testDListType :: Show a => (Data.DList.DList a -> Data.DList.DList a) -> [a] -> IO ()
testDListType function list = do
  timeAndPrintDataWithMessage "Testing DList" (function (fromListToDList list))

testSeqType :: Show a => (Data.Sequence.Seq a -> Data.Sequence.Seq a) -> [a] -> IO ()
testSeqType function list = do
  timeAndPrintDataWithMessage "Testing Sequence" (function (fromListToSeq list))
  
main = do
       testListType qsort rlist2
       testDListType qsort rlist2
       testSeqType qsort rlist2
