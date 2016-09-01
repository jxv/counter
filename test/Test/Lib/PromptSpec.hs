module Test.Lib.PromptSpec (spec) where

import Prelude hiding (log)

import Test.Hspec
import Control.Monad.Trans (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH

import Lib.Classes (Console(readLine), Prompt(getAction))
import Lib.Types (Action(Increment))

mkFixture "Fixture" [''Console, ''Prompt]

getAction' :: (Console m, Prompt m) => m Action
getAction' = do
  input <- readLine
  case input of
    "+" -> return Increment
    _ -> getAction


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
