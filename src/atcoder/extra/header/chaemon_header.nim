when not declared ATCODER_CHAEMON_HEADER_HPP:
  const ATCODER_CHAEMON_HEADER_HPP* = 1

  {.hints: off warnings: off assertions: on optimization: speed.}
  when declared(DO_CHECK):
    when DO_CHECK:
      static: echo "check is on"
      {.checks: on.}
    else:
      static: echo "check is off"
      {.checks: off.}
  else:
    static: echo "check is on"
    {.checks: on.}

  import std/algorithm as algorithm_lib
  import std/sequtils as sequtils_lib
  import std/macros as macros_lib
  import std/math as math_lib except ceilDiv
  import std/sets as sets_lib
  import std/tables as tables_lib
  import std/strutils as strutils_lib
  import std/strformat as strformat_lib
  import std/options as options_lib
  import std/bitops as bitops_lib
  import std/streams as streams_lib
  import std/lists as lists_lib
  import std/deques as deques_lib

  #import atcoder/extra/forward_compatibility/internal_sugar
  include atcoder/extra/forward_compatibility/hash_func
  import atcoder/extra/other/reader
  import atcoder/extra/other/cfor
  import atcoder/extra/other/sliceutils
  import atcoder/extra/other/assignment_operator
  import atcoder/extra/other/inf
  import atcoder/extra/other/warlus_operator
  import atcoder/extra/other/shadowing
  import atcoder/extra/other/seq_array_utils
  include atcoder/extra/other/debug
  import atcoder/extra/other/reference
  #import atcoder/extra/other/floatutils
  import atcoder/extra/other/zip
  import atcoder/extra/other/solve_proc
  import atcoder/extra/other/divutils

  when declared USE_DEFAULT_TABLE:
    when USE_DEFAULT_TABLE:
      proc `[]`[A, B](self: var Table[A, B], key: A): var B =
        discard self.hasKeyOrPut(key, B.default)
        tables_lib.`[]`(self, key)

  # converter toBool[T:ref object](x:T):bool = x != nil
  # converter toBool[T](x:T):bool = x != T(0)
  # misc
  proc `<`[T](a, b: seq[T]): bool =
    for i in 0 ..< min(a.len, b.len):
      if a[i] < b[i]: return true
      elif a[i] > b[i]: return false
    if a.len < b.len: return true
    else: return false

  proc `pred`*[T: SomeInteger](a: seq[T]): seq[T] = a.mapIt(it - 1)
  proc `succ`*[T: SomeInteger](a: seq[T]): seq[T] = a.mapIt(it + 1)
  macro `Pred`*(a: varargs[untyped]): auto =
    result = newStmtList()
    for a in a:
      result.add quote do:
        var `a` = pred(`a`)
  macro `Succ`*(a: varargs[untyped]): auto =
    result = newStmtList()
    for a in a:
      result.add quote do:
        var `a` = succ(`a`)
  proc `-`(a, b: char): int = a.ord - b.ord
  proc `+`(a: char, b: int): char = (a.ord + b).chr
  proc `-`(a: char, b: int): char = (a.ord - b).chr
