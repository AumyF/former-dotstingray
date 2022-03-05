let makeArgList = ./make-argument-list.dhall

let paru = \(pkgs : List Text) -> "paru -S" ++ makeArgList pkgs

in  paru
