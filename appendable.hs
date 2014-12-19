import Data.List


type Appendable a = [a] -> [a]
singleTon a = \x -> a : x
prepend x xs = \y -> (x : xs y) 
append x xs = \y -> (xs (x : y))
toRegular xs = xs []

concatList xs ys = \y -> xs (ys y)

--  toRegular $ concatList ( append 5 $ singleTon 1) (append 4 $ singleTon 2)

prependRegular x xs = x :xs
appendRegular x xs = xs ++ [x]

fromRegular xs = \y -> foldr (:) y xs 
 
applyAll fs v = foldr ($) v fs

eg1 = sum $ applyAll (replicate 20000 (appendRegular 1)) [1]

eg2 = sum $ toRegular $ applyAll (replicate 20000 (append 1)) (singleTon 1)


{-
 -
 -
 - *Main> eg1
20001
(17.27 secs, 17520849912 bytes)
*Main> eg2
20001
(0.02 secs, 9104240 bytes)
-}






data DoubleEnded a = DoubleEnded (Appendable a) (Appendable a)


myshow (DoubleEnded xs ys) = "DoubleEnded " ++ show (toRegular xs) ++ " " ++ show (toRegular ys)

emptyDouble = DoubleEnded (singleTon 1) (singleTon 1)

appendDoubleEnd x (DoubleEnded xs ys) = DoubleEnded (append x xs) (prepend x ys) 
prependDoubleEnd x (DoubleEnded xs ys) = DoubleEnded (prepend x xs) (append x ys)
takeBackwards x (DoubleEnded _ ys) = take x (toRegular ys)

eg3 = take 300 $ reverse $ applyAll (replicate 200000 (prependRegular 4)) [3]

eg4 = takeBackwards 300 $  applyAll (replicate 200000 (prependDoubleEnd 5)) emptyDouble




concatenate xs ys = \y -> xs (ys y)

concatAppendables as = foldl1 (concatenate) as

-- concatMapFast f xs = toRegular $ concatAppendables $ map (fromRegular . f) xs
concatMapFast f xs = toRegular $ foldl (flip $ concatenate . (fromRegular . f)) (id) xs

{-
*Main> foldl1' (+) $ concatMapFast    (\x -> replicate x 1) (10000000:replicate 10000 1)
10010000
(0.25 secs, 1287559176 bytes)
*Main> :r
Ok, modules loaded: Main.
*Main> foldl1' (+) $ concatMap    (\x -> replicate x 1) (10000000:replicate 10000 1)
10010000
(0.63 secs, 1285003384 bytes)
-}

