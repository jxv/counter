module Lib.PromptImpl
  ( getAction'
  ) where

import Lib.Types
import Lib.Classes
  ( Console(readLine)
  , Prompt(getAction)
  )

getAction' :: (Console m, Prompt m) => m Action
getAction' = do
  input <- readLine
  case input of
    "+" -> return Increment
    _ -> getAction
