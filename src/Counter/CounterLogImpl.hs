module Counter.CounterLogImpl
  ( logCounter
  ) where

import Counter.Classes (Console(printLine))

logCounter :: Console m => Integer -> m ()
logCounter = printLine . show
