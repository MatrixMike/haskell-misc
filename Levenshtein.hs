{-# OPTIONS_GHC -fwarn-missing-signatures #-}
{-
In information theory, Linguistics and computer science, 
the Levenshtein distance is a string metric
for measuring the difference between two sequences.
https://en.wikipedia.org/wiki/Damerau%E2%80%93Levenshtein_distance
-}

levenshtein :: String -> String -> Int
levenshtein s1 s2 = levenshtein' 0 s1 s2

levenshtein' :: Int -> String -> String -> Int
levenshtein' x s1 "" = x + length s1
levenshtein' x "" s2 = x + length s2
levenshtein' x s1 s2 = minimum ([tryDelete,tryInsert,trySubstitute]++trySkip)
  where tryDelete = levenshtein' (x+1) (drop 1 s1) s2
        tryInsert = levenshtein' (x+1) (take 1 s2 ++ drop 1 s1) (drop 1 s2)
        trySubstitute = levenshtein' (x+1) (drop 1 s1) (drop 1 s2)
        trySkip = if take 1 s1 == take 1 s2 then [levenshtein' x (drop 1 s1) (drop 1 s2)] else []

main :: IO()
main = do
    print (levenshtein "0a0b0" "ab")
    print (levenshtein "mike" "abcd")
    print (levenshtein "wxyz" "abcd")
