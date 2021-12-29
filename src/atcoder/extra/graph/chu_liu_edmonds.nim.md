---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/skew_heap.nim
    title: atcoder/extra/structure/skew_heap.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/skew_heap.nim
    title: atcoder/extra/structure/skew_heap.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/skew_heap.nim
    title: atcoder/extra/structure/skew_heap.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/skew_heap.nim
    title: atcoder/extra/structure/skew_heap.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
    title: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
    title: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_directedmst_test.nim
    title: verify/extra/graph/yosupo_directedmst_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_directedmst_test.nim
    title: verify/extra/graph/yosupo_directedmst_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_CHU_LIU_EDMONDS_HPP:\n  const ATCODER_CHU_LIU_EDMONDS_HPP*\
    \ = 1\n  import sequtils, options, algorithm\n  import atcoder/extra/graph/graph_template\n\
    \  import atcoder/dsu\n  import atcoder/extra/structure/skew_heap\n  \n  proc\
    \ minimumSpanningTreeArborescence*[T](es:Edges[T, int], V:int, start:int):Option[(T,\
    \ seq[int])] =\n    proc g(a:(T,int), b:T):auto = (a[0] + b, a[1])\n    proc h(a:T,\
    \ b:T):auto = a + b\n    var heap = initSkewHeap[(T,int), int](g, h)\n    var\
    \ heaps = newSeqWith(V, heap.makeheap())\n    for i,e in es: heap.push(heaps[e.dst],\
    \ (e.weight, i))\n    var\n      uf = initDSU(V)\n      used = newSeqWith(V, -1)\n\
    \    used[start] = start\n  \n    var\n      ret = T(0)\n      ei = newSeq[int]()\n\
    \      leaf = newSeqWith(V, -1)\n      cyc = 0\n      ch = newSeq[int]()\n   \
    \   paredge = newSeq[int](es.len)\n    for s in 0..<V:\n      var path = newSeq[int]()\n\
    \      var u = s\n      while used[u] < 0:\n        path.add(u)\n        used[u]\
    \ = s\n        if heap.empty(heaps[u]): return result.T.none\n        let (d,\
    \ eid) = heap.top(heaps[u])\n        ret += d\n        heap.add(heaps[u], -d)\n\
    \        heap.pop(heaps[u])\n        ei.add(eid)\n        if leaf[es[eid].dst]\
    \ == -1: leaf[es[eid].dst] = eid\n        while cyc > 0:\n          paredge[ch[^1]]\
    \ = eid\n          discard ch.pop()\n          cyc.dec\n        ch.add(eid)\n\
    \  \n        let v = uf.leader(es[eid].src)\n        if used[v] == s:\n      \
    \    var w:int\n          var nextheap = heap.makeheap()\n          while true:\n\
    \            w = path.pop()\n            nextheap = heap.merge(nextheap, heaps[w]);\n\
    \            cyc.inc\n            if uf.same(v, w): break\n            else: uf.merge(v,\
    \ w)\n          heaps[uf.leader(v)] = nextheap\n          used[uf.leader(v)] =\
    \ -1\n        u = uf.leader(v);\n    ei.reverse()\n    var\n      parent = newSeqWith(V,\
    \ start)\n      usede = newSeqWith(es.len, false)\n    for i in ei:\n      if\
    \ usede[i]: continue\n      parent[es[i].dst]=es[i].src\n      var x = leaf[es[i].dst]\n\
    \      while x != i:\n        usede[x] = true\n        x = paredge[x]\n    return\
    \ (ret, parent).some\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/structure/skew_heap.nim
  - atcoder/extra/structure/skew_heap.nim
  - atcoder/dsu.nim
  - atcoder/dsu.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/structure/skew_heap.nim
  - atcoder/extra/structure/skew_heap.nim
  - atcoder/dsu.nim
  - atcoder/dsu.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/graph/chu_liu_edmonds.nim
  requiredBy: []
  timestamp: '2021-11-18 02:47:29+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
  - verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
  - verify/extra/graph/yosupo_directedmst_test.nim
  - verify/extra/graph/yosupo_directedmst_test.nim
documentation_of: atcoder/extra/graph/chu_liu_edmonds.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/chu_liu_edmonds.nim
- /library/atcoder/extra/graph/chu_liu_edmonds.nim.html
title: atcoder/extra/graph/chu_liu_edmonds.nim
---
