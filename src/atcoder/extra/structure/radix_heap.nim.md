---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/dijkstra_radix_heap.nim
    title: atcoder/extra/graph/dijkstra_radix_heap.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/dijkstra_radix_heap.nim
    title: atcoder/extra/graph/dijkstra_radix_heap.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/dijkstra_radix_heap.nim
    title: atcoder/extra/graph/dijkstra_radix_heap.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/dijkstra_radix_heap.nim
    title: atcoder/extra/graph/dijkstra_radix_heap.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
    title: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
    title: verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_RADIX_HEAP_HPP:\n  const ATCODER_RADIX_HEAP_HPP*\
    \ = 1\n  import std/bitops\n  proc calcBit(key_t:typedesc[SomeInteger]):int {.compileTime.}\
    \ = sizeof(key_t) * 8\n  type RadixHeap*[key_t, val_t] = object\n    sz:uint\n\
    \    last:key_t\n    vs:array[sizeof(key_t) * 8, seq[(key_t, val_t)]]\n\n  proc\
    \ initRadixHeap*[key_t, val_t]():RadixHeap[key_t, val_t] = RadixHeap[key_t, val_t](sz:0,\
    \ last:key_t(0))\n\n  proc empty*[T:RadixHeap](self:T):bool = self.sz == 0\n \
    \ proc len*[T:RadixHeap](self:T):int = self.sz\n\n  proc getbit*(self:RadixHeap,\
    \ a:int32):int =\n    const bit = calcBit(self.key_t)\n    if a != 0: bit - countLeadingZeroBits(a)\
    \ else: 0\n\n  proc getbit*(self:RadixHeap, a:int or int64):int =\n    const bit\
    \ = calcBit(self.key_t)\n    if a != 0: bit - countLeadingZeroBits(a) else: 0\n\
    \n  proc push*(self:var RadixHeap, key:self.key_t, val:self.val_t) =\n    self.sz.inc\n\
    \    self.vs[self.getbit(key xor self.last)].add((key, val))\n\n  proc pop*(self:var\
    \ RadixHeap):(self.key_t, self.val_t) =\n    proc calc_min_key(v:seq[(self.key_t,\
    \ self.val_t)]):self.key_t =\n      result = v[0][0]\n      for i in 1..<v.len:\n\
    \        if result > v[i][0]: result = v[i][0]\n    if self.vs[0].len == 0:\n\
    \      var idx = 1\n      while self.vs[idx].len == 0: idx.inc\n      self.last\
    \ = calc_min_key(self.vs[idx])\n      for p in self.vs[idx]: self.vs[self.getbit(p[0]\
    \ xor self.last)].add(p)\n      self.vs[idx].setLen(0)\n    self.sz.dec\n    result\
    \ = self.vs[0][^1]\n    discard self.vs[0].pop()\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/radix_heap.nim
  requiredBy:
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  - atcoder/extra/graph/dijkstra_radix_heap.nim
  timestamp: '2021-03-01 01:28:35+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
  - verify/extra/graph/aoj_grl_1_a_dijkstra_radix_heap_test.nim
documentation_of: atcoder/extra/structure/radix_heap.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/radix_heap.nim
- /library/atcoder/extra/structure/radix_heap.nim.html
title: atcoder/extra/structure/radix_heap.nim
---
