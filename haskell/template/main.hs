{-# LANGUAGE QuasiQuotes #-}
import Quoter

main = do
  let hogera = 10 :: Int
  print [text|hogera|]
