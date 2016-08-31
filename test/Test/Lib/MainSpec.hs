module Test.Lib.MainSpec (spec) where

import Prelude hiding (log)

import Test.Hspec
import Control.Monad.Trans (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH

import Lib.Main (main, helloMessage)
import Lib.Classes (Console)

mkFixture "Fixture" [''Console]

spec :: Spec
spec = do
  describe "main" $ do
    it "should print the hello message" $ do
      let stubInput = "World"
      
      calls <- logTestFixtureT main def
        { _readLine = do
            log "readLine"
            return stubInput
        , _printLine = \msg -> do
            log "printLine"
            lift $ msg `shouldBe` helloMessage stubInput
        }
      calls `shouldBe` ["readLine", "printLine"]
