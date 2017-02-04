import Control.Lens

(🔎 ) = (^.) -- get
(🖌 ) = (.~) -- set
(🔧 ) =  (%~) -- modify

main = do
  print $ (1,2) 🔎 _1
  print $ (1,2) 🔎 _2
  print $ (1,2) & (_1🖌 10)
  print $ (1,2) & (_2🖌 10)
  print $ (1,2) & (_1🔧 (*100))
  print $ (1,2) & (_2🔧 (*100))



  -- outputs respectively
  -- 1
  -- 2
  -- (10,2)
  -- (1,10)
  -- (100,2)
  -- (1,200)
