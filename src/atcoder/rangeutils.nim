when not declared ATCODER_RANGEUTILS_HPP:
  const ATCODER_RANGEUTILS_HPP* = 1
  template halfOpenEndpoints*[T](s:T, p:Slice[int] | HSlice[int, BackwardsIndex]):(int,int) =
    when p.b is BackwardsIndex:
      (p.a, s.len - int(p.b) + 1)
    else:
      (p.a, p.b + 1)
