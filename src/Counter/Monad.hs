module Counter.Monad
    ( Counter
    , runCounter
    ) where

import Control.Monad.IO.Class (MonadIO)
import Control.Monad.State (MonadState(..), StateT, evalStateT)

import qualified Counter.Console as Console
import qualified Counter.Prompt as Prompt
import qualified Counter.Crement as Crement
import qualified Counter.CounterLog as CounterLog
import Counter.Types
import Counter.Classes

newtype Counter a = Counter { unCounter :: StateT Integer IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadState Integer)

runCounter :: Counter a -> Integer -> IO a
runCounter counter count = evalStateT (unCounter counter) count

instance Console Counter where
  readLine = Console.readLine
  printLine = Console.printLine

instance Prompt Counter where
  getAction = Prompt.getAction'

instance Crement Counter where
  crement = Crement.crement

instance HasCounter Counter where
  getCounter = get
  putCounter = put

instance CounterLog Counter where
  logCounter = CounterLog.logCounter
