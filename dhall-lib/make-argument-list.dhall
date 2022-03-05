let foldLeft =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v21.1.0/Prelude/List/foldLeft.dhall

in  \(list : List Text) ->
      foldLeft Text list Text (\(a : Text) -> \(b : Text) -> a ++ " " ++ b) ""
