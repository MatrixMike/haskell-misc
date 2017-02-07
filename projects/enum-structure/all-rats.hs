import Data.List
import Data.Ratio


main = print (take 10 unique_rationals)
unique_rationals = uniques (all_rationals)
uniques (x:xs) = x : uniques (filter (/=x) xs)
all_rationals = concat $zipWith (\x y -> zipWith (%) x y) (tail $ inits [1..]) (map reverse $ tail $ inits [1..])
