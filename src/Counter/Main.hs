module Counter.Main
  ( main
  , step
  ) where

import Control.Monad (forever)

import Counter.Prompt (Prompt(getAction))
import Counter.Crement (Crement(crement))

main :: (Prompt m, Crement m) => m ()
main = forever step

step :: (Prompt m, Crement m) => m ()
step = do
  action <- getAction
  crement action
