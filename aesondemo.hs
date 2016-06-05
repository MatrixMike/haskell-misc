{-# LANGUAGE NoMonomorphismRestriction #-}
import Data.Text                                                                                                                                                                                                   
import Data.Aeson                                                                                                                                                                                                  
import Data.HashMap.Strict                                                                                                                                                                                         
import Data.Aeson.Internal                                                                                                                                                                                         
                                                                                                                                                                                                                   
a = fromList [(pack "a" , String $ pack "z"),(pack "b",String $ pack "zz")]
b o =  (\x y->  (x :: Text , y :: Text)) <$> (o .: pack "a") <*> (o .: pack "b")
c = iparse b $ a     
