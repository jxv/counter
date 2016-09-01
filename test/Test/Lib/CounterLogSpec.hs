module Test.Lib.CounterLogSpec (spec) where

import Prelude hiding (log)

import Test.Hspec
import Control.Monad.Trans (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH

import Lib.Classes (Console(printLine))

mkFixture "Fixture" [''Console]

logCounter :: Console m => Integer -> m ()
logCounter = printLine . show

spec :: Spec
spec = do
  describe "logCounter" $ do
    it "should print the counter to the console" $ do
      let stubCounter = 23
      let stubCounter' = show stubCounter

      calls <- logTestFixtureT (logCounter stubCounter) def
        { _printLine = \msg -> do
            log "printLine"
            lift $ msg `shouldBe` stubCounter'
        }

      calls `shouldBe` ["printLine"]
