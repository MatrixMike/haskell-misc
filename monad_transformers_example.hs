
{-# LANGUAGE NoMonomorphismRestriction #-}

import Control.Monad
import Control.Monad.Trans
import Control.Monad.Trans.Maybe
import Control.Monad.State


main = do
       print $ runState (do { 
                                 modify (+10)
                               ; x <- evalStateT innerState 1
                               ;  return x })100
       
innerState = do 
                     lift (modify (+9000))
                     modify (+10000)
                     return (1000000)
                        
                                      
                                       
