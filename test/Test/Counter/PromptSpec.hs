module Test.Counter.PromptSpec (spec) where

import Prelude hiding (log)

import Test.Hspec
import Control.Monad.Trans (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH

import Counter.Prompt (getAction')

import Counter.Classes (Console, Prompt)
import Counter.Types (Action(Increment, Decrement))

mkFixture "Fixture" [''Console, ''Prompt]

spec :: Spec
spec = do
  describe "getAction" $ do
    it "should return Increment with good input" $ do
      let stubInput = "+"

      (actualAction, calls) <- evalTestFixtureT getAction' def
        { _readLine = do
           log "readLine"
           return stubInput
        }

      calls `shouldBe` ["readLine"]
      actualAction `shouldBe` Increment

    it "should call itself, getAction, with bad input" $ do
      let stubInput = "BAD INPUT"

      calls <- logTestFixtureT getAction' def
        { _readLine = do
           log "readLine"
           return stubInput
        , _getAction = do
            log "getAction"
            return $ error "getAction"
        }

      calls `shouldBe` ["readLine", "getAction"]


    it "should return Decrement with good input" $ do
      let stubInput = "-"

      (actualAction, calls) <- evalTestFixtureT getAction' def
        { _readLine = do
           log "readLine"
           return stubInput
        }

      calls `shouldBe` ["readLine"]
      actualAction `shouldBe` Decrement
