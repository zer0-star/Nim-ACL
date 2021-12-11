---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/boruvka.nim
    title: atcoder/extra/graph/boruvka.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/boruvka.nim
    title: atcoder/extra/graph/boruvka.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/boruvka.nim
    title: atcoder/extra/graph/boruvka.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/boruvka.nim
    title: atcoder/extra/graph/boruvka.nim
  - icon: ':question:'
    path: atcoder/extra/graph/chu_liu_edmonds.nim
    title: atcoder/extra/graph/chu_liu_edmonds.nim
  - icon: ':question:'
    path: atcoder/extra/graph/chu_liu_edmonds.nim
    title: atcoder/extra/graph/chu_liu_edmonds.nim
  - icon: ':question:'
    path: atcoder/extra/graph/chu_liu_edmonds.nim
    title: atcoder/extra/graph/chu_liu_edmonds.nim
  - icon: ':question:'
    path: atcoder/extra/graph/chu_liu_edmonds.nim
    title: atcoder/extra/graph/chu_liu_edmonds.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/eulerian_trail.nim
    title: atcoder/extra/graph/eulerian_trail.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/eulerian_trail.nim
    title: atcoder/extra/graph/eulerian_trail.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/eulerian_trail.nim
    title: atcoder/extra/graph/eulerian_trail.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/eulerian_trail.nim
    title: atcoder/extra/graph/eulerian_trail.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/kruskal.nim
    title: atcoder/extra/graph/kruskal.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/kruskal.nim
    title: atcoder/extra/graph/kruskal.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/kruskal.nim
    title: atcoder/extra/graph/kruskal.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/kruskal.nim
    title: atcoder/extra/graph/kruskal.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/dsu_test.nim
    title: verify/dsu_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/dsu_test.nim
    title: verify/dsu_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
    title: verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
    title: verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
    title: verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
    title: verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
    title: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
    title: verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
  - icon: ':x:'
    path: verify/extra/graph/yosupo_directedmst_test.nim
    title: verify/extra/graph/yosupo_directedmst_test.nim
  - icon: ':x:'
    path: verify/extra/graph/yosupo_directedmst_test.nim
    title: verify/extra/graph/yosupo_directedmst_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':question:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_DSU_HPP:\n  const ATCODER_DSU_HPP* = 1\n\n  import\
    \ std/sequtils\n\n  type\n    DSU* = ref object\n      n: int\n      par_or_siz:\
    \ seq[int]\n\n  proc initDSU*(n: int): DSU {.inline.} =\n    return DSU(n: n,\
    \ par_or_siz: newSeqWith(n, -1))\n\n  proc leader*(self: DSU; a: int): int {.inline.}\
    \ =\n    ## Path compression\n    if self.par_or_siz[a] < 0: return a\n    self.par_or_siz[a]\
    \ = self.leader(self.par_or_siz[a])\n    return self.par_or_siz[a]\n\n  proc same*(self:\
    \ DSU; a, b: int): bool {.inline.} =\n    self.leader(a) == self.leader(b)\n\n\
    \  proc size*(self: DSU; a: int): int {.inline.} =\n    - self.par_or_siz[self.leader(a)]\n\
    \n  proc merge*(self: DSU; a, b: int): int {.inline, discardable.} =\n\n    var\n\
    \      x = self.leader(a)\n      y = self.leader(b)\n\n    if x == y: return x\n\
    \    if self.par_or_siz[x] > self.par_or_siz[y]: swap(x, y)\n    self.par_or_siz[x]\
    \ += self.par_or_siz[y]\n    self.par_or_siz[y] = x\n    return x\n\n  proc groups*(self:\
    \ DSU): seq[seq[int]] {.inline.} =\n    var\n      leaderBuf = newSeq[int](self.n)\n\
    \      groupsize = newSeq[int](self.n)\n    for i in 0 ..< self.n:\n      leaderBuf[i]\
    \ = self.leader(i)\n      groupsize[leaderBuf[i]].inc\n    result = (0 ..< self.n).mapIt(newSeqOfCap[int](groupsize[it]))\n\
    \    for i, ldr in leaderBuf:\n      result[ldr].add i\n    result.keepItIf(it.len\
    \ > 0)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/dsu.nim
  requiredBy:
  - atcoder/extra/graph/chu_liu_edmonds.nim
  - atcoder/extra/graph/chu_liu_edmonds.nim
  - atcoder/extra/graph/boruvka.nim
  - atcoder/extra/graph/boruvka.nim
  - atcoder/extra/graph/kruskal.nim
  - atcoder/extra/graph/kruskal.nim
  - atcoder/extra/graph/eulerian_trail.nim
  - atcoder/extra/graph/eulerian_trail.nim
  - atcoder/extra/graph/chu_liu_edmonds.nim
  - atcoder/extra/graph/chu_liu_edmonds.nim
  - atcoder/extra/graph/boruvka.nim
  - atcoder/extra/graph/boruvka.nim
  - atcoder/extra/graph/kruskal.nim
  - atcoder/extra/graph/kruskal.nim
  - atcoder/extra/graph/eulerian_trail.nim
  - atcoder/extra/graph/eulerian_trail.nim
  timestamp: '2020-09-18 00:06:18+09:00'
  verificationStatus: LIBRARY_SOME_WA
  verifiedWith:
  - verify/dsu_test.nim
  - verify/dsu_test.nim
  - verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
  - verify/extra/graph/aoj_grl_2_b_minimum_spanning_tree_arborescence_test.nim
  - verify/extra/graph/yosupo_directedmst_test.nim
  - verify/extra/graph/yosupo_directedmst_test.nim
  - verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
  - verify/extra/graph/aoj_grl_2_a_2_minimum_spanning_tree_kruskal_test.nim
  - verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
  - verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
documentation_of: atcoder/dsu.nim
layout: document
redirect_from:
- /library/atcoder/dsu.nim
- /library/atcoder/dsu.nim.html
title: atcoder/dsu.nim
---
