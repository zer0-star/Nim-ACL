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
    path: verify/extra/graph/yosupo_cycle_detection_test.nim
    title: verify/extra/graph/yosupo_cycle_detection_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_cycle_detection_test.nim
    title: verify/extra/graph/yosupo_cycle_detection_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_CYCLE_DETECTION_HPP:\n  const ATCODER_CYCLE_DETECTION_HPP*\
    \ = 1\n  import atcoder/extra/graph/graph_template\n  import std/options, std/sequtils\n\
    \n  proc cycleDetection*[G:Graph](g:G):Option[seq[Edge[G.T, G.U]]] =\n    type\
    \ E = Edge[G.T, G.U]\n    var\n      used = newSeq[int](g.len)\n      pre = newSeq[Edge[G.T,\
    \ G.U]](g.len)\n      circle = newSeq[E]()\n    proc dfs(idx:int):bool =\n   \
    \   used[idx] = 1\n      for e in g[idx]:\n        if used[e.dst] == 0:\n    \
    \      pre[e.dst] = e\n          if dfs(e.dst): return true\n        elif used[e.dst]\
    \ == 1:\n          var cur = idx\n          while cur != e.dst:\n            circle.add(pre[cur])\n\
    \            cur = pre[cur].src\n          circle.add(e)\n          return true\n\
    \      used[idx] = 2\n      return false\n\n    for i in 0..<g.len:\n      if\
    \ used[i] == 0 and dfs(i):\n        circle.reverse\n        return circle.some\n\
    \    return seq[E].none\n\n  proc cycleDetectionUndirected*[G:Graph](g:G):Option[seq[Edge[G.T,\
    \ G.U]]] =\n    type E = Edge[G.T, G.U]\n    var\n      vis = newSeqWith(g.len,\
    \ false)\n      ancestor = newSeqWith(g.len, -1)\n      circle = newSeq[E]()\n\
    \    proc dfs(u, p = -1, h = 0):bool =\n      vis[u] = true\n      ancestor[u]\
    \ = h\n      for i,e in g[u]:\n        if i == p: continue\n        if ancestor[e.dst]\
    \ >= 0:\n          circle = circle[ancestor[e.dst]..<circle.len] & e\n       \
    \   return true\n        circle.add(e)\n        if dfs(e.dst, e.rev, h + 1): return\
    \ true\n        discard circle.pop()\n      ancestor[u] = -1\n      return false\n\
    \    for u in 0..<g.len:\n      if vis[u]: continue\n      if dfs(u): return circle.some\n\
    \    return seq[E].none\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/graph/cycle_detection.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/yosupo_cycle_detection_test.nim
  - verify/extra/graph/yosupo_cycle_detection_test.nim
documentation_of: atcoder/extra/graph/cycle_detection.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/cycle_detection.nim
- /library/atcoder/extra/graph/cycle_detection.nim.html
title: atcoder/extra/graph/cycle_detection.nim
---
