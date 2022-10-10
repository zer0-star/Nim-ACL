---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import sequtils\n\ntype WeightedUnionFind[T] = object\n  data:seq[int]\n\
    \  ws:seq[T]\n\nproc initWeightedUnionFind[T](sz:int):WeightedUnionFind[T] =\n\
    \  WeightedUnionFind[T](data:newSeqWith(sz, -1), ws:newSeq[T](sz))\n\nproc root[T](self:var\
    \ WeightedUnionFind[T], k:int):int{.discardable.} =\n  if self.data[k] < 0: return\
    \ k\n  let par = self.root(self.data[k])\n  self.ws[k] += self.ws[self.data[k]]\n\
    \  self.data[k] = par\n  return self.data[k]\n\nproc weight[T](self:var WeightedUnionFind[T],\
    \ t:int):T =\n  self.root(t)\n  return self.ws[t]\n\nproc unionSet[T](self:var\
    \ WeightedUnionFind[T], x,y:int, w:T):bool{.discardable.} =\n  var w = w\n  w\
    \ += self.weight(x)\n  w -= self.weight(y)\n  var\n    x = self.root(x)\n    y\
    \ = self.root(y)\n  if x == y: return false\n  if self.data[x] > self.data[y]:\n\
    \    swap(x, y)\n    w *= -1\n  self.data[x] += self.data[y]\n  self.data[y] =\
    \ x\n  self.ws[y] = w\n  return true\n\nproc diff[T](self:var WeightedUnionFind[T],\
    \ x,y:int):T =\n  return self.weight(y) - self.weight(x)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/weighted_union_find.nim
  requiredBy: []
  timestamp: '2020-12-31 00:02:41+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/structure/weighted_union_find.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/weighted_union_find.nim
- /library/atcoder/extra/structure/weighted_union_find.nim.html
title: atcoder/extra/structure/weighted_union_find.nim
---
