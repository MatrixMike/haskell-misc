import Control.Comonad
import Data.List.NonEmpty

main = print (liftW (+1) (1 :| []))