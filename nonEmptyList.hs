{-# OPTIONS_GHC -fwarn-missing-signatures #-}
data NonEmpty a = Cons a (NonEmpty a)
                | End a

testList:: NonEmpty Integer
testList = Cons 1 (Cons 2 (Cons 3 (End 4)))

testList2:: NonEmpty Integer
testList2 = End 5

nonEmptyHead:: NonEmpty p -> p
nonEmptyHead (Cons a _) = a
nonEmptyHead (End a) = a

main :: IO()
main = do 
   print (nonEmptyHead testList)
   print (nonEmptyHead testList2)
