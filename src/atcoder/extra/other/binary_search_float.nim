when not declared ATCODER_BINARY_SEARCH_FLOAT_HPP:
  const ATCODER_BINARY_SEARCH_FLOAT_HPP* = 1
  import sugar, math

  proc valid_range(l, r, eps:float):bool =
    let d = r - l
    if d < eps: return true
    if l <= 0.0 and 0.0 <= r: return false
    return d < eps * min(abs(l), abs(r))
  proc findMin*(f:(float)->bool, s: Slice[float], eps = 1e-9):float =
    var (l, r) = (s.a, s.b)
    if not f(r): return Inf
    while not valid_range(l, r, eps):
      let m = (l + r) * 0.5
      if f(m): r = m
      else: l = m
    return r
  proc findMax*(f:(float)->bool, s: Slice[float], eps = 1e-9):float =
    var (l, r) = (s.a, s.b)
    if not f(l): return -Inf
    while not valid_range(l, r, eps):
      let m = (l + r) * 0.5
      if f(m): l = m
      else: r = m
    return l
