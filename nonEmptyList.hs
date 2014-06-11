
data NonEmpty a = Cons a (NonEmpty a)
                | End a

testList = Cons 1 (Cons 2 (Cons 3 (End 4)))
testList2 = End 5

nonEmptyHead (Cons a _) = a
nonEmptyHead (End a) = a

main = do 
   print (nonEmptyHead testList)
   print (nonEmptyHead testList2)
