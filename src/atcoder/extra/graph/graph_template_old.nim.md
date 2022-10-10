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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_GRAPH_TEMPLATE_HPP:\n  const ATCODER_GRAPH_TEMPLATE_HPP*\
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
    \ weight))\n\n  proc addEdge*[T](g:var Graph[T],e:Edge[T]):void =\n    g[e.src].add(e)\n\
    \  proc addEdge*[T](g:var Graph[T],src,dst:int,weight:T = T(1)):void =\n    g.addEdge(initEdge(src,\
    \ dst, weight, -1))\n\n  proc initUndirectedGraph*[T](n:int, a,b,c:seq[T]):Graph[T]\
    \ =\n    result = initGraph[T](n)\n    for i in 0..<a.len: result.addBiEdge(a[i],\
    \ b[i], c[i])\n  proc initUndirectedGraph*[T](n:int, a,b:seq[T]):Graph[T] =\n\
    \    result = initGraph[T](n)\n    for i in 0..<a.len: result.addBiEdge(a[i],\
    \ b[i])\n  proc initDirectedGraph*[T](n:int, a,b:seq[int],c:seq[T]):Graph[T] =\n\
    \    result = initGraph[T](n)\n    for i in 0..<a.len: result.addEdge(a[i], b[i],\
    \ c[i])\n  proc initDirectedGraph*[T](n:int, a,b:seq[int]):Graph[T] =\n    result\
    \ = initGraph[T](n)\n    for i in 0..<a.len: result.addEdge(a[i], b[i])\n\n  proc\
    \ `<`*[T](l,r:Edge[T]):bool = l.weight < r.weight\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/graph/graph_template_old.nim
  requiredBy: []
  timestamp: '2021-07-15 21:51:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/graph/graph_template_old.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/graph_template_old.nim
- /library/atcoder/extra/graph/graph_template_old.nim.html
title: atcoder/extra/graph/graph_template_old.nim
---
