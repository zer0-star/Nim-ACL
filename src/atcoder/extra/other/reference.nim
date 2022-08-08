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
        var rhs = fmt"""{rhs.repr}[{i}]"""
        result.add parseStmt(fmt"""byaddr({$t}, {$rhs}.type, {$rhs})""")
    else:
      result.add parseStmt(fmt"""byaddr({$lhs}, {$rhs}.type, {$rhs})""")
