import System.Directory                                                                                                                                                                       
import Control.Monad                                                                                                                                                                          
import System.Exit                                                                                                                                                                            
import System.Process                                                                                                                                                                         
import System.Environment                                                                                                                                                                     
import System.IO                                                                                                                                                                              
import Data.List                                                                                                                                                                              

--interpreter = "runhugs"
interpreter = "runghc"


nop = "\nmain=return ()"
op = "\nmain=entry"

func program = do
  writeFile ".temp.hs" (program++nop)
  (_, _, Just hstderr, pid) <- createProcess (proc interpreter [".temp.hs"]) {std_out = CreatePipe , std_in = CreatePipe , std_err = CreatePipe}
  err <- hGetContents hstderr
  -- putStr err
  ex <- waitForProcess pid                                                                                                                                                                    
  -- putStr err
  case ex of                                                                                                                                                                         
    ExitSuccess -> func2 program >> return True
    ExitFailure _ -> return False

func2 program = do
  writeFile ".temp.hs" (program++op)
  (Just hstdin, Just hout, Just hstderr, pid) <- createProcess (proc interpreter [".temp.hs"]){ std_out = CreatePipe , std_in = CreatePipe , std_err = CreatePipe}
  hSetBuffering hout NoBuffering
  hSetBuffering hstdin NoBuffering
  input <- getContents
  hPutStr hstdin input
  hClose hstdin
  res <- hGetContents hout
  putStr res
  -- err <- hGetContents hstderr
  -- putStr err
  hClose hstderr


morelines = unlines [  "import System.IO" 
                      ,"import Data.Char"
                      ,"import Text.ParserCombinators.Parsec"
                      ,"keepSame = satisfy (const True) >>= \\x -> return [x]" 
                      ,"replacer find = many (try find <|> keepSame) >>= return . concat "
                      ,"replace str find = let (Right res) = parse (replacer find) [] str in res" 
                      ,"entry=do { c <- getContents ; putStr (replace c findref) } " ] ++ "findref = ("

executors = [                                                                                                                                                                                 
              (unlines ["import System.IO","import Data.Char"]++"entry = getContents >>= \\x -> mapM_ putStrLn (map f (lines x)) \nf =  ","")
              ,(unlines ["import System.IO","import Data.Char"]++"entry = interact (map ",")")
              ,(morelines,")") 
              ,(morelines++"do {","})") 
            ]                                                                                                                                                                                 

loop ((before,after):xs) program = do
  res <- func (before++program++after) 
  case res of                                                                                                                                                                                 
    True -> return ()
    _ -> loop xs program

loop [] _ = return ()

argsToString args = concat $ intersperse " " args

splitFilter p xs = (filter p xs,filter (not.  p) xs)

main = do                                                                                                                                                                                     
  args <- getArgs                                                                                                                                                                             
  let (useHugs,args') = splitFilter (=="-hugs") args
  hSetBuffering stdout NoBuffering
  hSetBuffering stdin NoBuffering
  let newArgs = argsToString args'
  loop executors newArgs
  removeFile ".temp.hs"
  return ()
