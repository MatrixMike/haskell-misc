{-# LANGUAGE NoMonomorphismRestriction #-}                                                                                                                                                                         
                                                                                                                                                                                                                   
                                                                                                                                                                                                                   
                                                                                                                                                                                                                   
import Pipes                                                                                                                                                                                                       
import Pipes.Prelude(drain)                                                                                                                                                                                        
import Data.Char                                                                                                                                                                                                   
import Control.Category                                                                                                                                                                                            
                                                                                                                                                                                                                   
main = runEffectA $  ((S u) >>> (S v) ) >-> drain                                                                                                                                                          
                                                                                                                                                                                                                   
t = do                                                                                                                                                                                                             
    yield 2                                                                                                                                                                                                        
                                                                                                                                                                                                                   
u = do                                                                                                                                                                                                             
    x <- await                                                                                                                                                                                                     
    lift (print x)                                                                                                                                                                                                 
    yield (chr x)                                                                                                                                                                                                  
    return ()                                                                                                                                                                                                      
                                                                                                                                                                                                                   
v = do                                                                                                                                                                                                             
    x <- await                                                                                                                                                                                                     
    lift (print x)                                                                                                                                                                                                 
    yield (ord x)                                                                                                                                                                                                  
    return ()                                                                                                                                                                                                      
                                                                                                                                                                                                                   
myComp :: Monad m => Pipe a b m r -> Pipe b c m r -> Pipe a c m r                                                                                                                                                  
myComp = (>->)                                                                                                                                                                                                     
                                                                                                                                                                                                                   
instance Monad m => Category (S m) where                                                                                                                                                                           
  id = undefined                                                                                                                                                                                                   
  (S f) . (S g) = S (myComp g f) 
  
runEffectA x =  (yield () >-> UnS x >-> drain)
runEffect' x =  (yield () >-> x >-> drain)  
                                                                                                                                                                                                                   
newtype S m a b = S { unS :: Proxy () a () b m () }                                                                                                                                                                
                                                                                                                                                                                                                   
a = do                                                                                                                                                                                                             
    x <- await                                                                                                                                                                                                     
    return x                                                                                                                                                                                                       
