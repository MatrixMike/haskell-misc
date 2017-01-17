data Burrito a = Tortilla a
  deriving Show

data Beans = Beans
  deriving Show

data Cheese = Cheese
  deriving Show

cheeseTortilla = Tortilla Cheese

instance Monad Burrito where
  (Tortilla a) >>= f = (f a)
  return a = Tortilla a

addBeans a = Tortilla (a,Beans)

main = print $ do
       t <- (Tortilla Cheese)
       t' <- addBeans t
       return t'

instance Applicative Burrito where
  (<*>) _ _ = undefined
  pure = undefined

instance Functor Burrito where
  fmap _ = undefined

