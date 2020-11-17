when not declared ATCODER_BINARY_SEARCH_HPP:
  const ATCODER_BINARY_SEARCH_HPP* = 1
  import sugar

  proc findMin*(f:(int)->bool, s:Slice[int]):int =
    var (l, r) = (s.a - 1, s.b)
    if not f(r): return s.b + 1
    while r - l > 1:
      let m = (l + r) shr 1
      if f(m): r = m
      else: l = m
    return r
  proc findMax*(f:(int)->bool, s:Slice[int]):int =
    var (l, r) = (s.a, s.b + 1)
    if not f(l): return s.a - 1
    while r - l > 1:
      let m = (l + r) shr 1
      if f(m): l = m
      else: r = m
    return l
