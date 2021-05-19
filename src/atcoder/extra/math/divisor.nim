when not declared ATCODER_DEVISOR_HPP:
  const ATCODER_DEVISOR_HPP* = 1
  import std/algorithm
  proc divisor*(n:int):seq[int] =
    result = newSeq[int]()
    var i = 1
    while i * i <= n:
      if n mod i == 0:
        result.add(i)
        if i * i != n: result.add(n div i)
      i += 1
    result.sort()
  proc divisor*(f:openArray[(int,int)]):seq[int] =
    result = @[1]
    for (p, e) in f:
      let s = result.len
      result.setLen(s * (e + 1))
      var (j, t) = (s, p)
      for i in 1..e:
        for k in 0..<s:
          result[j] = result[k] * t
          j.inc
        t *= p
    result.sort()
  proc divisor*(f:openArray[int]):seq[int] =
    var f = sorted(f)
    var v = newSeq[(int,int)]()
    var i = 0
    while i < f.len:
      var j = i
      while j < f.len and f[i] == f[j]: j.inc
      v.add((f[i], j - i))
      i = j
    return v.divisor
