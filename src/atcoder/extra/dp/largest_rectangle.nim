proc largestRectangle[T](height:seq[T]):T =
  var
    st = newSeq[int]()
    height = height
  height.add(0)
  var left = newSeq[int](height.len)
  var ret = T(0)
  for i in 0..<height.len:
    while st.len > 0 and height[st[^1]] >= height[i]:
      ret = max(ret, T(i - left[st[^1]] - 1) * height[st[^1]])
      discard st.pop()
    left[i] = if st.len == 0: -1 else: st[^1]
    st.add(i)
  return ret
