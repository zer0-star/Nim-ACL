when not declared ATCODER_DEBUG_HPP:
  const ATCODER_DEBUG_HPP* = 1
  import macros, strformat, terminal, strutils
  import atcoder/extra/other/inf

  macro debugImpl*(n:varargs[untyped]): untyped =
    #  var a = "stderr.write "
    var a = ""
#    a.add "stderr.write "
    a.add "styledWriteLine stderr, fgYellow, "
    for i,x in n:
      if x.kind == nnkStrLit:
        a &= fmt"{x.toStrLit}  "
        if i < n.len - 1:
          a.add(""", " ",""")
      else:
        let s = fmt"{x.toStrLit}".replace("\n", "").replace("  ", " ")
        var name = s.escape(prefix = "", suffix = "")
        a &= fmt""" "{name} = ", infRepr({s}) """
        if i < n.len - 1:
          a.add(""", ", ",""")
    a.add "\n"
    parseStmt(a)
  template debug*(n: varargs[untyped]): untyped =
    const EVAL =
      when declared DEBUG: DEBUG
      else: false
    when EVAL:
      debugImpl(n)
