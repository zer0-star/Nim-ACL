when not declared ATCODER_LONGEST_INCREASING_SUBSEQUENCE_HPP:
  const ATCODER_LONGEST_INCREASING_SUBSEQUENCE_HPP* = 1
  import atcoder/extra/other/return_type
  import algorithm
  proc longestIncreasingSubsequence*[T](a:openArray[T], strict:static[bool] = true, return_type:static[ReturnType] = Length):auto =
    var lis = newSeq[T]()
    when int(return_type) > 0:
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
        when int(return_type) > 0:
          tail = i
          prev[i] = if lis_i.len > 0: lis_i[^1] else: -1
          lis_i.add(i)
      else:
        lis[it] = p
        when int(return_type) > 0:
          lis_i[it] = i
          prev[i] = if it > 0: lis_i[it - 1] else: -1
    when return_type == Length:
      return lis.len
    else:
      var i = tail
      var inds = newSeq[int]()
      while i != -1:
        inds.add(i)
        i = prev[i]
      inds.reverse
      when return_type == Index:
        return inds
      elif return_type == Value:
        result = newSeq[T]()
        for i in inds:
          result.add a[i]
      elif return_Type == IndexAndValue:
        result = newSeq[tuple[i:int, v:T]]()
        for i in inds:
          result.add (i, a[i])

