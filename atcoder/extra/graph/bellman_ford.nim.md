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
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_1_b_bellman_ford_test.nim
    title: verify/extra/graph/aoj_grl_1_b_bellman_ford_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_1_b_bellman_ford_test.nim
    title: verify/extra/graph/aoj_grl_1_b_bellman_ford_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_BELLMAN_FORD_HPP:\n  const ATCODER_BELLMAN_FORD_HPP*\
    \ = 1\n  import std/sequtils, std/algorithm\n  import atcoder/extra/other/inf\n\
    \  import atcoder/extra/graph/graph_template\n\n  type BellmanFordResult*[T, U]\
    \ = object\n    negative_cycle*:bool\n    dist*: seq[T]\n    prev*: seq[U]\n \
    \   when U isnot int:\n      id*: proc(u:U):int\n  proc `[]`*[T, U](d:BellmanFordResult[T,\
    \ U], u:U):T =\n    let u = when U isnot int: d.id(u) else: u\n    d.dist[u]\n\
    \  proc path*[T, U](d:BellmanFordResult[T, U], t:U): seq[U] = \n    var u = t\n\
    \    while u >= 0:\n      result.add(u)\n      if u == d.prev[u]: break\n    \
    \  u = d.prev[u]\n    result.reverse()\n\n  proc bellman_ford*[G:Graph](g:G, s:G.U\
    \ or seq[G.U]): auto =\n    let n = g.len\n    var\n      dist = newSeqWith(n,\
    \ G.T.inf)\n      prev = newSeq[G.U](n)\n      negative_cycle = false\n    when\
    \ s is G.U:\n      dist[g.id(s)] = G.T(0)\n      prev[g.id(s)] = s\n    else:\n\
    \      for s in s:\n        dist[g.id(s)] = G.T(0)\n        prev[g.id(s)] = s\n\
    \    for k in 0..<n:\n      for u in 0..<n:\n        if dist[u] == G.T.inf: continue\n\
    \        for e in g.adj_by_id(u):\n          let idst = g.id(e.dst)\n        \
    \  let t = dist[u] + e.weight\n          if dist[idst] > t:\n            dist[idst]\
    \ = t\n            prev[idst] = e.src\n            if k == n-1:\n            \
    \  dist[idst] = -G.T.inf\n              negative_cycle = true\n    if negative_cycle:\n\
    \      for k in 0..<n:\n        for u in 0..<n:\n          if dist[u] != -G.T.inf:\
    \ continue\n          for e in g.adj[u]:\n            dist[g.id(e.dst)] = -G.T.inf\n\
    \    result = BellmanFordResult[G.T, G.U](negative_cycle:negative_cycle, dist:dist,\
    \ prev:prev)\n    when G.U isnot int: result.id = g.id\n"
  dependsOn:
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/graph/bellman_ford.nim
  requiredBy: []
  timestamp: '2021-11-18 02:47:29+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/aoj_grl_1_b_bellman_ford_test.nim
  - verify/extra/graph/aoj_grl_1_b_bellman_ford_test.nim
documentation_of: atcoder/extra/graph/bellman_ford.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/bellman_ford.nim
- /library/atcoder/extra/graph/bellman_ford.nim.html
title: atcoder/extra/graph/bellman_ford.nim
---
