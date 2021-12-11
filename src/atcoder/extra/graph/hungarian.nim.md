---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_assignment_problem_test.nim
    title: verify/extra/graph/yosupo_assignment_problem_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_assignment_problem_test.nim
    title: verify/extra/graph/yosupo_assignment_problem_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_HUNGARIAN_HPP:\n  const ATCODER_HUNGARIAN_HPP*\
    \ = 1\n  import std/sequtils\n  proc hungarian*[T](A:seq[seq[T]]):(T, seq[int])\
    \ =\n    let\n      N = A.len + 1\n      M = A[0].len + 1\n    var\n      P =\
    \ newSeq[int](M)\n      way = newSeq[int](M)\n      U = newSeqWith(N, 0)\n   \
    \   V = newSeqWith(M, 0)\n      minV:seq[int]\n      used:seq[bool]\n    for i\
    \ in 1..<N:\n      P[0] = i\n      minV = newSeqWith(M, T.inf)\n      used = newSeqWith(M,\
    \ false)\n      var j0 = 0\n      while P[j0] != 0:\n        var (i0, j1) = (P[j0],\
    \ 0)\n        used[j0] = true\n        var delta = T.inf\n        for j in 1..<M:\n\
    \          if used[j]: continue\n          let curr = A[i0-1][j-1] - U[i0] - V[j]\n\
    \          if curr < minV[j]: minV[j] = curr; way[j] = j0\n          if minV[j]\
    \ < delta: delta = minV[j]; j1 = j\n        for j in 0..<M:\n          if used[j]:\
    \ U[P[j]] += delta; V[j] -= delta\n          else: minV[j] -= delta\n        j0\
    \ = j1\n      while true:\n        P[j0] = P[way[j0]];\n        j0 = way[j0];\n\
    \        if j0 == 0: break\n    var Q = newSeq[int](N - 1)\n    for j in 1..<M:\n\
    \      Q[P[j] - 1] = j - 1\n    return (-V[0], Q)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/graph/hungarian.nim
  requiredBy: []
  timestamp: '2020-12-19 22:31:09+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/yosupo_assignment_problem_test.nim
  - verify/extra/graph/yosupo_assignment_problem_test.nim
documentation_of: atcoder/extra/graph/hungarian.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/hungarian.nim
- /library/atcoder/extra/graph/hungarian.nim.html
title: atcoder/extra/graph/hungarian.nim
---
