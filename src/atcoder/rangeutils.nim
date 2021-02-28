when not declared ATCODER_RANGEUTILS_HPP:
  const ATCODER_RANGEUTILS_HPP* = 1
  proc halfOpenEndpoints*(p:Slice[int]):(int,int) = (p.a, p.b + 1)


