when not declared ATCODER_EXTRA_OTHER_SHADOWING_HPP:
  const ATCODER_EXTRA_OTHER_SHADOWING_HPP* = 1
  import macros

  macro shadow*(v:varargs[untyped]): untyped =
    result = newStmtList()
    for x in v:
      result.add quote do:
        var `x` {.used.} = `x`
