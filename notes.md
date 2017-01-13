

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
