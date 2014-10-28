 -- monads are said to a monoid of endofunctors
 -- this class makes that a little clearer

class Monadier m where
  compose :: (a -> m b) -> (b -> m c) -> (a -> m c)
  identity :: (a -> m a)
   
instance Monadier [] where
  compose f g = \a -> concatMap g (f a)
  identity = \x -> [x]

composeValue f v = compose f (const v) 

{-
compose (\x -> [x+1,x+1]) (\x -> [x*3,x*3,x*3]) $ 2 => [9,9,9,9,9,9]
composeValue (\x -> [x+1,x+1]) ([3,3,3]) $ 2 => [3,3,3,3,3,3]
