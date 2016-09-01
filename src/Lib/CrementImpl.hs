module Lib.CrementImpl
  ( crement
  ) where

import Lib.Types

crement :: Monad m => Action -> m ()
crement = error "crement"
