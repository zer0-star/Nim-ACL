when not declared ATCODER_LARGEST_RECTANGLE_HPP:
  const ATCODER_LARGEST_RECTANGLE_HPP* = 1

  proc largestRectangle*[T](height: openArray[T]): T =
    var st: seq[int] = @[]
    result = T(0)

    for i in 0 .. height.len:
      let h = if i == height.len: T(0) else: height[i]

      while st.len > 0 and height[st[^1]] >= h:
        let top = st[^1]
        discard st.pop()

        let left = if st.len == 0: -1 else: st[^1]
        let width = i - left - 1

        result = max(result, height[top] * T(width))

      if i < height.len:
        st.add(i)
