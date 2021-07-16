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
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import std/unittest\nimport atcoder/dsu\n\ntest \"DSUTest, Zero\":\n  var\
    \ uf = initDSU(0)\n  check newSeq[seq[int]]() == uf.groups()\n\n# TODO: Nim\u3067\
    empty\u306F\u3067\u304D\u306A\u305D\u3046\n#test \"DSUTest, Empty\":\n#  var uf:DSU\n\
    #  check newSeq[seq[int]]() == uf.groups()\n\ntest \"DSUTest, Assign\":\n  var\
    \ uf = initDSU(10)\n\ntest \"DSUTest, Simple\":\n  var uf = initDSU(2)\n  check\
    \ not uf.same(0, 1)\n  let x = uf.merge(0, 1)\n  check x == uf.leader(0)\n  check\
    \ x == uf.leader(1)\n  check uf.same(0, 1)\n  check 2 == uf.size(0)\n\ntest \"\
    DSUTest, Line\":\n  let n = 500000\n  var uf = initDSU(n)\n  for i in 0 ..< n\
    \ - 1:\n    uf.merge(i, i + 1)\n  check n == uf.size(0)\n  check 1 == uf.groups().len\n\
    \ntest \"DSUTest, LineReverse\":\n  let n = 500000\n  var uf = initDSU(n)\n  for\
    \ i in countdown(n - 2, 0):\n    uf.merge(i, i + 1)\n  check n == uf.size(0)\n\
    \  check 1 == uf.groups().len\n"
  dependsOn:
  - atcoder/dsu.nim
  - atcoder/dsu.nim
  isVerificationFile: false
  path: tests/test_dsu.nim
  requiredBy: []
  timestamp: '2021-07-16 23:11:44+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_dsu.nim
layout: document
redirect_from:
- /library/tests/test_dsu.nim
- /library/tests/test_dsu.nim.html
title: tests/test_dsu.nim
---
