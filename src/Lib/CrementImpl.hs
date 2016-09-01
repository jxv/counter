module Lib.CrementImpl
  ( crement
  ) where

import Lib.Types
import Lib.Classes
  ( HasCounter(getCounter, putCounter)
  , CounterLog(logCounter)
  )

crement :: (HasCounter m, CounterLog m) => Action -> m ()
crement Increment = crementer succ
crement Decrement = crementer pred

crementer :: (HasCounter m, CounterLog m) => (Integer -> Integer) -> m ()
crementer alter = do
  counter <- getCounter
  let counter' = alter counter
  putCounter counter'
  logCounter counter'
