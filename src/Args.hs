module Args (parseArgs, Args (Args, recipe, explain)) where

import Data.Semigroup ((<>))
import Data.Text (Text)
import Options.Applicative

data Args = Args
  { recipe :: Text,
    explain :: Bool
  }

args :: Parser Args
args =
  Args
    <$> strOption
      ( long "recipe"
          <> metavar "FILE"
          <> help "Dhall source file which contains how to manage dotfiles"
      )
    <*> switch (long "explain")

opts :: ParserInfo Args
opts =
  info
    (args <**> helper)
    ( fullDesc
        <> progDesc "Run commands defined in the Dhall FILE"
        <> header "dotstingray - dotfiles managed by Dhall"
    )

parseArgs :: IO Args
parseArgs = execParser opts
