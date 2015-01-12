import Data.STRef
import Control.Monad.ST
import Control.Monad

sumUsingST xs = runST $ do
                  counter <- newSTRef 0
                  forM_ xs (\v -> modifySTRef counter (+v) )
                  readSTRef counter 


    

sequenceUsingST xs = runST $ do
  result <- newSTRef []
  case xs of 
   (a@(_:_):b) -> forM_ a $ \v -> do
	let rest = sequenceUsingST b
	modifySTRef result (++(map (v:) rest))
   _ -> writeSTRef result [[]]
  readSTRef result 

