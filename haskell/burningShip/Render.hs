import Control.Monad
import Control.Parallel.Strategies
import Data.Complex
import Graphics.UI.SDL as SDL

import BurningShip

main = do
  SDL.init [InitVideo, InitEventthread]
  window <- setVideoMode 1024 1024 32 [HWSurface]
  sequence_ [drawPixel window (x :+ y) (gray $ a) | (B x y a) <- l]
  SDL.flip window
  getEventUntilQuit
  quit

getEventUntilQuit = do
  ev <- pollEvent
  case ev of
    KeyDown (Keysym SDLK_q _ _) -> return ()
    _                           -> (delay 100) >> getEventUntilQuit

drawPixel w (x :+ y) (r,g,b) = do
  let pf = surfaceGetPixelFormat w
  px <- mapRGB pf (normalize r) (normalize g) (normalize b)
  fillRect w (Just $ Rect (floor x) (floor y) 1 1) px
  -- SDL.flip w
    where
      normalize c = round $ c * 255

gray x = (x,x,x)

myCalc c = (fromIntegral $ burningShip 255 c) / 255

data BurningShipRender = B Float Float Float

lp = l `using` parList rpar

l = do
  y <- [0..1024]
  x <- [0..1024]
  let xx = (x - 512) / (4*2048) - 1.76
      yy = (y - 800) / (4*2048)
      ans = myCalc (xx :+ yy)
  return (B x y ans)
