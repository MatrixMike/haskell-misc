import Data.ByteString.UTF8
import Data.ByteString


main = do
 let myByteString = fromString "字"
 print (Data.ByteString.UTF8.length myByteString)
 print (Data.ByteString.length myByteString)
 
{-
output:
# runhaskell Main.hs                                                                                                                
1                                                                                                                                                            
3       

-}
