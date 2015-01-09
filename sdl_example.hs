import Graphics.UI.SDL as SDL

createColor screen r g b = SDL.mapRGB (SDL.surfaceGetPixelFormat screen) r g b

data Player = PlayerFactory {
                    xy :: (Int,Int),
                    isDead :: Bool
                    }

gameinit = do
     SDL.init [SDL.InitEverything]
     SDL.setVideoMode 640 480 32 []
     SDL.setCaption "Video Test!" "video test"
     return (PlayerFactory (320,240) False)       

gameend = SDL.quit

main = gameinit >>= mainLoop >> gameend

initscreen = do
    mainscreen <-  getVideoSurface
    initcolor <-  createColor mainscreen 0 0 0
    SDL.fillRect mainscreen (Just(SDL.Rect 0 0 640 480)) initcolor

mainLoop player = do
      mainscreen <-  getVideoSurface
      initscreen
      playercolor <-  createColor mainscreen 255 255 255
      SDL.fillRect mainscreen (Just(SDL.Rect (fst(xy player)) (snd(xy player)) 32 32)) playercolor
      event <-  SDL.waitEventBlocking
      SDL.flip mainscreen
      result (checkEvent event) 
     where
     checkEvent (KeyDown (Keysym SDLK_UP _ _)) = (player { xy = ((fst(xy player)),(snd(xy player)) - 6) })
     checkEvent (KeyDown (Keysym SDLK_DOWN _ _)) = (player { xy = ((fst(xy player)),(snd(xy player)) + 6) })
     checkEvent (KeyUp (Keysym SDLK_ESCAPE _ _)) = (player { isDead = True })
     checkEvent _ = player
     result obj | isDead obj == True = return ()
                | otherwise = mainLoop obj
