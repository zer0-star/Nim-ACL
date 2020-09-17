---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/extra/graph/dijkstra.nim
    title: src/nim_acl/extra/graph/dijkstra.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/extra/graph/dijkstra.nim
    title: src/nim_acl/extra/graph/dijkstra.nim
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
  code: "# Graph {{{\nwhen not declared ATCODER_GRAPH_TEMPLATE_HPP:\n  const ATCODER_GRAPH_TEMPLATE_HPP*\
    \ = 1\n  import std/sequtils\n  \n  type\n    Edge*[T] = object\n      src*,dst*:int\n\
    \      weight*:T\n      rev*:int\n    Edges*[T] = seq[Edge[T]]\n    Graph*[T]\
    \ = seq[seq[Edge[T]]]\n    Matrix*[T] = seq[seq[T]]\n  \n  proc initEdge*[T](src,dst:int,weight:T\
    \ = 1,rev:int = -1):Edge[T] =\n    var e:Edge[T]\n    e.src = src\n    e.dst =\
    \ dst\n    e.weight = weight\n    e.rev = rev\n    return e\n  \n  proc initGraph*[T](n:int):Graph[T]\
    \ =\n    return newSeqWith(n,newSeq[Edge[T]]())\n  \n  proc addBiEdge*[T](g:var\
    \ Graph[T],e:Edge[T]):void =\n    var e_rev = e\n    swap(e_rev.src, e_rev.dst)\n\
    \    let (r, s) = (g[e.src].len, g[e.dst].len)\n    g[e.src].add(e)\n    g[e.dst].add(e_rev)\n\
    \    g[e.src][^1].rev = s\n    g[e.dst][^1].rev = r\n  proc addBiEdge*[T](g:var\
    \ Graph[T],src,dst:int,weight:T = 1):void =\n    g.addBiEdge(initEdge(src, dst,\
    \ weight))\n  \n  proc initUndirectedGraph*[T](n:int, a,b,c:seq[T]):Graph[T] =\n\
    \    result = initGraph[T](n)\n    for i in 0..<a.len: result.addBiEdge(a[i],\
    \ b[i], c[i])\n  proc initUndirectedGraph*[T](n:int, a,b:seq[T]):Graph[T] =\n\
    \    result = initGraph[T](n)\n    for i in 0..<a.len: result.addBiEdge(a[i],\
    \ b[i])\n  proc initGraph*[T](n:int, a,b:seq[int],c:seq[T]):Graph[T] =\n    result\
    \ = initGraph[T](n)\n    for i in 0..<a.len: result.addEdge(a[i], b[i], c[i])\n\
    \  proc initGraph*[T](n:int, a,b:seq[int]):Graph[T] =\n    result = initGraph[T](n)\n\
    \    for i in 0..<a.len: result.addEdge(a[i], b[i])\n  \n  \n  proc addEdge*[T](g:var\
    \ Graph[T],e:Edge[T]):void =\n    g[e.src].add(e)\n  proc addEdge*[T](g:var Graph[T],src,dst:int,weight:T\
    \ = 1):void =\n    g.addEdge(initEdge(src, dst, weight, -1))\n  \n  proc `<`*[T](l,r:Edge[T]):bool\
    \ = l.weight < r.weight\n#}}}\n"
  dependsOn: []
  isVerificationFile: false
  path: src/nim_acl/extra/graph/template.nim
  requiredBy:
  - src/nim_acl/extra/graph/dijkstra.nim
  - src/nim_acl/extra/graph/dijkstra.nim
  timestamp: '2020-09-16 23:07:19+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/shortest_path_test.nim
  - verify/shortest_path_test.nim
documentation_of: src/nim_acl/extra/graph/template.nim
layout: document
redirect_from:
- /library/src/nim_acl/extra/graph/template.nim
- /library/src/nim_acl/extra/graph/template.nim.html
title: src/nim_acl/extra/graph/template.nim
---
