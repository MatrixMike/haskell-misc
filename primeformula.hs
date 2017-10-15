main = do
       print (primeFactors 53)
       print (
              cos
                (pi *
                  ((fac (7-1) + 1)/7)
              )^2
             )

fac n = product [1..n]

primeFactors n = primeFactors' n 2
  where
    primeFactors' 1 _ = []
    primeFactors' n f
      | n `mod` f == 0 = f : primeFactors' (n `div` f) f
      | otherwise      = primeFactors' n (f + 1)
