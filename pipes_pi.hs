

import Pipes
import Pipes.Prelude
import Control.Monad
import System.Random
import Control.Monad.Identity

main = newStdGen >>= Prelude.print . w

w a = (\x ->  (*4) $ (\y -> (fromIntegral y )/(fromIntegral x) ) $  runIdentity $  Pipes.Prelude.length (  f a >-> forever (do {x <- await ; y <- await ; yield (x,y) }) >-> Pipes.Prelude.take x >-> Pipes.Prelude.filter (\(x,y) -> x*x + y*y < 1.0))) 100000

f x = (\(a,b) -> yield (a::Float) >> f b) (System.Random.random x)
