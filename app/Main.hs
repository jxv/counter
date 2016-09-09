module Main (main) where

import qualified Counter.Main as Counter (main)
import Counter.Monad (runCounter)

main :: IO ()
main = runCounter Counter.main 0
