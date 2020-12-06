when not declared ATCODER_BINARY_SEARCH_FLOAT_HPP:
  const ATCODER_BINARY_SEARCH_FLOAT_HPP* = 1
  import std/sugar
  import atcoder/extra/other/floatutils

  proc minLeft*[Real](f:(Real)->bool, s: Slice[Real]):Real =
    var (l, r) = (s.a, s.b)
    if not f(r): return Real.getInf
    while not valid_range(l, r):
      let m = (l + r) / Real(2)
      if f(m): r = m
      else: l = m
    return r
  proc maxRight*[Real](f:(Real)->bool, s: Slice[Real]):Real =
    var (l, r) = (s.a, s.b)
    if not f(l): return -Real.getInf
    while not valid_range(l, r):
      let m = (l + r) / Real(2)
      if f(m): l = m
      else: r = m
    return l
