import System
import Debug.Trace

ackList :: [[Int]]
ackList = [[ack m n | n <- [0..]] | m <- [0..]]
  where
    debugAck m n = trace ("("++show m++","++show n++")") ack m n
    ack m n | m == 0    = n + 1
            | n == 0    = ackList !! (m - 1) !! 1
            | otherwise = ackList !! (m - 1) !! (ackList !! m !! (n - 1))

main = do
  args <- getArgs
  let m = read $ args !! 0
  let n = read $ args !! 1
  print $ ackList !! m !! n
