

type Appendable a = a -> [a]
singleTon a = \x -> a : x
prepend x xs = \y -> (x : xs y) 
append x xs = \y -> (xs (x : y))
toRegular xs = xs []

prependRegular x xs = x :xs
appendRegular x xs = xs ++ [x]
 
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
