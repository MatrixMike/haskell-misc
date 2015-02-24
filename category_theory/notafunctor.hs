notafunctor f (x:xs) = map f xs
notafunctor f xs = xs

notafunctor2 f (x:xs) | f x == x = map f (x:xs)
                      | otherwise = map f xs
notafunctor2 f [] = []
                      
test1 functor = functor function object == id object
  where object = [1,2,3] 
        function = id
        
test2 functor f g object = functor ( f . g ) object == (functor f . functor g) object

isAfunctor f xs = map f xs

main = do
       print $ [test1 notafunctor,test2 notafunctor (+1) (+1) []] 
       print $ [test1 notafunctor2,test2 notafunctor (+1) (+1) [1,2]]
       print $ [test1 isAfunctor,test2 isAfunctor (+1) (+1) [],test2 isAfunctor (+1) (+1) [1,2]]
