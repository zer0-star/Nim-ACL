---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/point_add_range_sum
    links:
    - https://judge.yosupo.jp/problem/point_add_range_sum
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum\n\
    \nimport atcoder/header\nimport atcoder/fenwicktree\n\nimport std/sequtils\n\n\
    let N, Q = nextInt()\nlet a = newSeqWith(N, nextInt())\n\nvar st = initFenwickTree[int](N)\n\
    \nfor i in 0..<N: st.add(i, a[i])\nfor _ in 0 ..< Q:\n  let t = nextInt()\n  if\
    \ t == 0:\n    let p, x = nextInt()\n    st.add(p, x)\n  else:\n    let l, r =\
    \ nextInt()\n    echo st.sum(l..<r)\n"
  dependsOn: []
  isVerificationFile: true
  path: src/verify/fenwick_tree_test.nim
  requiredBy: []
  timestamp: '2020-09-23 23:13:39+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: src/verify/fenwick_tree_test.nim
layout: document
redirect_from:
- /verify/src/verify/fenwick_tree_test.nim
- /verify/src/verify/fenwick_tree_test.nim.html
title: src/verify/fenwick_tree_test.nim
---
