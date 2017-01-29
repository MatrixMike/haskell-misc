import qualified Pipes.Prelude as PP                                                                                  
import Pipes as P                                                                                                     
import qualified System.IO as IO                                                                                      
import Control.Monad                                                                                                  
                                                                                                                      
                                                                                                                      
main = do                                                                                                             
   liftIO (IO.hSetBuffering IO.stdin (IO.BlockBuffering (Just 1)))                                                    
   runEffect $ PP.replicateM 10 getChar >-> replicateM_ 10 (do { x <- await; liftIO (putChar x)})                   
