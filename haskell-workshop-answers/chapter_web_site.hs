{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Control.Monad.Trans
import System.Time
import Data.Text.Lazy

import Data.Monoid (mconcat)

main = scotty 3000 $ do
  myRoute
  get "/:word" $ do
    clocktime <- liftIO getClockTime
    beam <- param "word"
    html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>",pack (show clocktime)]
  

myRoute = get "/hello" $ do
  liftIO $ putStrLn "What is your name?"
  
  myName <- liftIO readLn

  html $ mconcat ["Your name is ", myName, "... Thanks!"]