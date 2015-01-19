import Data.Complex

instance (Functor Complex) where
  fmap f (a:+b) = ((f a):+(f b))
  
main = print $ fmap reverse ("hello":+"world")
 --  "olleh" :+ "dlrow"
