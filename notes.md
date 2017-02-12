

strange operator names

```
main = let 1 +#$$+#$$*&^&*^*^ 1= 3 in print (1 +#$$+#$$*&^&*^*^ 1)
```


invalid character 

```
import System.IO
hSetEncoding utf8
```

use optimised compiled code in ghci

```
ghci -fobject-code -O2 ff.hs 
```

get test dependencies

```
cabal install --enable-tests
```

show language extensions

```
 ghc --supported-languages
```

```
Prelude Test.QuickCheck Control.Applicative Control.Monad>  quickCheck ((\x y -> (x <|> y )== x `mplus` y)  :: Maybe () -> Maybe () -> Bool )
```

```
Prelude Data.ByteString Control.Monad.Writer Data.Functor.Identity Control.Monad.Trans.Identity Control.Monad.Reader>  runReader ( runWriterT (do {tell [2]  ; lift ask  })) 5000
```


```
runWriter(  (do {tell [2,7]  ; x <- pass (tell [300] >>= \z -> return ((),\q -> q++ q++q)) ; tell [9,5]  } )) 

```

use imports in ghc one liner
```
ghc -e 'import Control.Monad' -e 'replicateM_ 10 (print 1)'

```

Alternative instance for IO example

```
readFile "/dev/doesntexist" <|> readFile "/dev/null"
```

to install text-icu
```
cabal install text-icu
apt-get install libicu-dev
```


maybet example

```
runMaybeT $ do { x <- lift getLine ; return 3 }     

or

 Control.Monad.Trans.Maybe>  runMaybeT (do { x <- MaybeT (return $ Just 2) ; return x    })
 
 

```

nesting reader monads
```
runReaderT (runReaderT (ReaderT (\x -> ReaderT (\y -> return ([x,y])) )) 'a') 'b'
```
