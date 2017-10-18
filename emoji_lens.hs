{-# OPTIONS_GHC -fwarn-missing-signatures #-}
{-# LANGUAGE NoMonomorphismRestriction #-}

import Control.Lens
import Control.Monad.Trans.Class
 -- (🏋️ ) = lift

{-to permit compilation please do the following (takes a while)
cabal install lens
cabal repl
:browse
:load <this file>
notice the output and cpmpare with the following 4 lines

-}
(🔎) = (^.) -- get

(🖌) = (.~) -- set

(🔧) = (%~) -- modify

(🏇) = traverse

infixl 8 🔧

main = do
  print $ (1, 2) 🔎 _1
  print $ (1, 2) 🔎 _2
  print $ (1, 2) & (_1 🖌 10)
  print $ (1, 2) & (_2 🖌 10)
  print $ (1, 2) & (_1 🔧 (* 100))
  print $ (1, 2) & (_2 🔧 (* 100))
  print $ [(1, 2), (3, 4)] & ((🏇) . _1 🔧 (* 1000))
  print $ [(1, 2), (3, 4)] & ((🏇) . _2 🔧 (* 1000))
  -- outputs respectively
  -- 1
  -- 2
  -- (10,2)
  -- (1,10)
  -- (100,2)
  -- (1,200)
  -- [(1000,2),(3000,4)]
  -- [(1,2000),(3,4000)]
