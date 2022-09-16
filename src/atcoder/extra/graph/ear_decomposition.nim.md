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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_EAR_DECOMPOSITION_HPP:\n  const ATCODER_EAR_DECOMPOSITION_HPP*\
    \ = 1\n  import atcoder/extra/graph/graph_template\n  import sequtils\n  proc\
    \ ear_decomposition*(g:Graph):seq[seq[seq[tuple[u, i:int]]]] =\n    var\n    \
    \  parent_edge_index = newSeqWith(g.len, -1)\n      dfs_visited, ear_visited =\
    \ newSeq[bool](g.len)\n      edge_visited = newSeq[seq[bool]](g.len)\n    for\
    \ u in g.len:\n      edge_visited[u] = newSeq[bool](g[u].len)\n    proc parent(u:int):int\
    \ =\n      if parent_edge_index[u] == -1: return -1\n      else: return g[u][parent_edge_index[u]].dst\n\
    \    for root in 0 ..< g.len:\n      if dfs_visited[root]:\n        continue\n\
    \      # Perform a DFS\n      var queue: seq[int]\n      proc dfs(u:int) =\n \
    \       dfs_visited[u] = true\n        queue.add(u)\n        for i, e in g[u]:\n\
    \          let v = e.dst\n          if dfs_visited[v]: continue\n          parent_edge_index[v]\
    \ = e.rev\n          dfs(v)\n      dfs(root)\n      var ears:seq[seq[tuple[u,\
    \ i:int]]]\n      for u in queue:\n        for i,e in g[u]:\n          let v =\
    \ e.dst\n          if edge_visited[u][i]: continue\n          if parent_edge_index[u]\
    \ == i or parent_edge_index[v] == e.rev:\n            continue\n          # Found\
    \ a backedge. Now traverse the ear.\n          var ear = @[(u, i)]\n         \
    \ ear_visited[u] = true\n          #edge_visited[u][i] = true # \u3044\u3089\u306A\
    \u3044?\n          edge_visited[v][e.rev] = true\n          var x = v\n      \
    \    while true:\n            if ear_visited[x]:\n              break\n      \
    \      ear.add((x, parent_edge_index[x]))\n            ear_visited[x] = true\n\
    \            x = parent(x)\n          ears.add(ear)\n      result.add(ears)\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/graph/ear_decomposition.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/graph/ear_decomposition.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/ear_decomposition.nim
- /library/atcoder/extra/graph/ear_decomposition.nim.html
title: atcoder/extra/graph/ear_decomposition.nim
---
