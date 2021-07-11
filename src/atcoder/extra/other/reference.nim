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
    parseStmt(fmt"""byaddr({lhs.repr}, {rhs.repr}.type, {rhs.repr})""")
