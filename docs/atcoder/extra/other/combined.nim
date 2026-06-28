import macros
macro Please(x): untyped = nnkStmtList.newTree()

Please use Nim-ACL
Please use Nim-ACL
Please use Nim-ACL



import macros;macro ImportExpand(s:untyped):untyped = parseStmt($s[2])
when not declared ATCODER_SHADOWING_HPP:
  const ATCODER_SHADOWING_HPP* = 1
  import macros
  proc discardableId*[T](x: T): T {.discardable.} = x

  macro shadow*(v:varargs[untyped]): untyped =
    result = newStmtList()
    for x in v:
      result.add quote do:
        var `x` = `x`

proc f(a, b, c:int) =
  shadow a, b, c
  a.inc

echo f(1, 2, 3)
