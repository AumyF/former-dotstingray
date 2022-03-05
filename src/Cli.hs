{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

module Cli (main) where

import Args (Args (Args), parseArgs)
import Data.Text (pack, unpack)
import Data.Vector (Vector, toList)
import Dhall
import GHC.IO.Handle (Handle, hFlush)
import System.Exit (ExitCode (ExitFailure), die, exitFailure, exitSuccess)
import System.FilePath.Posix (takeDirectory)
import System.IO (hPutStrLn, stderr, stdout)
import System.Process (ProcessHandle, createProcess, shell)

newtype Cmd = Cmd {cmd :: String} deriving (Generic, Show)

newtype Recipe = Recipe
  { commands :: Vector Text
  }
  deriving (Show, Generic)

instance FromDhall Recipe

runCmd :: Text -> IO (Maybe Handle, Maybe Handle, Maybe Handle, ProcessHandle)
runCmd command =
  createProcess $ shell $ unpack command

confirm :: Recipe -> IO ()
confirm Recipe {commands} = do
  putStrLn "The following commands will be executed:"
  mapM_ print commands
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
  Args recipePath explain <- parseArgs

  let recipeRootDir = takeDirectory $ unpack recipePath

  if recipeRootDir /= "."
    then do
      hPutStrLn stderr "ERROR: To avoid an issue about relative directory, dotstingray can read only files in the current directory."
      die $ "  Try `cd " ++ recipeRootDir ++ "` and run the CLI again."
    else do
      parsed <- input auto recipePath

      confirm parsed

      mapM_ runCmd $ commands parsed
