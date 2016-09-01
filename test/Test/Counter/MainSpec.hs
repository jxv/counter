module Test.Counter.MainSpec (spec) where

import Prelude hiding (log)

import Test.Hspec
import Control.Monad.Trans (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH

import Counter.Main (step)
import Counter.Classes (Prompt, Crement)
import Counter.Types (Action(Increment))

mkFixture "Fixture" [''Prompt, ''Crement]

spec :: Spec
spec = do
  describe "step" $ do
    it "should increment the counter" $ do
      let stubAction = Increment

      calls <- logTestFixtureT step def
        { _getAction = do
            log "getAction"
            return stubAction
        , _crement = \action -> do
            log "crement"
            lift $ action `shouldBe` stubAction
        }

      calls `shouldBe` ["getAction", "crement"]
