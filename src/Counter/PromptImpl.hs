module Counter.PromptImpl
  ( getAction'
  ) where

import Counter.Types
import Counter.Classes
  ( Console(readLine)
  , Prompt(getAction)
  )

getAction' :: (Console m, Prompt m) => m Action
getAction' = do
  input <- readLine
  case input of
    "+" -> return Increment
    "-" -> return Decrement
    _ -> getAction
