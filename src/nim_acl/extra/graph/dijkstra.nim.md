---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/extra/graph/template.nim
    title: src/nim_acl/extra/graph/template.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/extra/graph/template.nim
    title: src/nim_acl/extra/graph/template.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/shortest_path_test.nim
    title: verify/shortest_path_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/shortest_path_test.nim
    title: verify/shortest_path_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# dijkstra {{{\nwhen not declared ATCODER_EXTRA_DIJKSTRA_HPP:\n  const ATCODER_EXTRA_DIJKSTRA_HPP*\
    \ = 1\n  import std/heapqueue, std/sequtils, std/algorithm\n  import \"src/nim_acl/extra/graph/template.nim\"\
    \n\n  proc dijkstra*[T](g:Graph[T], s:int): (seq[T],seq[int]) = \n    var\n  \
    \    n = g.len\n      dist = newSeqWith(n,T.inf)\n      prev = newSeqWith(n,-1)\n\
    \      Q = initHeapQueue[Edge[T]]()\n    dist[s] = T(0)\n    Q.push(initEdge[T](-2,s,T(0)))\n\
    \    while Q.len > 0:\n      var e = Q.pop()\n      if prev[e.dst] != -1: continue\n\
    \      prev[e.dst] = e.src;\n      for f in g[e.dst]:\n        var w = e.weight\
    \ + f.weight;\n        if dist[f.dst] > w:\n          dist[f.dst] = w;\n     \
    \     Q.push(initEdge[T](f.src, f.dst, w))\n      discard\n    return (dist,prev)\n\
    \  \n  proc path*(t: int, prev: seq[int]): seq[int] = \n    var u = t\n    while\
    \ u >= 0:\n      result.add(u)\n      u = prev[u]\n    result.reverse()\n# }}}\n"
  dependsOn:
  - src/nim_acl/extra/graph/template.nim
  - src/nim_acl/extra/graph/template.nim
  isVerificationFile: false
  path: src/nim_acl/extra/graph/dijkstra.nim
  requiredBy: []
  timestamp: '2020-09-16 23:07:19+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/shortest_path_test.nim
  - verify/shortest_path_test.nim
documentation_of: src/nim_acl/extra/graph/dijkstra.nim
layout: document
redirect_from:
- /library/src/nim_acl/extra/graph/dijkstra.nim
- /library/src/nim_acl/extra/graph/dijkstra.nim.html
title: src/nim_acl/extra/graph/dijkstra.nim
---
