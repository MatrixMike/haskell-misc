import Control.Monad.Trans 
import Control.Monad.Trans.Maybe

main = do
       runMaybeT $ do { a <- MaybeT( return (Just 3)) ; lift (print a)}
       runMaybeT $ do { a <- MaybeT( Nothing) ; lift (print a)}
       return ()
