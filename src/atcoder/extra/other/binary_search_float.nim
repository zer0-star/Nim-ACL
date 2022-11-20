when not declared ATCODER_BINARY_SEARCH_FLOAT_HPP:
  const ATCODER_BINARY_SEARCH_FLOAT_HPP* = 1
  import atcoder/extra/other/floatutils
  import atcoder/extra/math/longdouble

  proc minLeft*[Real](f:proc(x:Real):bool, s: Slice[Real]):Real =
    var (l, r) = (s.a, s.b)
    if not f(r): return Real.getInf
    let half = Real(1) / Real(2)
    while not valid_range(l, r):
      let m = (l + r) * half
      if f(m): r = m
      else: l = m
    return r
  proc maxRight*[Real](f:proc(x:Real):bool, s: Slice[Real]):Real =
    var (l, r) = (s.a, s.b)
    if not f(l): return -Real.getInf
    let half = Real(1) / Real(2)
    while not valid_range(l, r):
      let m = (l + r) * half
      if f(m): l = m
      else: r = m
    return l
