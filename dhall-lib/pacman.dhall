let makeArgList = ./make-argument-list.dhall

let pacman = \(pkgs : List Text) -> "pacman -S" ++ makeArgList pkgs

in  pacman
