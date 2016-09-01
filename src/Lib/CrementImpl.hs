module Lib.CrementImpl
  ( crement
  ) where

import Lib.Types
import Lib.Classes
  ( HasCounter(getCounter, putCounter)
  , CounterLog(logCounter)
  )

crement :: (HasCounter m, CounterLog m) => Action -> m ()
crement Increment = do
  counter <- getCounter
  let counter' = succ counter
  putCounter counter'
  logCounter counter'
