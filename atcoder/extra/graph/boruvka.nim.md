---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/dsu.nim
    title: atcoder/dsu.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
    title: verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
    title: verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_BORUVKA_HPP:\n  const ATCODER_BORUVKA_HPP* = 1\n\
    \  import std/sequtils\n  import atcoder/dsu\n\n  type Boruvka*[T] = object\n\
    \    V:int\n    inf:T\n    uf:DSU\n\n  proc initBoruvka*[T](V:int, inf = -1):Boruvka[T]\
    \ =\n    let inf = if inf == -1: T.inf else: inf\n    Boruvka[T](V:V, inf:inf,\
    \ uf:initDSU(V))\n\n  proc find*[T](self:Boruvka[T], k:int):int = self.uf.leader(k)\n\
    \n  proc build*[T](self:Boruvka[T], update:proc(ret:var seq[(int,int)])):T =\n\
    \    result = T(0)\n    while self.uf.size(0) < self.V:\n      var v = newSeqWith(self.V,\
    \ (self.inf, -1))\n      update(v)\n      var con = false\n      for i in 0..<self.V:\n\
    \        if v[i][1] >= 0 and not self.uf.same(i, v[i][1]):\n          self.uf.merge(i,\
    \ v[i][1])\n          result += v[i][0]\n          con = true\n      if not con:\
    \ return self.inf\n"
  dependsOn:
  - atcoder/dsu.nim
  - atcoder/dsu.nim
  isVerificationFile: false
  path: atcoder/extra/graph/boruvka.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
  - verify/extra/graph/aoj_grl_2_a_3_boruvka_test.nim
documentation_of: atcoder/extra/graph/boruvka.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/boruvka.nim
- /library/atcoder/extra/graph/boruvka.nim.html
title: atcoder/extra/graph/boruvka.nim
---
