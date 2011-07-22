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
  bg  <- load "PrototypeShootingContent/Images/background.png"
  e   <- load "PrototypeShootingContent/Images/enemy.png"
  lbr <- load "PrototypeShootingContent/Images/LifeBarRed.png"
  p   <- load "PrototypeShootingContent/Images/player.png"
  wb  <- load "PrototypeShootingContent/Images/whiteBoard.png"
  b   <- load "PrototypeShootingContent/Images/bullet.png"
  lb  <- load "PrototypeShootingContent/Images/LifeBar.png"
  pb  <- load "PrototypeShootingContent/Images/playerBullet.png"
  se  <- load "PrototypeShootingContent/Images/strongEnemy.png"
  return $ Images
    { backGround = bg
    , enemy = e
    , lifeBarRed = lbr
    , player = p
    , whiteBoard = wb
    , bullet = b
    , lifeBar = lb
    , playerBullet = pb
    , strongEnemy = se
    }
