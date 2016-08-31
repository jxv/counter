module Main (main) where

import qualified Lib.Main as Lib (main)
import Lib.System (runIO)

main :: IO ()
main = runIO Lib.main
