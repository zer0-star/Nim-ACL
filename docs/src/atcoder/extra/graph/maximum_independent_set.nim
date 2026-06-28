when not declared ATCODER_MAXIMUM_INDEPENDENT_SET_HPP:
  const ATCODER_MAXIMUM_INDEPENDENT_SET_HPP* = 1
  import random, sequtils
  
  proc maximum_independent_set*[T](g:seq[seq[T]], trial = 1000000):seq[int] = 
    let N = g.len
    assert(N <= 64);
  
    var bit = newseq[uint64](N)
    for i in 0..<N:
      for j in 0..<N:
        if i != j:
          assert(g[i][j] == g[j][i])
          if g[i][j] != 0:
            bit[i] = bit[i] or (1.uint64 shl j);
  
    var order = toSeq(0..<N)
    var 
      ret = 0
      ver = 0.uint64
    for i in 0..<trial:
      order.shuffle()
      var
        used = 0.uint64
        a = 0
      for j in order:
        if (used and bit[j]) > 0.uint64: continue
        used = used or (1.uint64 shl j)
        a += 1
      if ret < a:
        ret = a
        ver = used
    var ans = newSeq[int]()
    for i in 0..<N:
      if ((ver shr i) and 1.uint64) > 0.uint64: ans.add(i)
    return ans

