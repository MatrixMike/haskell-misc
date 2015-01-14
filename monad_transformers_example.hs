
{-# LANGUAGE NoMonomorphismRestriction #-}

import Control.Monad
import Control.Monad.Trans
import Control.Monad.Trans.Maybe
import Control.Monad.State

isValid = const True


main = do
       print $ evalState (do {   modify (+1) 
                               ; modify (+1) 
                               ; runMaybeT getValidPassphrase 
                               ; x <- get
                               ;  return x } ) 0
       
getValidPassphrase = do s <- lift ( modify (*100) >> return 7)
                        guard (isValid s) 
                        return s
