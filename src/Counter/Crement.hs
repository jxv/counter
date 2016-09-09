module Counter.Crement
  ( Crement(..)
  , crement'
  ) where

import Counter.Types
import Counter.HasCounter (HasCounter(getCounter, putCounter))
import Counter.CounterLog (CounterLog(logCounter))

class Monad m => Crement m where
  crement :: Action -> m ()

crement' :: (HasCounter m, CounterLog m) => Action -> m ()
crement' Increment = crementer succ
crement' Decrement = crementer pred

crementer :: (HasCounter m, CounterLog m) => (Integer -> Integer) -> m ()
crementer alter = do
  counter <- getCounter
  let counter' = alter counter
  putCounter counter'
  logCounter counter'
