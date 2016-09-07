module Counter.CounterLog
  ( logCounter
  ) where

import Counter.Classes (Console(printLine))

logCounter :: Console m => Integer -> m ()
logCounter = printLine . show
