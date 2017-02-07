
-- Melbourne Haskell Workshop 2013 Answers

-- Chapter Setup

-- Excercise - Calculate the price of 42-bakers-dozens of eggs at $3 per-egg.
fortyTwoBakersDozenAtThreePerEgg = 42 * 13 * 3 

-- Excercise - Define a new numeric function 
add_one = (+1)

-- Excercise - Compile and run your own spin on Hello-World.
main = putStrLn "Greetings Universe"

-- Chapter: Introduction

-- Excercise - define your own variable
myOwnVariable = 2

-- Excercise - give your variable a type-signature
myOwnVariable2 :: Int
myOwnVariable2 = 2

-- Excercise - define a variable containing a string
aVariableContainingAString = "hello world"

-- Excercise - define a variable containing a tuple
aVariableContainingATuple = ('c',False)

-- Excercise - define a function 'myMultiply' that multiplies 3 numbers
myMultiply :: Num a => a -> a -> a -> a
myMultiply n1 n2 n3 = n1 * n2 * n3

-- Excercise - define a variable containing a list
aVariableContainingAList = [1,2,3,4]

-- Excercise - Give your variable a type-signature.
aVariableContainingAList :: [Int]

-- Excercise - define a variable containing the first element of your list 
myFirstElement = (\(x:_)->x) aVariableContainingAList

-- Excercise - Define a function that takes a list and returns the length. 
functionTakingListReturningLength :: [a] -> Int
functionTakingListReturningLength [] = 0 
functionTakingListReturningLength list = 1 + functionTakingListReturningLength (tail list)

-- Excercise - Define a function that takes a function from a to b "a -> b", and a list of as "[a]", and returns a list of bs "[b]".
myMap :: (a -> b) -> [a] -> [b]
myMap f list = [ f x | x <- list ] 

-- Chapter: ADTs (Algebraic Data Types)

-- Excercise - Define a function that takes a function from a to b "a -> b", and a list of as "[a]", and returns a list of bs "[b]".
data MyOwnListADT a = Cons a (MyOwnListADT a) 
                    | End
  deriving(Show)

example = Cons 1 (Cons 2 (Cons 4 End))


-- Excercise - Implement an infinite list of ascending numbers using lazy, value-based recursion. 
infiniteListOfAscendingNumbers = 1 : (map (+1) infiniteListOfAscendingNumbers)

-- An open-ended question: Can all numberic-lists be defined by using value-based recursion
-- answer: so long as the list is not infinitely random

