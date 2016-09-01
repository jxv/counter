module Lib.Main
  ( main
  , step
  ) where

import Control.Monad (forever)

import Lib.Classes
  ( Prompt(getAction)
  , Crement(crement)
  )

main :: (Prompt m, Crement m) => m ()
main = forever step

step :: (Prompt m, Crement m) => m ()
step = do
  action <- getAction
  crement action
