import Control.Applicative
import Control.Lens
import Data.Char

data Address = A
  { _road :: String
  , _city :: String
  , _postCode :: String
  } deriving (Show)

middleLens =
  lens
    (\xs -> xs !! (length xs `div` 2))
    (\xs n ->
       (\(h, ts) -> (h ++ set _head n ts)) (splitAt (length xs `div` 2) xs))

tuple3lens :: Traversal (a, a, a) (b, b, b) a b
tuple3lens f (a, a', a'') = (,,) `fmap` f a <*> f a' <*> f a''

mapped4 :: Functor f => Setter (f a) (f b) a b
mapped4 = sets (\xs -> fmap (xs))

addressTraversal :: Traversal Address Address String String
addressTraversal f (A r c p) = (\r' -> A r' c p) <$> f r

addressTraversal2 :: Traversal Address Address String String
addressTraversal2 f (A r c p) = (\r' c' -> A r' c' p) <$> f r <*> f c

alternateElements = traversed . indices even

main = do
  mapM_ print [set middleLens 999 [1, 2, 3, 4]]
  print $ over tuple3lens succ (1, 2, 3)
  print $ over mapped4 succ [1, 2, 3]
  let myAddress = A "Baker st" "Melbourne" "3000"
  print $ over addressTraversal (Prelude.map toUpper) myAddress
  print $ over addressTraversal2 (Prelude.map toUpper) myAddress
  print $ over alternateElements toUpper "mr studly speaking"
