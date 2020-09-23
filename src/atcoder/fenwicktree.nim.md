---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links:
    - https://en.wikipedia.org/wiki/Fenwick_tree
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_FENWICKTREE_HPP:\n  const ATCODER_FENWICKTREE_HPP*\
    \ = 1\n  import std/sequtils\n\n  # TODO\n  #include <atcoder/internal_type_traits>\n\
    \n  # Reference: https://en.wikipedia.org/wiki/Fenwick_tree\n  type fenwick_tree*[T]\
    \ = object\n    n:int\n    data:seq[T]\n  \n  # TODO\n  #  using U = internal::to_unsigned_t<T>;\n\
    \  \n  proc init_fenwick_tree*[T](n:int):auto\n    = fenwick_tree[T](n:n, data:newSeqWith(n,\
    \ T(0)))\n  \n  proc add*[T](self: var fenwick_tree[T], p:int, x:T) =\n    assert\
    \ p in 0..<self.n\n    var p = p + 1\n    while p <= self.n:\n  # TODO\n  #  \
    \    self.data[p - 1] += U(x)\n      self.data[p - 1] += x\n      p += p and -p\n\
    \  proc sum*[T](self: fenwick_tree[T], r:int):T =\n    var\n      s = T(0)\n \
    \     r = r\n    while r > 0:\n      s += self.data[r - 1]\n      r -= r and -r\n\
    \    return s\n  proc sum*[T](self: fenwick_tree[T], p:Slice[int]):T =\n    let\
    \ (l, r) = (p.a, p.b + 1)\n    assert 0 <= l and l <= r and r <= self.n\n    return\
    \ self.sum(r) - self.sum(l)\n  \n#  U sum(int r) =\n#    U s = 0;\n#    while\
    \ (r > 0) {\n#      s += data[r - 1];\n#      r -= r & -r;\n#    }\n#    return\
    \ s;\n#  }\n\n"
  dependsOn: []
  isVerificationFile: false
  path: src/atcoder/fenwicktree.nim
  requiredBy: []
  timestamp: '2020-09-18 00:06:18+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/atcoder/fenwicktree.nim
layout: document
redirect_from:
- /library/src/atcoder/fenwicktree.nim
- /library/src/atcoder/fenwicktree.nim.html
title: src/atcoder/fenwicktree.nim
---
