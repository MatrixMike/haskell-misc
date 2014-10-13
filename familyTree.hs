module FamilyTree where

import Data.Tree.Pretty 


import Data.Tree

type Name = String
data Relative =  Child Name 
              | Mother Name 
              | Father Name
        deriving (Show)
              
child :: Tree Relative
child = 
 Node (Child "Me") [
     Node (Mother "Mum") []
    ,Node (Father "Dad") [
        Node (Father "Grandpa") [
            Node (Child "Uncle") []
        ]
      ]
  ]
  
main = putStrLn $ drawUpsideDownVerticalTree $ fmap show $ child

drawUpsideDownVerticalTree = unlines . reverse . lines .  map (\x-> case x of { '\\' -> '/' ; '/' -> '\\' ; _ -> x }) . drawVerticalTree
    
