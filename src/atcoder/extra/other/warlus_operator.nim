when not declared ATCODER_CHAEMON_WARLUS_OPERATOR_HPP:
  const ATCODER_CHAEMON_WARLUS_OPERATOR_HPP* = 1
  import strformat, macros
  proc discardableId*[T](x: T): T {.discardable.} = x

  macro `:=`*(x, y: untyped): untyped =
    var strBody = ""
    if x.kind == nnkPar:
      for i,xi in x:
        strBody &= fmt"""{'\n'}{xi.repr} := {y[i].repr}{'\n'}"""
    else:
      strBody &= fmt"""{'\n'}when declaredInScope({x.repr}):{'\n'}  {x.repr} = {y.repr}{'\n'}else:{'\n'}  var {x.repr} = {y.repr}{'\n'}"""
    strBody &= fmt"discardableId({x.repr})"
    parseStmt(strBody)
