module Lib.Classes
  ( Console(..)
  ) where
  
import Lib.Types

class Monad m => Console m where
  readLine :: m String
  printLine :: String -> m ()
