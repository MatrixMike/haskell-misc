import qualified Data.Monoid
import qualified Data.Semigroup

main = do
       print ("hello " ++ "world")
       print ("hello " `Data.Monoid.mappend` "world")
       print ("hello " `Data.Semigroup.mappend` "world")
       print ("hello " Data.Monoid.<> "world")
       print ("hello " Data.Semigroup.<> "world")
