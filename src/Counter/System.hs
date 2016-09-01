module Counter.System
    ( System
    , runIO
    ) where

import Control.Monad.IO.Class (MonadIO)
import Control.Monad.State (MonadState(..), StateT, evalStateT)

import qualified Counter.ConsoleImpl as Console
import qualified Counter.PromptImpl as Prompt
import qualified Counter.CrementImpl as Crement
import qualified Counter.CounterLogImpl as CounterLog
import Counter.Types
import Counter.Classes

newtype System a = System { unSystem :: StateT Integer IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadState Integer)

runIO :: System a -> Integer -> IO a
runIO system counter = evalStateT (unSystem system) counter

instance Console System where
  readLine = Console.readLine
  printLine = Console.printLine

instance Prompt System where
  getAction = Prompt.getAction'

instance Crement System where
  crement = Crement.crement

instance HasCounter System where
  getCounter = get
  putCounter = put

instance CounterLog System where
  logCounter = CounterLog.logCounter
