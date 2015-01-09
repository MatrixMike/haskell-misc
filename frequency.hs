import qualified Data.Map as Map
import System.Random

test_list="the rain in spain falls mainly on the plane"

frequencyTable list = foldr (\a b -> Map.insertWith (+) a 1 b) Map.empty list

listOfRandomLists gen = (randoms gen) : (listOfRandomLists (snd $ next gen))

main = do
       q <- newStdGen
       let ft = frequencyTable $  map sum $ take 10000 $ map (map round)$ map (take 1000) $ (listOfRandomLists q :: [[Double]])
       print ft
