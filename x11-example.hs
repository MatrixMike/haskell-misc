{-# OPTIONS_GHC -fwarn-missing-signatures #-}

import Control.Concurrent (threadDelay)
import Control.Monad
import Data.Bits

{-
 ~/cabal/cabal install  X11
 after some chasing and digging the library below is made available by installing X11  ... 
 naming system here ?
-}
import Graphics.X11.Xlib
import Graphics.X11.Xlib.Extras
import System.Exit (ExitCode(..), exitWith)

main :: IO ()
main = do
--    let x1 = 20
  dpy <- openDisplay ""
  let dflt = defaultScreen dpy
      border = blackPixel dpy dflt
      background = whitePixel dpy dflt
      scr = defaultScreenOfDisplay dpy
      visual = defaultVisualOfScreen scr
      attrmask = 0
      x1 = 20
      x2 = 150
      y1 = 20
      y2 = 150     
  rw <- rootWindow dpy dflt
  let winSizeX = 200
  let winSizeY = 200
  
  win <-
    allocaSetWindowAttributes $ \attributes ->
      createWindow
        dpy
        rw
        0
        0
        winSizeX
        winSizeY
        0
        (defaultDepthOfScreen scr)
        inputOutput
        visual
        attrmask
        attributes
  setTextProperty dpy win "Hello my World" wM_NAME
  gc <- createGC dpy win
  mapWindow dpy win
  forM_ (concat $repeat $ [1 .. 100] ++ [99,98 .. 2]) $ \x -> do
    threadDelay 10000
    clearWindow dpy win
    drawInWin x dpy win gc
    flush dpy
 {-
 freeGC dpy gc
 freePixmap dpy p
 exitWith ExitSuccess
 -}

drawInWin :: Integral a => a -> Display -> Drawable -> GC -> IO ()
drawInWin x dpy win gc = do
  bgcolor <- initColor dpy "green"
  fgcolor <- initColor dpy "blue"
  fgcolor <- initColor dpy "red"
{-     let   xx1 = 20
      x2 = 150
      y1 = 20
      y2 = 150 -}
  setForeground dpy gc bgcolor
  fillRectangle dpy win gc 0 0 100 100
  setForeground dpy gc fgcolor
  fillRectangle dpy win gc (2 + fromIntegral x) 2 96 96
  fgcolor <- initColor dpy "blue"
 --   setForeground dpy gc fgcolor
  drawLine dpy win gc  20 20 150 150                 -- x1 y1 x2 y2 

initColor :: Display -> String -> IO Pixel
initColor dpy color = do
  let colormap = defaultColormap dpy (defaultScreen dpy)
  (apros, real) <- allocNamedColor dpy colormap color
  return $ color_pixel apros

--initialiseLine 
