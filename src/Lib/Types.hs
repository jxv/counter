module Lib.Types
  ( Action(..)
  ) where

data Action
  = Increment
  | Decrement
  deriving (Show, Eq)
