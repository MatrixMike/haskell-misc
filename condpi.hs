{-# Language NoMonomorphismRestriction #-}
import Conduit
import Control.Monad
import System.Random
import Control.Monad.Identity
import Data.Conduit.Combinators
import Data.Conduit.List

main = newStdGen >>= Prelude.print . w
ff = 10000000

w a =  (runConduitPure ( Data.Conduit.Combinators.yieldMany (g a) .| e .| Data.Conduit.Combinators.take ff .| e2 .|  Data.Conduit.Combinators.length )  / ff) * 4

e =  forever (do {x <- await ; y <- await ; yield (x,y) })

e2 =Data.Conduit.Combinators.filter (\(Just x,Just y) -> x*x + y*y < 1.0)

g s = ( randoms s  ::[Float])

