when not declared ATCODER_LONGEST_INCREASING_SUBSEQUENCE_HPP:
  const ATCODER_LONGEST_INCREASING_SUBSEQUENCE_HPP* = 1
  proc longestIncreasingSubsequence*[T](a:openArray[T], strict:static[bool] = false, getSeq:static[bool] = false):auto =
    var lis = newSeq[T]()
    when getSeq:
      var
        tail = -1
        prev = newSeq[int](a.len)
        lis_i = newSeq[int]()
    for i,p in a:
      var it: int
      when strict: it = lis.lowerBound(p)
      else: it = lis.upperBound(p)
      if it == lis.len:
        lis.add(p)
        when getSeq:
          tail = i
          prev[i] = if lis_i.len > 0: lis_i[^1] else: -1
          lis_i.add(i)
      else:
        lis[it] = p
        when getSeq:
          lis_i[it] = i
          prev[i] = if it > 0: lis_i[it - 1] else: -1
    when getSeq:
      var i = tail
      var a = newSeq[int]()
      while i != -1:
        a.add(i)
        i = prev[i]
      a.reverse
      return a
    else:
      return lis.len
