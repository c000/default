import Data.Set
import Data.Maybe (catMaybes)
import Graphics.UI.SDL as SDL

import qualified Resources as R

data GameConfig = GameConfig
  { windowWidth  :: Int
  , windowHeight :: Int
  }

defaultConfig = GameConfig 600 400

data Game = GameStruct
  { gameWindow :: Surface
  , keyState :: Set SDLKey
  , player :: (Int, Int)
  , images :: R.Images
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
    }

quitGame (GameStruct {gameWindow = w}) = do
  freeSurface w
  quit

updateGame g0@(GameStruct {}) = do
  g1 <- getEvents g0
  let g2 = stepGame g1
  render g2
  updateGame g2

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
        id :
        ( catMaybes
        . (Prelude.map keyToAction)) keyList

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
                 , images = R.Images { R.player = p
                                     }
                 })
  = do True <- blitSurface p Nothing w (Just $ Rect px py 0 0)
       SDL.flip w
       return g0

main = do
  game <- initGame defaultConfig
  updateGame game
  quitGame game
