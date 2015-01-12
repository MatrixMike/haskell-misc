import System.Process
 
main = do
        x <- system "ghci -package ghc A.hs"
        return ()