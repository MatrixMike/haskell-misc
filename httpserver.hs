import Network
import Network.Socket
import Network.HTTP
-- import Network.Stream
import Network.HTTP.Stream
import System.IO
import Control.Monad
import Control.Arrow
import Control.Category
import Prelude hiding (id,(.))
import Text.XHtml.Transitional
import Control.Concurrent

{- 
 taken from
http://lstephen.wordpress.com/2008/02/14/a-simple-haskell-web-server/
-}

type RequestHandler = Request String -> IO (Response String)

main = runHttpServer hellowWorldHnadler

hellowWorldHnadler :: RequestHandler
hellowWorldHnadler _ =
    return $ successResponse $ prettyHtml helloWorldDoc

successResponse :: String -> Response String
successResponse  s =
    Response   (2,0,0) "" [] s

helloWorldDoc :: Html
helloWorldDoc =
    header << thetitle << "Hello World"
           Text.XHtml.Transitional.+++
               body << h1 << "Hello World"

runHttpServer :: RequestHandler -> IO ()
runHttpServer r =
    withSocketsDo $ do
      sock <- socket AF_INET Stream 0
      addr <- inet_addr "0.0.0.0"
      bindSocket sock $ SockAddrInet  7090 addr
      listen sock  7091
      forever $ acceptConnection sock $ handleHttpConnection r

acceptConnection :: Socket -> (Handle -> IO ()) -> IO ()
acceptConnection s k =
     Network.accept s >>= \(h,_,_) -> forkIO (k h) >> return ()


instance Stream Handle where
    readLine   h   = hGetLine h >>= \ l -> return $ Right (l ++ "\n")
    readBlock  h n = replicateM n (hGetChar h) >>= return . Right
    writeBlock h s = mapM_ (hPutChar h) s >>= return . Right
    close          = hClose

handleHttpConnection :: RequestHandler -> Handle -> IO ()
handleHttpConnection r c = do
    Right xa <- receiveRequest c
    xb <- r xa
    handleResponse  xb
    Network.HTTP.Stream.close c
    where
      receiveRequest  = Network.HTTP.Stream.receiveHTTP
      handleResponse  = Network.HTTP.Stream.respondHTTP c
