---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/tree/aoj_grl_5_a_tree_diameter_test.nim
    title: verify/extra/tree/aoj_grl_5_a_tree_diameter_test.nim
  - icon: ':x:'
    path: verify/extra/tree/aoj_grl_5_a_tree_diameter_test.nim
    title: verify/extra/tree/aoj_grl_5_a_tree_diameter_test.nim
  - icon: ':x:'
    path: verify/extra/tree/yosupo_tree_diameter_test.nim
    title: verify/extra/tree/yosupo_tree_diameter_test.nim
  - icon: ':x:'
    path: verify/extra/tree/yosupo_tree_diameter_test.nim
    title: verify/extra/tree/yosupo_tree_diameter_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_TREE_DIAMETER_HPP:\n  const ATCODER_TREE_DIAMETER_HPP*\
    \ = 1\n  import atcoder/extra/graph/graph_template\n  import std/sequtils\n  proc\
    \ treeDiameter*[G:Graph](g:G):(G.T, seq[int]) =\n    var next = newSeq[int](g.len)\n\
    \    proc dfs(idx, par:int):(G.T, int) =\n      result[1] = idx\n      for i,e\
    \ in g[idx]:\n        if e.dst == par: continue\n        var cost = dfs(e.dst,\
    \ idx)\n        cost[0] += e.weight\n        if result[0] < cost[0]:\n       \
    \   next[idx] = i\n          result = cost\n    let p = dfs(0, -1)\n    next =\
    \ newSeqWith(g.len, -1)\n    let q = dfs(p[1], -1)\n    var\n      ans = newSeq[int]()\n\
    \      u = p[1]\n    while true:\n      ans.add(u)\n      let idx = next[u]\n\
    \      if idx == -1:break\n      u = g[u][idx].dst\n    return (q[0], ans)\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/tree/tree_diameter.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/tree/aoj_grl_5_a_tree_diameter_test.nim
  - verify/extra/tree/aoj_grl_5_a_tree_diameter_test.nim
  - verify/extra/tree/yosupo_tree_diameter_test.nim
  - verify/extra/tree/yosupo_tree_diameter_test.nim
documentation_of: atcoder/extra/tree/tree_diameter.nim
layout: document
redirect_from:
- /library/atcoder/extra/tree/tree_diameter.nim
- /library/atcoder/extra/tree/tree_diameter.nim.html
title: atcoder/extra/tree/tree_diameter.nim
---
