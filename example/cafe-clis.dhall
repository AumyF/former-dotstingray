let dotlib = ../dhall-lib/lib.dhall

let pacman = ../dhall-lib/pacman.dhall

let aur-makepkg = ../dhall-lib/aur-makepkg.dhall

let paru = ../dhall-lib/paru.dhall

in    { commands =
        [ pacman
            [ "base-devel"
            , "bat"
            , "fd"
            , "fish"
            , "fzf"
            , "lsd"
            , "mcfly"
            , "neovim"
            , "ripgrep"
            , "tealdeer"
            , "zoxide"
            ]
        , aur-makepkg "paru"
        , paru [ "asdf-vm", "ghq", "gibo" ]
        ]
      }
    : dotlib.Recipe
