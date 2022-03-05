let Recipe = { commands : List Text }

let copy_from_dest =
      \(arg : { from : Text, dest : Text }) -> "cp ${arg.from} ${arg.dest}"

let copyToHome =
      \(path : Text) -> copy_from_dest { from = ".${path}", dest = "~${path}" }

in  { Recipe, copy_from_dest, copyToHome }
