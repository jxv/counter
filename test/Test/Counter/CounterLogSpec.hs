module Test.Counter.CounterLogSpec (spec) where

import Prelude hiding (log)

import Test.Hspec
import Control.Monad.Trans (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH

import Counter.CounterLog (logCounter')

import Counter.Console (Console)

mkFixture "Fixture" [''Console]

spec :: Spec
spec = do
  describe "logCounter" $ do
    it "should print the counter to the console" $ do
      let stubCounter = 23
      let stubCounter' = "23"

      calls <- logTestFixtureT (logCounter stubCounter) def
        { _printLine = \msg -> do
            log "printLine"
            lift $ msg `shouldBe` stubCounter'
        }

      calls `shouldBe` ["printLine"]
