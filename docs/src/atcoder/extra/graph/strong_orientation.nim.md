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
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_STRONG_ORIENTATION_HPP:\n  const ATCODER_STRONG_ORIENTATION_HPP*\
    \ = 1\n  import atcoder/extra/graph/graph_template\n  import std/sequtils\n  proc\
    \ strong_orienation*[G:Graph](g:G, es:Edges[G.T, G.U]):seq[int] =\n    let\n \
    \     N = g.len\n      M = es.len\n    var\n      tin = newSeqWith(N, -1)\n  \
    \    low = newSeqWith(N, -1)\n      bridge_cnt = 0\n      ans = newSeq[int](M)\n\
    \      edge_used = newSeq[bool](M)\n      time = 0\n    proc find_bridges(v:int)\
    \ =\n      low[v] = time\n      tin[v] = time\n      time.inc\n      for e in\
    \ g[v]:\n        let i = e.weight\n        if edge_used[i]: continue\n       \
    \ edge_used[i] = true\n        ans[i] = if v == es[i].src: 1 else: -1\n      \
    \  let nv = e.dst;\n        if tin[nv] == -1: # if nv is not visited yet\n   \
    \       find_bridges(nv)\n          low[v] = min(low[v], low[nv])\n          if\
    \ low[nv] > tin[v]:\n            # a bridge between v and nv\n            bridge_cnt.inc\n\
    \        else:\n          low[v] = min(low[v], low[nv])\n    for v in 0..<N:\n\
    \      if tin[v] == -1:\n        find_bridges(v)\n    return ans\n\n\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/graph/strong_orientation.nim
  requiredBy: []
  timestamp: '2022-10-10 21:34:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/graph/strong_orientation.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/strong_orientation.nim
- /library/atcoder/extra/graph/strong_orientation.nim.html
title: atcoder/extra/graph/strong_orientation.nim
---
