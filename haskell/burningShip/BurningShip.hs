module BurningShip
  ( burningShip
  ) where

import Data.Complex

stepCalc c (rz :+ iz) = c + ((abs rz) :+ (abs iz)) ** 2

calcIterate c = iterate f c
  where
    f = stepCalc c

burningShip lim (0 :+ 0) = lim
burningShip lim pos =
  length $ takeWhile (not.isInfinite) $ take lim $ map absComplex $ calcIterate pos
  where
    absComplex = realPart . abs

main = do
  print $ burningShip 255 (0 :+ 1)
