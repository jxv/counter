module Test.Counter.CrementSpec (spec) where

import Prelude hiding (log)

import Test.Hspec
import Control.Monad.Trans (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH

import Counter.Crement (crement)

import Counter.Classes (HasCounter, CounterLog)
import Counter.Types (Action(Increment, Decrement))

mkFixture "Fixture" [''HasCounter, ''CounterLog]

spec :: Spec
spec = do
  describe "crement" $ do
    it "should increment then log the counter" $ do
      let stubCounter = 100
      let stubCounter' = 101

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

    it "should increment then log the counter" $ do
      let stubCounter = 100
      let stubCounter' = 99

      calls <- logTestFixtureT (crement Decrement) def
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
