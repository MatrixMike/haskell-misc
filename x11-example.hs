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
  dpy <- openDisplay ""
  let dflt = defaultScreen dpy
      border = blackPixel dpy dflt
      background = whitePixel dpy dflt
      scr = defaultScreenOfDisplay dpy
      visual = defaultVisualOfScreen scr
      attrmask = 0
  rw <- rootWindow dpy dflt
  win <-
    allocaSetWindowAttributes $ \attributes ->
      createWindow
        dpy
        rw
        0
        0
        200
        200
        0
        (defaultDepthOfScreen scr)
        inputOutput
        visual
        attrmask
        attributes
  setTextProperty dpy win "Hello World" wM_NAME
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
  setForeground dpy gc bgcolor
  fillRectangle dpy win gc 0 0 200 200
  setForeground dpy gc fgcolor
  fillRectangle dpy win gc (2 + fromIntegral x) 2 96 96

initColor :: Display -> String -> IO Pixel
initColor dpy color = do
  let colormap = defaultColormap dpy (defaultScreen dpy)
  (apros, real) <- allocNamedColor dpy colormap color
  return $ color_pixel apros
