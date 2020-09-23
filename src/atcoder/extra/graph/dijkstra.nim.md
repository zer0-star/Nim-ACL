---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# dijkstra {{{\nwhen not declared ATCODER_EXTRA_DIJKSTRA_HPP:\n  const ATCODER_EXTRA_DIJKSTRA_HPP*\
    \ = 1\n  import std/heapqueue, std/sequtils, std/algorithm\n  import \"atcoder/extra/graph/template.nim\"\
    \n\n  proc dijkstra*[T](g:Graph[T], s:int): (seq[T],seq[int]) = \n    var\n  \
    \    n = g.len\n      dist = newSeqWith(n,T.inf)\n      prev = newSeqWith(n,-1)\n\
    \      Q = initHeapQueue[Edge[T]]()\n    dist[s] = T(0)\n    Q.push(initEdge[T](-2,s,T(0)))\n\
    \    while Q.len > 0:\n      var e = Q.pop()\n      if prev[e.dst] != -1: continue\n\
    \      prev[e.dst] = e.src;\n      for f in g[e.dst]:\n        var w = e.weight\
    \ + f.weight;\n        if dist[f.dst] > w:\n          dist[f.dst] = w;\n     \
    \     Q.push(initEdge[T](f.src, f.dst, w))\n      discard\n    return (dist,prev)\n\
    \  \n  proc path*(t: int, prev: seq[int]): seq[int] = \n    var u = t\n    while\
    \ u >= 0:\n      result.add(u)\n      u = prev[u]\n    result.reverse()\n# }}}\n"
  dependsOn: []
  isVerificationFile: false
  path: src/atcoder/extra/graph/dijkstra.nim
  requiredBy: []
  timestamp: '2020-09-18 00:06:18+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/atcoder/extra/graph/dijkstra.nim
layout: document
redirect_from:
- /library/src/atcoder/extra/graph/dijkstra.nim
- /library/src/atcoder/extra/graph/dijkstra.nim.html
title: src/atcoder/extra/graph/dijkstra.nim
---
