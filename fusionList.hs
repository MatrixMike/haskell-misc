

fusionList = \f x -> x

prepend x' fL = \f x -> f x' (fL f x)
append  g' fL = \f x -> fL f (f g' x)

fusionMap f' fL = \f x -> fL (f . f') x


fList =  (fusionMap (*100) $append 10000000 $ prepend 5 $ prepend 4  $ prepend 2 fusionList) 

test = fList (:) []
test2 = fList (+) 0
