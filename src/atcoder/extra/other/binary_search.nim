when not declared ATCODER_BINARY_SEARCH_HPP:
  const ATCODER_BINARY_SEARCH_HPP* = 1

  proc minLeft*(f:proc(x:int):bool, s:Slice[int]):int =
    var (l, r) = (s.a - 1, s.b)
    if not f(r): return s.b + 1
    while r > l + 1:
      let d = cast[int]((cast[uint](r) - cast[uint](l)) shr 1)
      let m = l + d
      if f(m): r = m
      else: l = m
    return r
  proc maxRight*(f:proc(x:int):bool, s:Slice[int]):int =
    var (l, r) = (s.a, s.b + 1)
    if not f(l): return s.a - 1
    while r - 1 > l:
      let d = cast[int]((cast[uint](r) - cast[uint](l)) shr 1)
      let m = l + d
      if f(m): l = m
      else: r = m
    return l
