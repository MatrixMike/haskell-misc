
import Data.Tree

data MyLens c a = MyLens {
                 get :: c a -> a
                ,set :: a -> c a -> c a
            }
            
modify = \l c f -> set l (f (get l c)) c

lastElementOfAListLens = MyLens last (\y xs-> init xs++[y])

lastElementOfATreeLens = MyLens get' set'
 where get' (Node n xs@(x:_)) = get' (get lastElementOfAListLens xs)
       get' (Node n []) =  n
       set' v (Node n xs@(x:_)) = Node n (modify lastElementOfAListLens xs (set lastElementOfATreeLens v))
       set' v (Node n []) = (Node v []) 
       
myTree = Node 1 [
    Node 2 [
          Node 3 []
        , Node 4[]
    ],
    Node 5 [
              Node 6 []
            , Node 7 []
        ]
    ]

testList = [1,2,3,4]

main = do
       let testList' = (set lastElementOfAListLens) 99 testList
       let testList''  = modify lastElementOfAListLens testList' (+1)
       print (get lastElementOfAListLens testList'')
       let myTree' = modify lastElementOfATreeLens myTree (*10)
       print ((get lastElementOfATreeLens) myTree')
