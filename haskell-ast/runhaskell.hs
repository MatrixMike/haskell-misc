{-# OPTIONS_GHC -fwarn-missing-signatures #-}
import System.Process
 
main :: IO()
main = do
        x <- system "ghci -package ghc A.hs"
        return ()
