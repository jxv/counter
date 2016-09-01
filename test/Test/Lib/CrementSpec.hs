module Test.Lib.CrementSpec (spec) where

import Prelude hiding (log)

import Test.Hspec
import Control.Monad.Trans (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH

import Lib.Types (Action(Increment))

class Monad m => HasCounter m where
  getCounter :: m Integer
  putCounter :: Integer -> m ()

class Monad m => CounterLog m where
  logCounter :: Integer -> m ()

crement :: (HasCounter m, CounterLog m) => Action -> m ()
crement Increment = do
  counter <- getCounter
  let counter' = succ counter
  putCounter counter'
  logCounter counter'

mkFixture "Fixture" [''HasCounter, ''CounterLog]

spec :: Spec
spec = do
  describe "crement" $ do
    it "should increment then log the counter" $ do
      let stubCounter = 100
      let stubCounter' = succ stubCounter

      calls <- logTestFixtureT (crement Increment) def
        { _getCounter = do
            log "getCounter"
            return stubCounter
        , _putCounter = \counter -> do
            log "putCounter"
            lift $ counter `shouldBe` stubCounter'
        , _logCounter = \counter -> do
            log "logCounter"
            lift $ counter `shouldBe` stubCounter'
        }

      calls `shouldBe` ["getCounter", "putCounter", "logCounter"]
