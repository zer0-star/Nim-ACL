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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# \u30B0\u30E9\u30D5\u4F5C\u308B\u3059\u308B\u3068\u304D\u306B\u6700\u521D\
    \u304B\u3089\u6709\u5411\u3001\u7121\u5411\u30B0\u30E9\u30D5\u6307\u5B9A\u3059\
    \u308B\u3088\u3046\u306B\u3057\u305F\u3051\u3069\u3001\u5272\u3068\u4E0D\u4FBF\
    \u306A\u306E\u3067\u63A1\u7528\u3059\u308B\u304B\u8003\u3048\u4E2D\nwhen not declared\
    \ ATCODER_GRAPH_TEMPLATE_HPP:\n  const ATCODER_GRAPH_TEMPLATE_HPP* = 1\n  import\
    \ std/sequtils\n\n  type\n    UNDIRECTED = void\n    DIRECTED = int\n    Edge*[T;\
    \ isDirected] = object\n      src*,dst*:int\n      weight*:T\n      when isDirected\
    \ is UNDIRECTED: # void: directed int: undirected\n        rev*:int\n    Edges*[T;\
    \ directed] = seq[Edge[T, directed]]\n    Graph*[T; directed] = seq[seq[Edge[T,\
    \ directed]]]\n    Matrix*[T] = seq[seq[T]]\n  \n  proc initEdge*[T; isDirected](src,dst:int,weight:T\
    \ = 1,rev:int = -1):Edge[T, isDirected] =\n    var e = Edge[T, isDirected](src:src,\
    \ dst:dst, weight:weight)\n    when isDirected is UNDIRECTED:\n      e.rev = rev\n\
    \    return e\n  \n  proc initUndirectedGraph*[T](n:int):Graph[T, void] = newSeqWith(n,newSeq[Edge[T,\
    \ void]]())\n  proc initDirectedGraph*[T](n:int):Graph[T, int] = newSeqWith(n,newSeq[Edge[T,\
    \ int]]())\n\n  proc addEdge*[T; isDirected](g:var Graph[T, isDirected], e:Edge[T,\
    \ isDirected]):void =\n    g[e.src].add(e)\n    when isDirected is UNDIRECTED:\n\
    \      var e_rev = e\n      swap(e_rev.src, e_rev.dst)\n      let (r, s) = (g[e.src].len,\
    \ g[e.dst].len)\n      g[e.dst].add(e_rev)\n      g[e.src][^1].rev = s\n     \
    \ g[e.dst][^1].rev = r\n  proc addEdge*[T; isDirected](g:var Graph[T, isDirected],src,dst:int,weight:T\
    \ = 1):void =\n    g.addEdge(initEdge[T, isDirected](src, dst, weight))\n  \n\
    \  proc initUndirectedGraph*[T](n:int, a,b,c:seq[T]):Graph[T, void] =\n    result\
    \ = initUndirectedGraph[T, void](n)\n    for i in 0..<a.len: result.addEdge(a[i],\
    \ b[i], c[i])\n  proc initUndirectedGraph*[T](n:int, a,b:seq[T]):Graph[T, void]\
    \ =\n    result = initUndirectedGraph[T, void](n)\n    for i in 0..<a.len: result.addEdge(a[i],\
    \ b[i])\n  proc initDirectedGraph*[T](n:int, a,b:seq[int],c:seq[T]):Graph[T, int]\
    \ =\n    result = initDirectedGraph[T](n)\n    for i in 0..<a.len: result.addEdge(a[i],\
    \ b[i], c[i])\n  proc initDirectedGraph*[T](n:int, a,b:seq[int]):Graph[T, int]\
    \ =\n    result = initDirectedGraph[T](n)\n    for i in 0..<a.len: result.addEdge(a[i],\
    \ b[i])\n\n#  proc addEdge*[T;directed](g:var Graph[T, directed],e:Edge[T, directed]):void\
    \ =\n#    g[e.src].add(e)\n#  proc addEdge*[T;directed](g:var Graph[T, directed],src,dst:int,weight:T\
    \ = T(1)):void =\n#    g.addEdge(initEdge[T, directed](src, dst, weight, -1))\n\
    \  \n  proc `<`*[T; isDirected](l,r:Edge[T, isDirected]):bool = l.weight < r.weight\n\
    \n\nvar g = initDirectedGraph[int](10)\ng.addEdge(0, 2, 3)\ng.addEdge(0, 3, 2)\n\
    var g2 = initUnDirectedGraph[int](10)\ng2.addEdge(0, 2)\ng2.addEdge(2, 3)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/graph/graph_template_directed_undirected.nim
  requiredBy: []
  timestamp: '2021-07-16 23:11:44+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/graph/graph_template_directed_undirected.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/graph_template_directed_undirected.nim
- /library/atcoder/extra/graph/graph_template_directed_undirected.nim.html
title: atcoder/extra/graph/graph_template_directed_undirected.nim
---
