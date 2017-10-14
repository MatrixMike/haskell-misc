{-# OPTIONS_GHC -fwarn-missing-signatures #-}
import System.Environment
import System.Process

main :: IO()
main = do
  alias_do "lsd"
  return ()

alias_do = alias_do' ""

alias_do' initScript cmd = do
  vars <- getEnv "RUNHASKELL_ALIAS_VARS"
  let sourceCommand =
        if null initScript
          then ""
          else "source " ++ initScript ++ " 2> /dev/null \n"
  rawSystem
    "bash"
    ["-c", "shopt -s expand_aliases \n" ++ sourceCommand ++ vars ++ "\n" ++ cmd]
