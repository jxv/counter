module Lib.System
    ( System
    , runIO
    ) where

import Control.Monad.IO.Class (MonadIO)

import qualified Lib.ConsoleImpl as Console
import Lib.Types
import Lib.Classes

newtype System a = System { unSystem :: IO a }
  deriving (Functor, Applicative, Monad, MonadIO)

runIO :: System a -> IO a
runIO system = unSystem system

instance Console System where
  readLine = Console.readLine
  printLine = Console.printLine
