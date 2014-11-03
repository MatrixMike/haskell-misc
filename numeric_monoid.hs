import Data.Monoid
import Data.Foldable

instance Monoid Int where
mempty = 0
mappend = (+)

main = do
  print
   (1 `mappend` 1 :: Int)
  print
   (fold [1..10] :: Int)
