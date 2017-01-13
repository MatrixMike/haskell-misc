{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}                                                                                                                                                                                  
{-# LANGUAGE NoMonomorphismRestriction #-}                                                                                                                                                                         
                                                                                                                                                                                                                   
import Control.Monad                                                                                                                                                                                               
import Data.Monoid                                                                                                                                                                                                 
import Control.Monad.Writer                                                                                                                                                                                        
import Data.Maybe                                                                                                                                                                                                  
import Control.Monad.Identity                                                                                                                                                                                      
import Control.Monad.Trans.Identity                                                                                                                                                                                
                                                                                                                                                                                                                   
data PlusedMaybe a = PMaybe (Maybe a)                                                                                                                                                                              
 deriving Show                                                                                                                                                                                                     
                                                                                                                                                                                                                   
instance Monoid (PlusedMaybe a) where                                                                                                                                                                              
 mappend (PMaybe x) (PMaybe y) = PMaybe (mplus x y)                                                                                                                                                                
 mempty = PMaybe mzero                                                                                                                                                                                             
                                                                                                                                                                                                                   
fromPJust (PMaybe x) = fromJust x                                                                                                                                                                                  
                                                                                                                                                                                                                   
casee =  fromPJust . execWriter                                                                                                                                                                                    
                                                                                                                                                                                                                   
op True a =  (PMaybe (Just a))                                                                                                                                                                                     
op  _ _  =(PMaybe Nothing)                                                                                                                                                                                         
                                                                                                                                                                                                                   
mappend2 x = tell "hello"                                                                                                                                                                                          
                                                                                                                                                                                                                   
(?) a b = tell (op a b)                                                                                                                                                                                            
                                                                                                                                                                                                                   
infixl 0 ?                                                                                                                                                                                                         
                                                                                                                                                                                                                   
fizzBuzz i = casee $ do                                                                                                                                                                                            
  mod i 5 == 0 && mod i 3 == 0 ? "fizzbuzz"                                                                                                                                                                        
  mod i 5 == 0                 ? "fizz"                                                                                                                                                                            
  mod i 3 == 0                 ? "buzz"                                                                                                                                                                            
  otherwise                    ? show i   
