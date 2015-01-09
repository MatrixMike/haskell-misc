import System.Directory
import System.Cmd


main = do
       removeFile "Hello.o"
       removeFile "Hello.hi"
       x <- system "ghc -O2 -ddump-simpl -dsuppress-idinfo -dsuppress-coercions -dsuppress-type-applications -dsuppress-uniques -dsuppress-module-prefixes Hello.hs"
       return ()

