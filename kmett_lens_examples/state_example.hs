{-# OPTIONS_GHC -fwarn-missing-signatures #-}
module StateGame where

import Control.Lens
import Control.Monad.State

type GameValue = Int

type GameState = (Bool, Int)

playGame :: String -> State GameState GameValue
playGame [] = do
  (_, score) <- get
  return score
playGame (x:xs) = do
  (on, score) <- get
  case x of
    'a'
      | on -> modify $ _2 +~ 1
    'b'
      | on -> modify $ _2 -~ 1
    'c' -> modify $ _1 %~ not
    _ -> modify id
  playGame xs

startState = (False, 0)

main = do
  print $ evalState (playGame "abcaaacbbcabbab") startState
