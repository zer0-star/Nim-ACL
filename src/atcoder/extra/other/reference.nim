when not declared ATCODER_REFERENCE_HPP:
  const ATCODER_REFERENCE_HPP* = 1
  import std/macros, std/strformat

  template byaddr*(lhs, typ, ex) =
    when typ is typeof(nil):
      let tmp = addr(ex)
    else:
      let tmp: ptr typ = addr(ex)
    template lhs: untyped = tmp[]

  macro `=&`*(lhs, rhs:untyped) =
    result = newStmtList()
    if lhs.kind == nnkPar:
      for i,t in lhs:
        result.add parseStmt(fmt"""byaddr({$t}, ({rhs.toStrLit}).type, {rhs.toStrLit})""")
    else:
      result.add parseStmt(fmt"""byaddr({$lhs}, ({rhs.toStrLit}).type, {rhs.toStrLit})""")
