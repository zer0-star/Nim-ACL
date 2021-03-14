when not declared ATCODER_CHAEMON_HEADER_HPP:
  const ATCODER_CHAEMON_HEADER_HPP* = 1
  {.hints:off checks:off warnings:off assertions:on optimization:speed.}
  import std/algorithm as algorithm_lib
  import std/sequtils as sequtils_lib
  import std/macros as macros_lib
  import std/math as math_lib
  import std/sets as sets_lib
  import std/tables as tables_lib
  import std/strutils as strutils_lib
  import std/strformat as strformat_lib

  import atcoder/extra/other/internal_sugar
  import atcoder/extra/other/reader
  import atcoder/extra/other/sliceutils
  import atcoder/extra/other/assignment_operator
  import atcoder/extra/other/inf
  import atcoder/extra/other/warlus_operator
  import atcoder/extra/other/seq_array_utils
  include atcoder/extra/other/debug
  import atcoder/extra/other/reference
  import atcoder/extra/other/floatutils
  import atcoder/extra/other/zip

  converter toBool[T:ref object](x:T):bool = x != nil
  converter toBool[T](x:T):bool = x != T(0)

  proc ceilDiv*[T:SomeInteger](a, b:T):T =
    assert b != 0
    if b < 0: return ceilDiv(-a, -b)
    result = a.floorDiv(b)
    if a mod b != 0: result.inc
