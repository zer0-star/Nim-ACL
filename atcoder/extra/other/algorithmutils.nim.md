---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_ALGORITHM_UTILS_HPP:\n  const ATCODER_ALGORITHM_UTILS_HPP*\
    \ = 1\n  import std/algorithm\n  iterator permutation*[T](v:seq[T]):seq[T] =\n\
    \    let n = v.len\n    var a = (0..<n).toSeq\n    while true:\n      var result\
    \ = newSeq[int]()\n      for i in 0..<n: result.add v[a[i]]\n      yield result\n\
    \      if not a.nextPermutation(): break\n  \n  iterator combination*[T](v:seq[T],\
    \ r:int):seq[T] =\n    let n = v.len\n    var a = 1.repeat(r) & 0.repeat(n - r)\n\
    \    while true:\n      var result = newSeq[int]()\n      for i in 0..<n:\n  \
    \      if a[i] == 1: result.add(v[i])\n      yield result\n      if not a.prevPermutation():\
    \ break\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/algorithmutils.nim
  requiredBy: []
  timestamp: '2021-11-18 02:51:01+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/algorithmutils.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/algorithmutils.nim
- /library/atcoder/extra/other/algorithmutils.nim.html
title: atcoder/extra/other/algorithmutils.nim
---
