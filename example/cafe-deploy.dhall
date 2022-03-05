let lib = ../dhall-lib/lib.dhall

in    { commands =
        [ lib.copyToHome "/.config/fish/config.fish"
        , lib.copyToHome "/.config/starship.toml"
        ]
      }
    : lib.Recipe
