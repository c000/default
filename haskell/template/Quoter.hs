{-# LANGUAGE TemplateHaskell, QuasiQuotes #-}
module Quoter
  ( text
  ) where

import Language.Haskell.TH
import Language.Haskell.TH.Quote

function str = let x = mkName str
               in [|varE x|]

text = QuasiQuoter function undefined undefined undefined
