module Counter.Types
  ( Action(..)
  ) where

data Action
  = Increment
  | Decrement
  deriving (Show, Eq)
