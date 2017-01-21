{-# LANGUAGE ApplicativeDo #-}

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

main = do
       print q
       print v

q =  do
       t <- (Tortilla Cheese)
       t' <- (Tortilla Beans)
       return (t,t')

v =  do
       t <- (Tortilla Cheese)
       t' <- addBeans t
       return t'

instance Applicative Burrito where
  (<*>) (Tortilla f) (Tortilla g) = (Tortilla (f g))
  pure = Tortilla

instance Functor Burrito where
  fmap f (Tortilla a) = (Tortilla (f a))

