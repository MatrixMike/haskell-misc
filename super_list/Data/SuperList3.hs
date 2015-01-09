module Data.SuperList3 where

data SuperList a = ListNest [SuperList a]
                 | ListBottom [a]
 deriving Show
 
fromList1 xs = ListBottom xs
fromList2 xs = ListNest (map fromList1 xs)
fromList3 xs = ListNest (map fromList2 xs)
fromList4 xs = ListNest (map fromList3 xs)

fromSuperList1 (ListBottom xs) = xs
fromSuperList1 (ListNest xs) = concatMap fromSuperList1 xs
fromSuperList2 (ListNest xs) = map fromSuperList1 xs
fromSuperList3 (ListNest xs) = map fromSuperList2 xs
fromSuperList4 (ListNest xs) = map fromSuperList3 xs

calculateDepth x = calculateDepth' 1 x 
calculateDepth' v (ListNest xs) = maximum (map (calculateDepth' (v+1)) xs)
calculateDepth' v (ListBottom xs) = v
