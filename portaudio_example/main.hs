module Main where

import Sound.PortAudio.Base
import Sound.PortAudio

import Control.Monad (foldM, foldM_, forM_,forever)
import Control.Concurrent.MVar
import Control.Concurrent (threadDelay)
import Text.Printf

import Foreign.C.Types
import Foreign.Storable
import Foreign.ForeignPtr
import Foreign.Marshal.Alloc
import Foreign.Ptr

import qualified Data.Vector as V
import System.IO
import Control.Monad
import Data.List 
import Debug.Trace

sampRate :: Double
sampRate = 44100

framesPerBuffer :: Int
framesPerBuffer = 600

tableSize :: Int
tableSize = 200

data SineTable = SineTable { sine :: V.Vector Float }

newTable :: Float -> Int -> SineTable
newTable m sze = SineTable vec 
 where
    factor = 1
    tabSize = fromInteger $ toInteger sze
    vec = V.fromList $ map (\i -> (0.04*) $ sin $ (((i / tabSize) * pi * 2 * factor))) [0..(tabSize - 1)]

sineTable :: Float -> Int -> SineTable
sineTable m tabbSize = newTable m tabbSize

poker :: (Storable a, Fractional a) => Int -> SineTable -> Float -> Ptr a -> (Int, Int) -> Int -> IO (Int, Int)
poker tabbSize sintab m out (l, r) i = do
    pokeElemOff out (2 * i)      (realToFrac $ (V.!) (sine sintab) l)
    pokeElemOff out (2 * i + 1)  (realToFrac $ (V.!) (sine sintab) r)
    let newL = let x = l + 1 in (if x >= tabbSize then (x - tabbSize) else x)
    let newR = let x = r + 3 in (if x >= tabbSize then (x - tabbSize) else x)
    return (newL, newR)

streamFinished :: String -> IO ()
streamFinished msg = putStrLn ("Stream Completed: " ++ msg)

withBlockingIO ::  IO (Either Error ())
withBlockingIO = do
    let fincallback = Just $ streamFinished "Blocking IO Finished!"
        iterations = 15
        numChannels = 2
    
    withDefaultStream 0 numChannels sampRate (Just framesPerBuffer) Nothing fincallback $ \strm -> do
        startStream strm

        allocaBytes (framesPerBuffer * numChannels) $ \out -> do
            
            out' <- newForeignPtr_ out
            
            let runFunc newSize sintab' num (l, r) _ = do
                (newL', newR') <- foldM (poker newSize sintab' num (out :: Ptr CFloat)) (l, r) [0..(fromIntegral $ framesPerBuffer - 1)]
                writeStream strm (fromIntegral framesPerBuffer) out'
                return (newL', newR')

            forever $ do 
              line <- getChar
              let mnum = elemIndex line "1234567890qwe"
      
              putStrLn "key entered"
              print mnum
               
              case mnum of
                Just num -> do 
                    let sintab = sineTable (fromIntegral num) newSize
                        newSize = (round ( factor * (fromIntegral tableSize)))
                        factor = (1/(2**((fromIntegral num)/12)))
                    foldM_ (runFunc newSize sintab (fromIntegral num) ) (0,0) [0..iterations]
                _ -> return ()
        
        s3 <- stopStream strm
        return $ Right ()

main = do
    hSetBuffering stdin  NoBuffering
    hSetBuffering stdout NoBuffering
    putStrLn $ "Enter notes:"
    withPortAudio $ withBlockingIO
    return ()
