---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/succinct_indexable_dictionary.nim
    title: atcoder/extra/structure/succinct_indexable_dictionary.nim
  - icon: ':x:'
    path: atcoder/extra/structure/succinct_indexable_dictionary.nim
    title: atcoder/extra/structure/succinct_indexable_dictionary.nim
  - icon: ':x:'
    path: atcoder/extra/structure/succinct_indexable_dictionary.nim
    title: atcoder/extra/structure/succinct_indexable_dictionary.nim
  - icon: ':x:'
    path: atcoder/extra/structure/succinct_indexable_dictionary.nim
    title: atcoder/extra/structure/succinct_indexable_dictionary.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/structure/aoj_1549_wavelet_matrix_test.nim
    title: verify/extra/structure/aoj_1549_wavelet_matrix_test.nim
  - icon: ':x:'
    path: verify/extra/structure/aoj_1549_wavelet_matrix_test.nim
    title: verify/extra/structure/aoj_1549_wavelet_matrix_test.nim
  - icon: ':x:'
    path: verify/extra/structure/aoj_2674_wavelet_matrix_test.nim
    title: verify/extra/structure/aoj_2674_wavelet_matrix_test.nim
  - icon: ':x:'
    path: verify/extra/structure/aoj_2674_wavelet_matrix_test.nim
    title: verify/extra/structure/aoj_2674_wavelet_matrix_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_range_kth_smallest_test.nim
    title: verify/extra/structure/yosupo_range_kth_smallest_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_range_kth_smallest_test.nim
    title: verify/extra/structure/yosupo_range_kth_smallest_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_WAVELET_MATRIX_HPP:\n  const ATCODER_WAVELET_MATRIX_HPP*\
    \ = 1\n  import atcoder/extra/structure/succinct_indexable_dictionary\n  import\
    \ atcoder/rangeutils\n\n  type WaveletMatrix*[T;MAXLOG:static[int]] = object\n\
    \    len:int\n    matrix:array[MAXLOG,SuccinctIndexableDictionary]\n    mid:array[MAXLOG,int]\n\
    \  \n  proc initWaveletMatrix*[T](v:seq[T], MAXLOG:static[int]):WaveletMatrix[T,\
    \ MAXLOG] =\n    var v = v\n    result.len = v.len\n    var l, r = newSeq[T](v.len)\n\
    \    for level in countdown(MAXLOG - 1, 0):\n      result.matrix[level] = initSuccinctIndexableDictionary(v.len\
    \ + 1)\n      var left, right = 0\n      for i in 0..<v.len:\n        if ((v[i]\
    \ shr level) and 1).bool:\n          result.matrix[level].set(i)\n          r[right]\
    \ = v[i]\n          right.inc\n        else:\n          l[left] = v[i]\n     \
    \     left.inc\n      result.mid[level] = left\n      result.matrix[level].build()\n\
    \      v.swap(l)\n      for i in 0..<right:\n        v[left + i] = r[i]\n\n  proc\
    \ succ*(self:WaveletMatrix, f:bool or int, p:Slice[int], level:int):(int,int)\
    \ =\n    var f = f.int\n    let (l, r) = p.halfOpenEndpoints\n    return (self.matrix[level].rank(f.bool,\
    \ l) + self.mid[level] * f.int, self.matrix[level].rank(f.bool, r) + self.mid[level]\
    \ * f)\n\n  # v[k]\n  proc access*(self:WaveletMatrix, k:int):self.T =\n    result\
    \ = 0\n    for level in countdown(self.MAXLOG - 1, 0):\n      let f = self.matrix[level][k]\n\
    \      if f: result = result or  (self.T(1) shl level)\n      k = self.matrix[level].rank(f,\
    \ k) + self.mid[level] * f\n\n  proc `[]`*(self:WaveletMatrix, k:int):self.T =\n\
    \    return self.access(k)\n\n  # count i s.t. (0 <= i < r) && v[i] == x\n  proc\
    \ rank*(self:WaveletMatrix, x:self.T, r:int):int =\n    var\n      l = 0\n   \
    \   r = r\n    for level in countdown(self.MAXLOG - 1, 0):\n      (l, r) = self.succ((x\
    \ shr level) and 1, l ..< r, level)\n    return r - l\n\n  # k-th(0-indexed) smallest\
    \ number in v[l,r)\n  proc kth_smallest*(self:WaveletMatrix, p:Slice[int], k:int):self.T\
    \ =\n    var (l, r) = p.halfOpenEndpoints\n    assert 0 <= k and k < r - l\n \
    \   var k = k\n    result = 0\n    for level in countdown(self.MAXLOG - 1, 0):\n\
    \      let cnt = self.matrix[level].rank(false, r) - self.matrix[level].rank(false,\
    \ l)\n      let f = cnt <= k\n      if f:\n        result = result or (self.T(1)\
    \ shl level)\n        k -= cnt\n      (l, r) = self.succ(f, l ..< r, level)\n\n\
    \  # k-th(0-indexed) largest number in v[l,r)\n  proc kth_largest*(self:WaveletMatrix,\
    \ p:Slice[int], k:int):self.T =\n    var (l, r) = p.halfOpenEndpoints\n    return\
    \ self.kth_smallest(l ..< r, r - l - k - 1)\n\n  # count i s.t. (l <= i < r) &&\
    \ (v[i] < upper)\n  proc range_freq*(self:WaveletMatrix, p:Slice[int], upper:self.T):int\
    \ =\n    var (l, r) = p.halfOpenEndpoints\n    result = 0\n    for level in countdown(self.MAXLOG\
    \ - 1, 0):\n      let f = ((upper shr level) and 1).bool\n      if f: result +=\
    \ self.matrix[level].rank(false, r) - self.matrix[level].rank(false, l)\n    \
    \  (l, r) = self.succ(f, l ..< r, level)\n\n  # count i s.t. (l <= i < r) && (lower\
    \ <= v[i] < upper)\n  proc range_freq*(self:WaveletMatrix, p:Slice[int],  lower,\
    \ upper:self.T):int =\n    return self.range_freq(p, upper) - self.range_freq(p,\
    \ lower)\n\n  # max v[i] s.t. (l <= i < r) && (v[i] < upper)\n  proc prev_value*(self:WaveletMatrix,\
    \ p:Slice[int], upper:self.T):self.T =\n    let cnt = self.range_freq(p, upper)\n\
    \    return if cnt == 0: self.T(-1) else: self.kth_smallest(p, cnt - 1)\n\n  #\
    \ min v[i] s.t. (l <= i < r) && (lower <= v[i])\n  proc next_value*(self:WaveletMatrix,\
    \ p:Slice[int],  lower:self.T):self.T =\n    let (l, r) = p.halfOpenEndpoints\n\
    \    let cnt = self.range_freq(l ..< r, lower)\n    return if cnt == r - l: self.T(-1)\
    \ else: self.kth_smallest(l ..< r, cnt)\n\n  type CompressedWaveletMatrix*[T;MAXLOG:static[int]]\
    \ = object\n    mat:WaveletMatrix[int, MAXLOG]\n    ys:seq[T]\n\n  proc get*(self:CompressedWaveletMatrix,\
    \ x:self.T):int =\n    return self.ys.lower_bound(x)\n\n  proc initCompressedWaveletMatrix*[T](v:seq[T],\
    \ MAXLOG:static[int]):CompressedWaveletMatrix[T, MAXLOG] =\n    var ys = v\n \
    \   ys = ys.toHashSet.toSeq.sorted()\n    result.ys = ys\n    var t = newSeq[int](v.len)\n\
    \    for i in 0 ..< v.len: t[i] = result.get(v[i])\n    result.mat = initWaveletMatrix(t,\
    \ MAXLOG)\n\n  proc access*(self:CompressedWaveletMatrix, k:int):self.T = self.ys[self.mat.access(k)]\n\
    \n  proc `[]`*(self:CompressedWaveletMatrix, k:int):self.T = return self.access(k)\n\
    \n  proc rank*(self:CompressedWaveletMatrix, x:self.T, r:int):int =\n    let pos\
    \ = self.get(x)\n    if pos == self.ys.len or self.ys[pos] != x: return 0\n  \
    \  return self.mat.rank(pos, r)\n\n  proc kth_smallest*(self:CompressedWaveletMatrix,\
    \ p:Slice[int], k:int):self.T =\n    return self.ys[self.mat.kth_smallest(p, k)]\n\
    \n  proc kth_largest*(self:CompressedWaveletMatrix, p:Slice[int], k:int):self.T\
    \ =\n    return self.ys[self.mat.kth_largest(p, k)]\n\n  proc range_freq*(self:CompressedWaveletMatrix,\
    \ p:Slice[int], upper:self.T):int =\n    return self.mat.range_freq(p, self.get(upper))\n\
    \n  proc range_freq*(self:CompressedWaveletMatrix, p:Slice[int], lower, upper:self.T):int\
    \ =\n    return self.mat.range_freq(p, self.get(lower), self.get(upper))\n\n \
    \ proc prev_value*(self:CompressedWaveletMatrix, p:Slice[int], upper:self.T):self.T\
    \ =\n    var ret = self.mat.prev_value(p, self.get(upper))\n    return if ret\
    \ == -1: self.T(-1) else: self.ys[ret]\n\n  proc next_value*(self:CompressedWaveletMatrix,\
    \ p:Slice[int], lower:self.T):self.T =\n    var ret = self.mat.next_value(p, self.get(lower))\n\
    \    return if ret == -1: self.T(-1) else: self.ys[ret]\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/succinct_indexable_dictionary.nim
  - atcoder/extra/structure/succinct_indexable_dictionary.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/succinct_indexable_dictionary.nim
  - atcoder/extra/structure/succinct_indexable_dictionary.nim
  isVerificationFile: false
  path: atcoder/extra/structure/wavelet_matrix.nim
  requiredBy: []
  timestamp: '2021-07-15 21:51:07+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/structure/aoj_2674_wavelet_matrix_test.nim
  - verify/extra/structure/aoj_2674_wavelet_matrix_test.nim
  - verify/extra/structure/aoj_1549_wavelet_matrix_test.nim
  - verify/extra/structure/aoj_1549_wavelet_matrix_test.nim
  - verify/extra/structure/yosupo_range_kth_smallest_test.nim
  - verify/extra/structure/yosupo_range_kth_smallest_test.nim
documentation_of: atcoder/extra/structure/wavelet_matrix.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/wavelet_matrix.nim
- /library/atcoder/extra/structure/wavelet_matrix.nim.html
title: atcoder/extra/structure/wavelet_matrix.nim
---
