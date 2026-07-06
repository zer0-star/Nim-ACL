when not declared ATCODER_CURLY_INIT_HPP:
  const ATCODER_CURLY_INIT_HPP* = 1
  import std/macros, std/sequtils, std/strutils

  macro `{}`*(t: typedesc, a: varargs[untyped]):untyped =
    parseStmt(t.repr & ".init(" & a.mapIt(it.repr).join(",") & ")")


