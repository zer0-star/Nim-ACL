when not declared ATCODER_RANGEUTILS_HPP:
  const ATCODER_RANGEUTILS_HPP* = 1
  type RangeType* = Slice[int] | HSlice[int, BackwardsIndex]
  type IndexTYpe* = int | BackwardsIndex
  template halfOpenEndpoints*(p:Slice[int]):(int,int) = (p.a, p.b + 1)
  template `^^`*(s, i: untyped): untyped =
    (when i is BackwardsIndex: s.len - int(i) else: int(i))
  template halfOpenEndpoints*[T](s:T, p:RangeType):(int,int) =
    (p.a, s^^p.b + 1)
