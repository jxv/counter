module Counter.HasCounter
  ( HasCounter(..)
  ) where

class Monad m => HasCounter m where
  getCounter :: m Integer
  putCounter :: Integer -> m ()
