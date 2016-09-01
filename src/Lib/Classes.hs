module Lib.Classes
  ( Console(..)
  , Prompt(..)
  , Crement(..)
  ) where
  
import Lib.Types

class Monad m => Console m where
  readLine :: m String
  printLine :: String -> m ()

class Monad m => Prompt m where
  getAction :: m Action

class Monad m => Crement m where
  crement :: Action -> m ()
