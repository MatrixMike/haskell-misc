{-# OPTIONS_GHC -fwarn-missing-signatures #-}
--import Data.ByteString.UTF8
import Data.ByteString


main = do
 let myByteString = showString "字"
 print (Data.ByteString.length myByteString)
-- print (Data.ByteString.length myByteString)
 
{-
output:
# runhaskell Main.hs                                                                                                                
1                                                                                                                                                            
3       

-}
