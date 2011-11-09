{-# LANGUAGE TemplateHaskell, QuasiQuotes #-}
module Quoter
  ( text
  ) where

import Language.Haskell.TH
import Language.Haskell.TH.Quote

function str = tupE [(litE.integerL) x | x <- [1..3]]

text = QuasiQuoter function undefined undefined undefined
