import Foreign.Java
import Foreign.Java.Maybe
import qualified Foreign.Java.JNI.Safe as JNI
import Data.Maybe

main = do
    JNI.setDebugStatus True
    runJava $ do
        (Just system) <- getClass "java.lang.System"
        getProperties <- system `bindStaticMethod` "getProperties" ::= object "java.util.Properties"

        (Just hashtableClass) <- getClass "java.util.Hashtable"    
        getEntrySet <- hashtableClass `bindMethod` "entrySet" ::= object "java.util.Set"

        (Just setClass) <- getClass "java.util.Set"
        toArray <- setClass `bindMethod` "toArray" ::= array (object "java.lang.Object")

        (Just properties) <- getProperties
        (Just entrySet) <- getEntrySet properties
        toArray entrySet
            >>= toList . fromJust
            >>= mapM toString
            >>= mapM (io . putStrLn)
