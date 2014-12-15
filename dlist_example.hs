Prelude Data.DList> let applyNTimes f n x = if n == 0 then x else applyNTimes f (n-1) (f x) in Data.List.foldr (+) 0 (applyNTimes (++ [1]) 5000 ([1]))
5001
(1.26 secs, 1125328088 bytes)
Prelude Data.DList> let applyNTimes f n x = if n == 0 then x else applyNTimes f (n-1) (f x) in Data.DList.foldr (+) 0 (applyNTimes (`append` singleton 1) 5000 (singleton 1))
5001
(0.02 secs, 6739048 bytes)
