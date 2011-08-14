import Data.ByteString as B
import System.IO

main = do
  hSetBuffering stdout $ BlockBuffering Nothing
  B.putStr $ B.pack [0x55]
  main
