module Counter.Console
  ( Console(..)
  , readLine'
  , printLine'
  ) where

import Control.Monad.IO.Class (MonadIO(liftIO))

class Monad m => Console m where
  readLine :: m String
  printLine :: String -> m ()

readLine' :: MonadIO m => m String
readLine' = liftIO getLine

printLine' :: MonadIO m => String -> m ()
printLine' = liftIO . putStrLn
