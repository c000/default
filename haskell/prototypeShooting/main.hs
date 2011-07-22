import Data.Set
import Data.Maybe (catMaybes)
import System.IO (hFlush, stdout)

import Graphics.UI.SDL as SDL

import qualified Resources as R

data GameConfig = GameConfig
  { windowWidth  :: Int
  , windowHeight :: Int
  }

defaultConfig = GameConfig 400 600

data Game = GameStruct
  { gameWindow :: Surface
  , keyState :: Set SDLKey
  , player :: (Int, Int)
  , images :: R.Images
  , frames :: Int
  }

initGame (GameConfig w h) = do
  SDL.init [InitEverything]
  window <- setVideoMode w h 16 [HWSurface, DoubleBuf]
  img <- R.loadImages
  return $ GameStruct
    { gameWindow = window
    , keyState = empty
    , player = (0, 0)
    , images = img
    , frames = 0
    }

quitGame (GameStruct {gameWindow = w}) = do
  freeSurface w
  quit

updateGame g0@(GameStruct {keyState = key}) = do
  g1 <- getEvents g0
  let g2 = stepGame g1
  render g2
  if isQuit then return ()
            else updateGame g2
    where
      isQuit = member SDLK_q key

getEvents g0@(GameStruct {keyState = sk}) = do
  e <- pollEvent
  case e of
    KeyDown (Keysym key _ _) -> getEvents $ g0 {keyState = insert key sk}
    KeyUp   (Keysym key _ _) -> getEvents $ g0 {keyState = delete key sk}
    NoEvent                  -> return g0
    _                        -> getEvents g0

stepGame g0@(GameStruct {keyState = keys}) = f g0
  where 
    keyList :: [SDLKey]
    keyList = toList keys
    f :: Game -> Game
    f = foldr1 (.) $
        defaultStep :
        ( catMaybes
        . (Prelude.map keyToAction)
        ) keyList
    defaultStep g@(GameStruct {frames = f}) = g {frames = f+1}

keyToAction :: SDLKey -> Maybe (Game -> Game)
keyToAction key = case key of
  SDLK_DOWN  -> Just $ movePlayer   0   6
  SDLK_UP    -> Just $ movePlayer   0 (-6)
  SDLK_RIGHT -> Just $ movePlayer   6   0
  SDLK_LEFT  -> Just $ movePlayer (-6)  0
  _          -> Nothing
  where
    movePlayer :: Int -> Int -> Game -> Game
    movePlayer x y g0@(GameStruct { player = (x0,y0)})
      = g0 { player = (x0+x, y0+y) }

render
  g0@(GameStruct { gameWindow = w
                 , player = (px, py)
                 , images = R.Images { R.backGround = bg
                                     , R.player = p
                                     }
                 , frames = f
                 })
  = do bgRendering
       True <- blitSurface p Nothing w (Just $ Rect px py 0 0)
       SDL.flip w
       return g0
  where
    bgRendering = do
      let positionY = 2 * f `mod` 300
      True <- blitSurface bg Nothing w (Just $ Rect 0 (positionY-300) 0 0)
      True <- blitSurface bg Nothing w (Just $ Rect 0  positionY      0 0)
      True <- blitSurface bg Nothing w (Just $ Rect 0 (positionY+300) 0 0)
      return ()

main = do
  game <- initGame defaultConfig
  updateGame game
  quitGame game
