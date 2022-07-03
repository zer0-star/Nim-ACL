---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: atcoder/extra/structure/internal_heapqueue.nim
    title: atcoder/extra/structure/internal_heapqueue.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/internal_heapqueue.nim
    title: atcoder/extra/structure/internal_heapqueue.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/internal_heapqueue.nim
    title: atcoder/extra/structure/internal_heapqueue.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/internal_heapqueue.nim
    title: atcoder/extra/structure/internal_heapqueue.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# multi_dimensional_dijkustra {{{\nwhen not declared ATCODER_DIJKSTRA_MULTI_DIMENSIONAL:\n\
    \  const ATCODER_DIJKSTRA_MULTI_DIMENSIONAL* = 1\n\n  import atcoder/extra/structure/internal_heapqueue\n\
    \  import std/strformat, std/macros\n\n  macro TupleSeq*(lens: tuple; init):untyped\
    \ =\n    var a = fmt\"{init.repr}\"\n    for i in countdown(lens.len - 1, 0):\
    \ a = fmt\"newSeqWith({lens.repr}[{i.repr}], {a})\"\n    parseStmt(a)\n\n  macro\
    \ `[]`(a: untyped, p: tuple): untyped =\n    var strBody = fmt\"{a.repr}\"\n \
    \   for i, _ in p.getTypeImpl: strBody &= fmt\"[{p.repr}[{i}]]\"\n    parseStmt(strBody)\n\
    \  macro `[]=`(a: untyped, p: tuple, x: untyped): untyped =\n    var strBody =\
    \ fmt\"{a.repr}\"\n    for i, _ in p.getTypeImpl: strBody &= fmt\"[{p.repr}[{i}]]\"\
    \n    strBody &= fmt\" = {x.repr}\"\n    parseStmt(strBody)\n\n  type GraphIterativeC\
    \ = concept g, type G\n    type W = G.Weight\n    type P = G.P\n    var x:P\n\
    \    for p in adj(g, 1, x):\n      discard\n\n  type HasDim = concept g\n    g.dim\n\
    \n  proc dijkstra*[G:GraphIterativeC](g:G, s:g.P or openArray[g.P], limit = G.Weight.inf):auto\
    \ =\n    when g is HasDim:\n      const UseArray = true\n    else:\n      const\
    \ UseArray = false\n    type P = g.P\n    type Weight = g.Weight\n\n    type DP\
    \ = object\n      d:int\n      p:P\n\n    proc heapCmp(a, b:DP):bool = a.d < b.d\n\
    \n    when UseArray:\n      var\n        vis = TupleSeq(g.dim, false)\n      \
    \  dist = TupleSeq(g.dim, limit)\n    else:\n      var\n        vis = initSet[P]()\n\
    \        dist = initTable[P, Weight]()\n\n    var Q = initHeapQueue(heapCmp)\n\
    \n    proc set_push(d:int, p:P) =\n      when UseArray:\n        if vis[p]: return\n\
    \      else:\n        if p in vis: return\n        if p notin dist: dist[p] =\
    \ limit\n      if dist[p] <= d: return\n      dist[p] = d\n      Q.push(DP(d:d,\
    \ p:p))\n\n    when s isnot openArray:\n      let s = [s]\n\n    # initial\n \
    \   for p in s:\n      set_push(0, p)\n\n    # iteration\n    while Q.len > 0:\n\
    \      let dp = Q.pop()\n      let (d, p) = (dp.d, dp.p)\n      when UseArray:\n\
    \        if vis[p]: continue\n        vis[p] = true\n      else:\n        if p\
    \ in vis: continue\n        vis.incl p\n      for dp2 in g.adj(d, p):\n      \
    \  let (d2, p2) = dp2\n        set_push(d2, p2)\n\n    return dist\n# }}}\n\n\n"
  dependsOn:
  - atcoder/extra/structure/internal_heapqueue.nim
  - atcoder/extra/structure/internal_heapqueue.nim
  - atcoder/extra/structure/internal_heapqueue.nim
  - atcoder/extra/structure/internal_heapqueue.nim
  isVerificationFile: false
  path: atcoder/extra/graph/dijkstra_multi_dimensional.nim
  requiredBy: []
  timestamp: '2020-10-01 00:25:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/graph/dijkstra_multi_dimensional.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/dijkstra_multi_dimensional.nim
- /library/atcoder/extra/graph/dijkstra_multi_dimensional.nim.html
title: atcoder/extra/graph/dijkstra_multi_dimensional.nim
---
