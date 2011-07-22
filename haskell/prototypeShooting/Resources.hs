module Resources where

import Graphics.UI.SDL
import Graphics.UI.SDL.Image

data Images = Images
  { backGround
  , enemy
  , lifeBarRed
  , player
  , whiteBoard
  , bullet
  , lifeBar
  , playerBullet
  , strongEnemy :: Surface
  }

loadImages = do
  p <- load "PrototypeShootingContent/Images/player.png"
  return $ Images
    { player = p }
