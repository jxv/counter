module Lib.System
    ( System
    , runIO
    ) where

import Control.Monad.IO.Class (MonadIO)
import Control.Monad.State (MonadState(..), StateT, evalStateT)

import qualified Lib.ConsoleImpl as Console
import qualified Lib.PromptImpl as Prompt
import qualified Lib.CrementImpl as Crement
import qualified Lib.CounterLogImpl as CounterLog
import Lib.Types
import Lib.Classes

newtype System a = System { unSystem :: StateT Integer IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadState Integer)

runIO :: System a -> Integer -> IO a
runIO system counter = evalStateT (unSystem system) counter

instance Console System where
  readLine = Console.readLine
  printLine = Console.printLine

instance Prompt System where
  getAction = Prompt.getAction

instance Crement System where
  crement = Crement.crement

instance HasCounter System where
  getCounter = get
  putCounter = put

instance CounterLog System where
  logCounter = CounterLog.logCounter
