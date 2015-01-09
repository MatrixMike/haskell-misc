module NestedTree where

import Data.Tree
import Data.Char

data NestedTree a = RootNode a [NestedTree a] 
                  | NotRootNode a [NestedTree a]
    deriving(Show)

instance Functor NestedTree where
  fmap f (RootNode x ts) = RootNode (f x) (map (fmap f) ts)
  fmap f (NotRootNode x ts) = NotRootNode (f x) (map (fmap f) ts)

metlink :: Tree String
metlink = Node "Richmond" [
    Node "East Richmond" [ 
            Node "Burnley" [ 
                  Node "Heyington" [] 
                , Node "Hawthorn" []
            ]
        ]
   ,Node "South Yarra" [ 
          Node "Praran" [] 
        , Node "Hawksburn" []
   ]
 ]
 

metlinkRichmondNested = RootNode "Richmond" [
        NotRootNode "East Richmond" [ 
            RootNode "Burnley" [ 
                  NotRootNode "Heyington" [] 
                , NotRootNode "Hawthorn" []
            ]
        ]
   ,RootNode "South Yarra" [ 
          NotRootNode "Praran" [] 
        , NotRootNode "Hawksburn" []
   ]
 ]
 
metlinkRichmondNestedTwo = RootNode "Richmond" [
        NotRootNode "East Richmond" [ 
            RootNode "Burnley" [ 
                  NotRootNode "Heyington" [] 
                , NotRootNode "Hawthorn" []
            ]
        ]
   ,RootNode "South Yarra" [ 
          NotRootNode "Praran" [] 
        , NotRootNode "Hawksburn" []
   ]
 ]



metlinkRichmondNestedTwoUpper  = fmap (map toUpper) metlinkRichmondNestedTwo

main = print metlinkRichmondNestedTwoUpper
