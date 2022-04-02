let foldLeft =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v21.1.0/Prelude/List/foldLeft.dhall

let makeArgumentList =
      \(list : List Text) ->
        foldLeft Text list Text (\(a : Text) -> \(b : Text) -> a ++ " " ++ b) ""

let withArgumentList =
      \(prefix : Text) -> \(args : List Text) -> prefix ++ makeArgumentList args

let homebrew = withArgumentList "brew install"

let pacman = withArgumentList "sudo pacman -S"

let paru = withArgumentList "paru -S"

let aurMakePkg =
      \(pkg : Text) ->
        "git clone https://aur.archlinux.org/${pkg}.git /tmp/dotstingray/${pkg} && cd /tmp/dotstingray/${pkg} && makepkg -si"

in  { useCmd =
        \(cmd : Text) ->
          let cmd-to =
                \(dest : Text) -> \(from : Text) -> "${cmd} ${from} ${dest}"

          in  { fish = cmd-to "~/.config/fish/config.fish"
              , starship = cmd-to "~/.config/starship.toml"
              , git = cmd-to "~/.gitconfig"
              , yabai = cmd-to "~/.yabairc"
              , skhd = cmd-to "~/.skhdrc"
              }
    , Recipe = { commands : List Text }
    , homebrew
    , pacman
    , paru
    , aurMakePkg
    }
