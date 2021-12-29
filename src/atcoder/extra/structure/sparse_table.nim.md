---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_staticrmq_test.nim
    title: verify/extra/structure/yosupo_staticrmq_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/structure/yosupo_staticrmq_test.nim
    title: verify/extra/structure/yosupo_staticrmq_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SPARSE_TABLE_HPP:\n  const ATCODER_SPARSE_TABLE_HPP*\
    \ = 1\n  import std/sequtils\n\n  {.push inline.}\n\n  type SparseTable*[T] =\
    \ object\n    data: seq[seq[T]]\n    lookup: seq[int]\n    f: proc(a, b:T):T\n\
    \n  proc initSparseTable*[T](v:seq[T], f:proc(a, b:T):T):SparseTable[T] =\n  \
    \  var b = 0\n    while (1 shl b) <= v.len: b += 1\n    var data = newSeqWith(b,\
    \ newSeq[T](1 shl b))\n    for i in 0..<v.len: data[0][i] = v[i]\n    for i in\
    \ 1..<b:\n      var j = 0\n      while j + (1 shl i) <= (1 shl b):\n        data[i][j]\
    \ = f(data[i - 1][j], data[i - 1][j + (1 shl (i - 1))]);\n        j += 1\n   \
    \ var lookup = newSeq[int](v.len + 1)\n    for i in 2..<lookup.len: lookup[i]\
    \ = lookup[i shr 1] + 1\n    return SparseTable[T](data:data, lookup:lookup, f:f)\n\
    \n  proc prod*[T](self: SparseTable[T], s:Slice[int]):T =\n    let b = self.lookup[s.b\
    \ + 1 - s.a]\n    return self.f(self.data[b][s.a], self.data[b][s.b + 1 - (1 shl\
    \ b)])\n  proc `[]`*[T](self: SparseTable[T], s:Slice[int]):T = self.prod(s)\n\
    \  {.pop.}\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/sparse_table.nim
  requiredBy: []
  timestamp: '2021-03-01 01:28:35+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/structure/yosupo_staticrmq_test.nim
  - verify/extra/structure/yosupo_staticrmq_test.nim
documentation_of: atcoder/extra/structure/sparse_table.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/sparse_table.nim
- /library/atcoder/extra/structure/sparse_table.nim.html
title: atcoder/extra/structure/sparse_table.nim
---
