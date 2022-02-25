{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

module Cli (main) where

import Data.Text (unpack)
import Data.Vector (Vector, toList)
import Dhall
import GHC.IO.Handle (Handle, hFlush)
import System.Exit (exitSuccess)
import System.IO (stdout)
import System.Process

newtype Cmd = Cmd {cmd :: String} deriving (Generic, Show)

instance FromDhall Cmd

runCmd :: Cmd -> IO (Maybe Handle, Maybe Handle, Maybe Handle, ProcessHandle)
runCmd Cmd {cmd} = do
  createProcess $ shell cmd

showCmd :: Cmd -> String
showCmd Cmd {cmd} =
  cmd

confirm :: [Cmd] -> IO ()
confirm cmd = do
  putStrLn "The following commands will be executed:"
  mapM_ (putStrLn . showCmd) cmd
  putStr "Are you sure you want to run them? [y/n, default: n] "
  hFlush stdout

  ln <- getLine
  case ln of
    "y" -> return ()
    _ -> do
      putStrLn "Canceled."
      exitSuccess

main :: IO ()
main = do
  parsed <- input auto "./foo.dhall"

  confirm parsed

  mapM_ runCmd parsed
