module Counter.CounterLog
  ( CounterLog(..)
  , logCounter'
  ) where

import Counter.Console (Console(printLine))

class Monad m => CounterLog m where
  logCounter :: Integer -> m ()

logCounter' :: Console m => Integer -> m ()
logCounter' = printLine . show
