when not declared ATCODER_CHAEMON_WARLUS_OPERATOR_HPP:
  const ATCODER_CHAEMON_WARLUS_OPERATOR_HPP* = 1
  import strformat, macros
  proc discardableId*[T](x: T): T {.discardable.} = x

  proc warlusImpl(x, y:string):string =
    fmt"""when declaredInScope({x}):{'\n'} {x} = {y}{'\n'}else:{'\n'}  var {x} = {y}{'\n'}"""

  macro `:=`*(x, y: untyped): untyped =
    var strBody = ""
    if x.kind == nnkCurly:
      for i,xi in x: strBody &= warlusImpl(xi.repr, y.repr)
    elif x.kind == nnkPar:
      for i,xi in x: strBody &= warlusImpl(xi.repr, y[i].repr)
    else:
      strBody &= warlusImpl(x.repr, y.repr)
      strBody &= fmt"discardableId({x.repr})"
    parseStmt(strBody)
