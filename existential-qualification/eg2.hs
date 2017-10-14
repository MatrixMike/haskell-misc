{-# OPTIONS_GHC -fwarn-missing-signatures #-}
{-# LANGUAGE ExistentialQuantification #-} 

import Data.Typeable

data TypeableBox = forall s. Typeable s => TB s
 
heteroList :: [TypeableBox]
heteroList = [TB True,TB (2::Int),TB False,TB (),TB (4::Int)]

isInteger :: (Typeable a) => a -> Bool
isInteger n = typeOf n == typeOf (1::Int)

main :: IO ()
main = print $ length $ filter id $ map (\(TB x)-> isInteger x) heteroList

