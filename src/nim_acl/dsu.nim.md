---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/dsu_test.nim
    title: verify/dsu_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/dsu_test.nim
    title: verify/dsu_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_DSU_HPP:\n  const ATCODER_DSU_HPP* = 1\n\n  import\
    \ sequtils\n\n  type\n    DSU* = ref object\n      n: int\n      par_or_siz: seq[int]\n\
    \n  proc initDSU*(n: int): DSU {.inline.} =\n    return DSU(n: n, par_or_siz:\
    \ newSeqWith(n, -1))\n\n  proc leader*(self: DSU; a: int): int {.inline.} =\n\
    \    ## Path compression\n    if self.par_or_siz[a] < 0: return a\n    self.par_or_siz[a]\
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
  path: src/nim_acl/dsu.nim
  requiredBy: []
  timestamp: '2020-09-14 00:37:28+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/dsu_test.nim
  - verify/dsu_test.nim
documentation_of: src/nim_acl/dsu.nim
layout: document
redirect_from:
- /library/src/nim_acl/dsu.nim
- /library/src/nim_acl/dsu.nim.html
title: src/nim_acl/dsu.nim
---
