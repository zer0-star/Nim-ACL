when not declared ATCODER_CHAEMON_HEADER_HPP:
  const ATCODER_CHAEMON_HEADER_HPP* = 1

  {.hints:off warnings:off assertions:on optimization:speed.}
  when declared(DO_CHECK):
    when DO_CHECK:
      static: echo "check is on"
      {.checks:on.}
    else:
      static: echo "check is off"
      {.checks:off.}
  else:
    static: echo "check is on"
    {.checks:on.}
  #import atcoder/extra/other/internal_sugar
#  import std/sugar
  import atcoder/extra/other/reader
  #import atcoder/extra/other/cfor
  import atcoder/extra/other/assignment_operator
  import atcoder/extra/other/inf
  import atcoder/extra/other/warlus_operator
  import atcoder/extra/other/seq_array_utils
  include atcoder/extra/other/debug
  import atcoder/extra/other/solve_proc

  import std/tables as tables_lib
  when declared USE_DEFAULT_TABLE:
    when USE_DEFAULT_TABLE:
      proc `[]`[A, B](self: var Table[A, B], key: A): var B =
        discard self.hasKeyOrPut(key, B.default)
        tables_lib.`[]`(self, key)

  # converter toBool[T:ref object](x:T):bool = x != nil
  # converter toBool[T](x:T):bool = x != T(0)
  # misc
  proc `<`*[T](a, b:seq[T]):bool =
    for i in 0 ..< min(a.len, b.len):
      if a[i] < b[i]: return true
      elif a[i] > b[i]: return false
    if a.len < b.len: return true
    else: return false

  proc ceilDiv*[T:SomeInteger](a, b:T):T =
    assert b != 0
    if b < 0: return ceilDiv(-a, -b)
    result = a.floorDiv(b)
    if a mod b != 0: result.inc

  template `/^`*[T:SomeInteger](a, b:T):T = ceilDiv(a, b)

  proc `-`(a, b: char): int = a.ord - b.ord
  proc `+`(a: char, b: int): char = (a.ord + b).chr
  proc `-`(a: char, b: int): char = (a.ord - b).chr
