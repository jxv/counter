module Counter.ConsoleImpl
  ( readLine
  , printLine
  ) where

import Control.Monad.IO.Class (MonadIO(liftIO))

readLine :: MonadIO m => m String
readLine = liftIO getLine

printLine :: MonadIO m => String -> m ()
printLine = liftIO . putStrLn
