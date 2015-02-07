
main = do
       print ((+1) $ 2) -- prelude dollar
       print ((arr (+1)) 2) -- arrow
       print ( (+1) >>= return) 2 -- monad
