module Test.Lib.MainSpec (spec) where

import Prelude hiding (log)

import Test.Hspec
import Control.Monad.Trans (lift)
import Control.Monad.TestFixture
import Control.Monad.TestFixture.TH

import Lib.Main ()
import Lib.Classes ()
import Lib.Types ()

data Action
  = Increment
  deriving (Show, Eq)

class Monad m => Prompt m where
  getAction :: m Action

class Monad m => Crement m where
  crement :: Action -> m ()

step :: (Prompt m, Crement m) => m ()
step = do
  action <- getAction
  crement action

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
