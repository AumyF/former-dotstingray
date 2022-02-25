let Cmd = { cmd : Text }

let copy_from_dest =
      \(arg : { from : Text, dest : Text }) ->
        { cmd = "cp ${arg.from} ${arg.dest}" }

let copy =
      \(path : Text) -> copy_from_dest { from = ".${path}", dest = "~${path}" }

let ls = { cmd = "ls ~" }

let c = copy "/.config/fish/config.fish"

in  [ ls, ls ] : List Cmd
