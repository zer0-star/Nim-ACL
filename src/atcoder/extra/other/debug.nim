when not declared ATCODER_DEBUG_HPP:
  const ATCODER_DEBUG_HPP* = 1
  import macros, strformat, terminal
  macro debug*(n: varargs[untyped]): untyped =
  #  var a = "stderr.write "
    var a = ""
    a.add "setForegroundColor fgYellow\n"
    a.add "echo "
    for i,x in n:
      a = a & fmt""" "{x.repr} = ", {x.repr} """
      if i < n.len - 1:
        a.add(""", ", ",""")
    a.add "\n"
    a.add "resetAttributes()"
    parseStmt(a)
