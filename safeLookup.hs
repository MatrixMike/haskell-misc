safeLookup n xs | n < 0 = Nothing
                | n > length xs -1 = Nothing
                | otherwise = Just (xs !! n)


{-
 -
 - *Main> safeLookup 0 [1,2]
 - Just 1
 - *Main> safeLookup 10 [1,2]
 - Nothing
 - -}
