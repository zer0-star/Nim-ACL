---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':x:'
    path: atcoder/extra/structure/wavelet_matrix.nim
    title: atcoder/extra/structure/wavelet_matrix.nim
  - icon: ':x:'
    path: atcoder/extra/structure/wavelet_matrix.nim
    title: atcoder/extra/structure/wavelet_matrix.nim
  - icon: ':x:'
    path: atcoder/extra/structure/wavelet_matrix.nim
    title: atcoder/extra/structure/wavelet_matrix.nim
  - icon: ':x:'
    path: atcoder/extra/structure/wavelet_matrix.nim
    title: atcoder/extra/structure/wavelet_matrix.nim
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared SUCCINCT_INDEXABLE_DICTIONARY_HPP:\n  const SUCCINCT_INDEXABLE_DICTIONARY_HPP*\
    \ = 1\n  import bitops\n  type SuccinctIndexableDictionary* = object\n    len,\
    \ blocks:int\n    bit, sum:seq[uint32]\n\n  proc initSuccinctIndexableDictionary*(len:int):SuccinctIndexableDictionary\
    \ =\n    let b = (len + 31) shr 5\n    SuccinctIndexableDictionary(len:len, blocks:b,\
    \ bit:newSeq[uint32](b), sum:newSeq[uint32](b))\n\n  proc set*(self:var SuccinctIndexableDictionary,\
    \ k:int) =\n    let i = k shr 5\n    self.bit[i] = self.bit[i] or (1'u32 shl (k\
    \ and 31))\n\n  proc build*(self:var SuccinctIndexableDictionary) =\n    self.sum[0]\
    \ = 0'u32\n    for i in 0..<self.blocks:\n      self.sum[i] = self.sum[i - 1]\
    \ + popcount(self.bit[i - 1]).uint32\n\n  proc `[]`*(self:SuccinctIndexableDictionary,\
    \ k:int):bool =\n    bool((self.bit[k shr 5] shr (k and 31)) and 1)\n\n  proc\
    \ rank*(self:SuccinctIndexableDictionary, k:int):int =\n    return self.sum[k\
    \ shr 5].int + popcount(self.bit[k shr 5] and ((1'u32 shl (k and 31)) - 1))\n\n\
    \  proc rank*(self:SuccinctIndexableDictionary, val:bool, k:int):int =\n    return\
    \ if val: self.rank(k) else: k - self.rank(k)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/succinct_indexable_dictionary.nim
  requiredBy:
  - atcoder/extra/structure/wavelet_matrix.nim
  - atcoder/extra/structure/wavelet_matrix.nim
  - atcoder/extra/structure/wavelet_matrix.nim
  - atcoder/extra/structure/wavelet_matrix.nim
  timestamp: '2021-03-01 01:28:35+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/structure/aoj_2674_wavelet_matrix_test.nim
  - verify/extra/structure/aoj_2674_wavelet_matrix_test.nim
  - verify/extra/structure/yosupo_range_kth_smallest_test.nim
  - verify/extra/structure/yosupo_range_kth_smallest_test.nim
  - verify/extra/structure/aoj_1549_wavelet_matrix_test.nim
  - verify/extra/structure/aoj_1549_wavelet_matrix_test.nim
documentation_of: atcoder/extra/structure/succinct_indexable_dictionary.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/succinct_indexable_dictionary.nim
- /library/atcoder/extra/structure/succinct_indexable_dictionary.nim.html
title: atcoder/extra/structure/succinct_indexable_dictionary.nim
---
