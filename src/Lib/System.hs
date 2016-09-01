module Lib.System
    ( System
    , runIO
    ) where

import Control.Monad.IO.Class (MonadIO)

import qualified Lib.ConsoleImpl as Console
import qualified Lib.PromptImpl as Prompt
import qualified Lib.CrementImpl as Crement
import Lib.Types
import Lib.Classes

newtype System a = System { unSystem :: IO a }
  deriving (Functor, Applicative, Monad, MonadIO)

runIO :: System a -> IO a
runIO system = unSystem system

instance Console System where
  readLine = Console.readLine
  printLine = Console.printLine

instance Prompt System where
  getAction = Prompt.getAction

instance Crement System where
  crement = Crement.crement
