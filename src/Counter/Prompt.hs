module Counter.Prompt
  ( Prompt(..)
  , getAction'
  ) where

import Counter.Types
import Counter.Console (Console(readLine))

class Monad m => Prompt m where
  getAction :: m Action

getAction' :: (Console m, Prompt m) => m Action
getAction' = do
  input <- readLine
  case input of
    "+" -> return Increment
    "-" -> return Decrement
    _ -> getAction
