import Prelude                                                                                                                                                        
import Pipes.Shell                                                                                                                                                    
import Pipes.Prelude                                                                                                                                                  
import Pipes.Safe                                                                                                                                                     
import Pipes                                                                                                                                                          
import Data.ByteString.Char8                                                                                                                                          
import Control.Foldl                                                                                                                                                  
import qualified Pipes.ByteString as PBS                                                                                                                              
import Control.Monad                                                                                                                                                  
                                                                                                                                                                      
main =  runSafeT $ runEffect $  (Pipes.Prelude.stdinLn )                                                                                                              
        >-> forever (markEnd (do  { a <- await ; yield (pack a) } )  )                                                                                                
        >-> forever (pipeCmd' "tr 'a' 'A'")                                                                                                                           
        >-> forever (do  { a <- await ; yield a ; yield (pack "\n")} )                                                                                                
        >-> PBS.stdout   
