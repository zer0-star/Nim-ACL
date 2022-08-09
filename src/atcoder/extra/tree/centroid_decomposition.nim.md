---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/centroid_decomposition_test.nim
    title: verify/extra/graph/centroid_decomposition_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/centroid_decomposition_test.nim
    title: verify/extra/graph/centroid_decomposition_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_CENTROID_DECOMPOSITION_HPP:\n  const ATCODER_CENTROID_DECOMPOSITION_HPP*\
    \ = 1\n  import atcoder/extra/graph/graph_template\n\n  proc CentroidDecomposition*[G:Graph](g:G,\
    \ root = 0):auto =\n    var\n      sub = newSeq[int](g.len)\n      v = newSeq[bool](g.len)\n\
    \      tree = initGraph[int](g.len)\n\n    proc build_dfs(idx, par:int):int =\n\
    \      sub[idx] = 1\n      for e in g[idx]:\n        if e.dst == par or v[e.dst]:\
    \ continue\n        sub[idx] += build_dfs(e.dst, idx)\n      return sub[idx]\n\
    \n    proc search_centroid(idx, par:int, mid:int):int =\n      for e in g[idx]:\n\
    \        if e.dst == par or v[e.dst]: continue\n        if sub[e.dst] > mid: return\
    \ search_centroid(e.dst, idx, mid)\n      return idx\n\n    proc build_dfs(idx:int):int\
    \ =\n      let centroid = search_centroid(idx, -1, build_dfs(idx, -1) div 2)\n\
    \      v[centroid] = true\n      for e in g[centroid]:\n        if not v[e.dst]:\
    \ tree.add_edge(centroid, build_dfs(e.dst))\n      v[centroid] = false\n     \
    \ return centroid\n    let c = build_dfs(root)\n    return (c, tree)\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/tree/centroid_decomposition.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/centroid_decomposition_test.nim
  - verify/extra/graph/centroid_decomposition_test.nim
documentation_of: atcoder/extra/tree/centroid_decomposition.nim
layout: document
redirect_from:
- /library/atcoder/extra/tree/centroid_decomposition.nim
- /library/atcoder/extra/tree/centroid_decomposition.nim.html
title: atcoder/extra/tree/centroid_decomposition.nim
---
