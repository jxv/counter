module Main (main) where

import qualified Counter.Main as Counter (main)
import qualified Counter.System as Counter (runIO)

main :: IO ()
main = Counter.runIO Counter.main 0
