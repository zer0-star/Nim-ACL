---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_1_c_warshall_floyd_test.nim
    title: verify/extra/graph/aoj_grl_1_c_warshall_floyd_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_1_c_warshall_floyd_test.nim
    title: verify/extra/graph/aoj_grl_1_c_warshall_floyd_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_WARSHALL_FLOYD_HPP:\n  const ATCODER_WARSHALL_FLOYD_HPP*\
    \ = 1\n  import std/sequtils\n  import atcoder/extra/other/inf\n  type WarshallFloydType*[T]\
    \ = object\n    dist:seq[seq[T]]\n    inter:seq[seq[int]]\n  proc warshallFloyd*[T](dist:\
    \ seq[seq[T]]): WarshallFloydType[T] =\n    let N = dist.len\n    var dist = dist\n\
    \    var inter = newSeqWith(N, newSeqWith(N, -1))\n    for k in 0..<N:\n     \
    \ for i in 0..<N:\n        for j in 0..<N:\n          if dist[i][k] == T.inf or\
    \ dist[k][j] == T.inf: continue\n          let d = dist[i][k] + dist[k][j]\n \
    \         if dist[i][j] > d:\n            dist[i][j] = d\n            inter[i][j]\
    \ = k\n    result.dist = dist\n    result.inter = inter\n\n  proc path*[T](self:\
    \ WarshallFloydType[T], s, t:int):seq[int] =\n    var path = newSeq[int]()\n \
    \   proc buildPath(s, t:int) =\n      let u = self.inter[s][t]\n      if u < 0:\
    \ path.add(s)\n      else: buildPath(s, u);buildPath(u, t)\n    buildPath(s, t)\n\
    \    path.add(t)\n    return path\n\n  proc `[]`*[T](self: WarshallFloydType[T],\
    \ u:int):seq[T] = self.dist[u]\n  proc `[]`*[T](self: WarshallFloydType[T], s,\
    \ t:int):T = self.dist[s][t]\n"
  dependsOn:
  - atcoder/extra/other/inf.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/other/inf.nim
  isVerificationFile: false
  path: atcoder/extra/graph/warshall_floyd.nim
  requiredBy: []
  timestamp: '2021-07-29 00:52:13+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/aoj_grl_1_c_warshall_floyd_test.nim
  - verify/extra/graph/aoj_grl_1_c_warshall_floyd_test.nim
documentation_of: atcoder/extra/graph/warshall_floyd.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/warshall_floyd.nim
- /library/atcoder/extra/graph/warshall_floyd.nim.html
title: atcoder/extra/graph/warshall_floyd.nim
---
