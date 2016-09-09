module Counter.Monad
  ( Counter
  , runCounter
  ) where

import Control.Monad.IO.Class (MonadIO)
import Control.Monad.State (MonadState(..), StateT, evalStateT)

import Counter.Types
import Counter.HasCounter
import Counter.Console
import Counter.Prompt
import Counter.Crement
import Counter.CounterLog

newtype Counter a = Counter { unCounter :: StateT Integer IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadState Integer)

runCounter :: Counter a -> Integer -> IO a
runCounter counter count = evalStateT (unCounter counter) count

instance Console Counter where
  readLine = readLine'
  printLine = printLine'

instance Prompt Counter where
  getAction = getAction'

instance Crement Counter where
  crement = crement'

instance HasCounter Counter where
  getCounter = get
  putCounter = put

instance CounterLog Counter where
  logCounter = logCounter'
