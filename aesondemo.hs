{-# LANGUAGE NoMonomorphismRestriction #-}

import Data.Aeson
import Data.Aeson.Internal
import Data.HashMap.Strict
import Data.Text

a = fromList [(pack "a", String $ pack "z"), (pack "b", String $ pack "zz")]

b o = (\x y -> (x :: Text, y :: Text)) <$> (o .: pack "a") <*> (o .: pack "b")

c = iparse b $ a

{-
cabal repl 
:browse

-}
