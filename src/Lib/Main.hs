module Lib.Main
  ( main
  , helloMessage
  ) where

import Lib.Classes (Console(readLine, printLine))

helloMessage :: String -> String
helloMessage target = "Hello, " ++ target ++ "!"

main :: Console m => m ()
main = do
  target <- readLine
  printLine $ helloMessage target
