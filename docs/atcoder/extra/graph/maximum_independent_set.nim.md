---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_maximum_independent_set_test.nim
    title: verify/extra/graph/yosupo_maximum_independent_set_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_maximum_independent_set_test.nim
    title: verify/extra/graph/yosupo_maximum_independent_set_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_MAXIMUM_INDEPENDENT_SET_HPP:\n  const ATCODER_MAXIMUM_INDEPENDENT_SET_HPP*\
    \ = 1\n  import random, sequtils\n  \n  proc maximum_independent_set*[T](g:seq[seq[T]],\
    \ trial = 1000000):seq[int] = \n    let N = g.len\n    assert(N <= 64);\n  \n\
    \    var bit = newseq[uint64](N)\n    for i in 0..<N:\n      for j in 0..<N:\n\
    \        if i != j:\n          assert(g[i][j] == g[j][i])\n          if g[i][j]\
    \ != 0:\n            bit[i] = bit[i] or (1.uint64 shl j);\n  \n    var order =\
    \ toSeq(0..<N)\n    var \n      ret = 0\n      ver = 0.uint64\n    for i in 0..<trial:\n\
    \      order.shuffle()\n      var\n        used = 0.uint64\n        a = 0\n  \
    \    for j in order:\n        if (used and bit[j]) > 0.uint64: continue\n    \
    \    used = used or (1.uint64 shl j)\n        a += 1\n      if ret < a:\n    \
    \    ret = a\n        ver = used\n    var ans = newSeq[int]()\n    for i in 0..<N:\n\
    \      if ((ver shr i) and 1.uint64) > 0.uint64: ans.add(i)\n    return ans\n\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/graph/maximum_independent_set.nim
  requiredBy: []
  timestamp: '2020-12-19 22:31:09+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/yosupo_maximum_independent_set_test.nim
  - verify/extra/graph/yosupo_maximum_independent_set_test.nim
documentation_of: atcoder/extra/graph/maximum_independent_set.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/maximum_independent_set.nim
- /library/atcoder/extra/graph/maximum_independent_set.nim.html
title: atcoder/extra/graph/maximum_independent_set.nim
---
