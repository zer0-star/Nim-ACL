when not declared ATCODER_WAVELET_MATRIX_HPP:
  const ATCODER_WAVELET_MATRIX_HPP* = 1
  import atcoder/extra/structure/succinct_indexable_dictionary
  import atcoder/rangeutils

  type WaveletMatrix*[T;MAXLOG:static[int]] = object
    len:int
    matrix:array[MAXLOG,SuccinctIndexableDictionary]
    mid:array[MAXLOG,int]
  
  proc initWaveletMatrix*[T](v:seq[T], MAXLOG:static[int]):WaveletMatrix[T, MAXLOG] =
    var v = v
    result.len = v.len
    var l, r = newSeq[T](v.len)
    for level in countdown(MAXLOG - 1, 0):
      result.matrix[level] = initSuccinctIndexableDictionary(v.len + 1)
      var left, right = 0
      for i in 0..<v.len:
        if ((v[i] shr level) and 1).bool:
          result.matrix[level].set(i)
          r[right] = v[i]
          right.inc
        else:
          l[left] = v[i]
          left.inc
      result.mid[level] = left
      result.matrix[level].build()
      v.swap(l)
      for i in 0..<right:
        v[left + i] = r[i]

  proc succ*(self:WaveletMatrix, f:bool or int, p:Slice[int], level:int):(int,int) =
    var f = f.int
    let (l, r) = p.halfOpenEndpoints
    return (self.matrix[level].rank(f.bool, l) + self.mid[level] * f.int, self.matrix[level].rank(f.bool, r) + self.mid[level] * f)

  # v[k]
  proc access*(self:WaveletMatrix, k:int):self.T =
    result = 0
    for level in countdown(self.MAXLOG - 1, 0):
      let f = self.matrix[level][k]
      if f: result = result or  (self.T(1) shl level)
      k = self.matrix[level].rank(f, k) + self.mid[level] * f

  proc `[]`*(self:WaveletMatrix, k:int):self.T =
    return self.access(k)

  # count i s.t. (0 <= i < r) && v[i] == x
  proc rank*(self:WaveletMatrix, x:self.T, r:int):int =
    var
      l = 0
      r = r
    for level in countdown(self.MAXLOG - 1, 0):
      (l, r) = self.succ((x shr level) and 1, l ..< r, level)
    return r - l

  # k-th(0-indexed) smallest number in v[l,r)
  proc kth_smallest*(self:WaveletMatrix, p:Slice[int], k:int):self.T =
    var (l, r) = p.halfOpenEndpoints
    assert 0 <= k and k < r - l
    var k = k
    result = 0
    for level in countdown(self.MAXLOG - 1, 0):
      let cnt = self.matrix[level].rank(false, r) - self.matrix[level].rank(false, l)
      let f = cnt <= k
      if f:
        result = result or (self.T(1) shl level)
        k -= cnt
      (l, r) = self.succ(f, l ..< r, level)

  # k-th(0-indexed) largest number in v[l,r)
  proc kth_largest*(self:WaveletMatrix, p:Slice[int], k:int):self.T =
    var (l, r) = p.halfOpenEndpoints
    return self.kth_smallest(l ..< r, r - l - k - 1)

  # count i s.t. (l <= i < r) && (v[i] < upper)
  proc range_freq*(self:WaveletMatrix, p:Slice[int], upper:self.T):int =
    var (l, r) = p.halfOpenEndpoints
    result = 0
    for level in countdown(self.MAXLOG - 1, 0):
      let f = ((upper shr level) and 1).bool
      if f: result += self.matrix[level].rank(false, r) - self.matrix[level].rank(false, l)
      (l, r) = self.succ(f, l ..< r, level)

  # count i s.t. (l <= i < r) && (lower <= v[i] < upper)
  proc range_freq*(self:WaveletMatrix, p:Slice[int],  lower, upper:self.T):int =
    return self.range_freq(p, upper) - self.range_freq(p, lower)

  # max v[i] s.t. (l <= i < r) && (v[i] < upper)
  proc prev_value*(self:WaveletMatrix, p:Slice[int], upper:self.T):self.T =
    let cnt = self.range_freq(p, upper)
    return if cnt == 0: self.T(-1) else: self.kth_smallest(p, cnt - 1)

  # min v[i] s.t. (l <= i < r) && (lower <= v[i])
  proc next_value*(self:WaveletMatrix, p:Slice[int],  lower:self.T):self.T =
    let (l, r) = p.halfOpenEndpoints
    let cnt = self.range_freq(l ..< r, lower)
    return if cnt == r - l: self.T(-1) else: self.kth_smallest(l ..< r, cnt)

  type CompressedWaveletMatrix*[T;MAXLOG:static[int]] = object
    mat:WaveletMatrix[int, MAXLOG]
    ys:seq[T]

  proc get*(self:CompressedWaveletMatrix, x:self.T):int =
    return self.ys.lower_bound(x)

  proc initCompressedWaveletMatrix*[T](v:seq[T], MAXLOG:static[int]):CompressedWaveletMatrix[T, MAXLOG] =
    var ys = v
    ys = ys.toHashSet.toSeq.sorted()
    result.ys = ys
    var t = newSeq[int](v.len)
    for i in 0 ..< v.len: t[i] = result.get(v[i])
    result.mat = initWaveletMatrix(t, MAXLOG)

  proc access*(self:CompressedWaveletMatrix, k:int):self.T = self.ys[self.mat.access(k)]

  proc `[]`*(self:CompressedWaveletMatrix, k:int):self.T = return self.access(k)

  proc rank*(self:CompressedWaveletMatrix, x:self.T, r:int):int =
    let pos = self.get(x)
    if pos == self.ys.len or self.ys[pos] != x: return 0
    return self.mat.rank(pos, r)

  proc kth_smallest*(self:CompressedWaveletMatrix, p:Slice[int], k:int):self.T =
    return self.ys[self.mat.kth_smallest(p, k)]

  proc kth_largest*(self:CompressedWaveletMatrix, p:Slice[int], k:int):self.T =
    return self.ys[self.mat.kth_largest(p, k)]

  proc range_freq*(self:CompressedWaveletMatrix, p:Slice[int], upper:self.T):int =
    return self.mat.range_freq(p, self.get(upper))

  proc range_freq*(self:CompressedWaveletMatrix, p:Slice[int], lower, upper:self.T):int =
    return self.mat.range_freq(p, self.get(lower), self.get(upper))

  proc prev_value*(self:CompressedWaveletMatrix, p:Slice[int], upper:self.T):self.T =
    var ret = self.mat.prev_value(p, self.get(upper))
    return if ret == -1: self.T(-1) else: self.ys[ret]

  proc next_value*(self:CompressedWaveletMatrix, p:Slice[int], lower:self.T):self.T =
    var ret = self.mat.next_value(p, self.get(lower))
    return if ret == -1: self.T(-1) else: self.ys[ret]
