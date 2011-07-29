import GHC.Conc
import System

ack :: Int -> Int -> Int
ack m n | m == 0    = n + 1
        | n == 0    = ack (m - 1) 1
        | otherwise = nextM `par` nextN `pseq` ack nextM nextN
  where
    nextM = m-1
    nextN = ack m (n-1)

main = do
    args <- getArgs
    let m = read $ args !! 0
    let n = read $ args !! 1
    print $ ack m n
