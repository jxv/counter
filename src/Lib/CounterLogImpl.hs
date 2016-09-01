module Lib.CounterLogImpl
  ( logCounter
  ) where

import Lib.Classes (Console(printLine))

logCounter :: Console m => Integer -> m ()
logCounter = printLine . show
