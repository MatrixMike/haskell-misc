import System.Exit
import System.Posix.Signals
import Control.Concurrent
import qualified Control.Exception as E

main :: IO ()
main = do
  tid <- myThreadId
  installHandler sigINT (Catch $ putStrLn "\nI can't let you do that to me Dave") Nothing
threadDelay (10000000)
