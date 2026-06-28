when not declared ATCODER_CHAEMON_WARLUS_OPERATOR_HPP:
  const ATCODER_CHAEMON_WARLUS_OPERATOR_HPP* = 1
  import macros
  proc discardableId*[T](x: T): T {.discardable.} = x

  proc warlusImpl(x, y:NimNode):NimNode =
    # すでに定義されているものに代入するような使い方はあまりしない
    # またこの書き方をすると関数とかで不便になることが多いのでどうしようか
    #return quote do:
    #  when declaredInScope(`x`):
    #    `x` = `y`
    #  else:
    #    var `x` = `y`
    return quote do:
      var `x` = `y`

  macro `:=`*(x, y: untyped): untyped =
    result = newStmtList()
    if x.kind == nnkCurly:
      for i,xi in x: result.add warlusImpl(xi, y)
    elif x.kind == nnkPar:
      for i,xi in x: result.add warlusImpl(xi, y[i])
    else:
      result.add warlusImpl(x, y)
      result.add quote do:
        discardableId(`x`)
