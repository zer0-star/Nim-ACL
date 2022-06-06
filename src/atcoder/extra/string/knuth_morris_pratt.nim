when not declared ATCODER_KNUTH_MORRIS_PRATT_HPP:
  const ATCODER_KNUTH_MORRIS_PRATT_HPP* = 1
  proc KnuthMorrisPratt*(t,p:string):seq[int] =
    proc buildFail(p:string):seq[int] =
      let m = p.len
      var fail = newSeq[int](m+1)
      var j = -1
      fail[0] = -1;
      for i in 1..m:
        while j >= 0 and p[j] != p[i - 1]: j = fail[j]
        j += 1
        fail[i] = j
      return fail
    let
      fail = buildFail(p)
      n = t.len
      m = p.len
    result = newSeq[int]()
    var k = 0
    for i in 0..<n:
      while k >= 0 and p[k] != t[i]: k = fail[k]
      k += 1
      if k >= m:
        result.add(i - m + 1) # match at t[i-m+1 .. i]
        k = fail[k]
