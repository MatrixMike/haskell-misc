{-# LANGUAGE JavaScriptFFI      #-}

import qualified GHCJS.Types    as T
import qualified GHCJS.Foreign as F

foreign import javascript unsafe "document.body.innerHTML += $1" write ::  T.JSString -> IO ()

main = do
       write (F.toJSString (show $ take 10 fibs))
       write (F.toJSString "</br>hi")

fibs = 1 : 1 :scanl1 (+) fibs
