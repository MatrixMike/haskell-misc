{-# Language BangPatterns #-}
import System.IO
import Control.DeepSeq
import Control.Monad

main = do let filename = "hello.txt" 
          x <- readFile filename 
         -- let !z = length x
         -- let !z = rnf x
         -- when (length x > 0) (return ())
          -- rnf x `seq` return ()
          writeFile filename (reverse x)
