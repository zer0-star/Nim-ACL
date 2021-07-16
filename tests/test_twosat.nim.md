---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':x:'
    path: atcoder/twosat.nim
    title: atcoder/twosat.nim
  - icon: ':x:'
    path: atcoder/twosat.nim
    title: atcoder/twosat.nim
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
  code: "import atcoder/twosat\nimport std/unittest\nimport std/random\nimport std/sequtils\n\
    \ntest \"TwosatTest, Empty\":\n# TODO: NIM\u3067empty\u306F\u7121\u7406\uFF1F\n\
    #  two_sat ts0;\n#  ASSERT_TRUE(ts0.satisfiable());\n#  check std::vector<bool>({}),\
    \ ts0.answer());\n  var ts1 = initTwoSat(0)\n  check ts1.satisfiable()\n  check\
    \ newSeq[bool]() == ts1.answer()\n\ntest \"TwosatTest, One\":\n  block:\n    var\
    \ ts = initTwoSat(1)\n    ts.add_clause(0, true, 0, true)\n    ts.add_clause(0,\
    \ false, 0, false)\n    check: not ts.satisfiable()\n  block:\n    var ts = initTwoSat(1)\n\
    \    ts.add_clause(0, true, 0, true)\n    check ts.satisfiable()\n    check @[true]\
    \ == ts.answer()\n  block:\n    var ts = initTwoSat(1)\n    ts.add_clause(0, false,\
    \ 0, false)\n    check ts.satisfiable()\n    check @[false] == ts.answer()\n\n\
    test \"TwosatTest, Assign\":\n  var ts = initTwoSat(10)\n\ntest \"TwosatTest,\
    \ StressOK\":\n  var rnd = initRand(2020)\n  for phase in 0..<10000:\n    let\
    \ n = rnd.rand(1..20)\n    let m = rnd.rand(1..100)\n    var expect = newSeqWith(n,\
    \ rnd.rand(2) == 1)\n\n    var ts = initTwoSat(n)\n    var\n      xs = newSeq[int](m)\n\
    \      ys = newSeq[int](m)\n      types = newSeq[int](m)\n    for i in 0..<m:\n\
    \      let x = rnd.rand(n - 1)\n      let y = rnd.rand(n - 1)\n      let t = rnd.rand(2)\n\
    \      xs[i] = x\n      ys[i] = y\n      types[i] = t\n      if t == 0:\n    \
    \    ts.add_clause(x, expect[x], y, expect[y])\n      elif t == 1:\n        ts.add_clause(x,\
    \ not expect[x], y, expect[y])\n      else:\n        ts.add_clause(x, expect[x],\
    \ y, not expect[y])\n    check ts.satisfiable()\n    let actual = ts.answer()\n\
    \    for i in 0..<m:\n      let\n        x = xs[i]\n        y = ys[i]\n      \
    \  t = types[i]\n      if t == 0:\n        check actual[x] == expect[x] or actual[y]\
    \ == expect[y]\n      elif t == 1:\n        check actual[x] != expect[x] or actual[y]\
    \ == expect[y]\n      else:\n        check actual[x] == expect[x] or actual[y]\
    \ != expect[y]\n"
  dependsOn:
  - atcoder/internal_scc.nim
  - atcoder/twosat.nim
  - atcoder/internal_scc.nim
  - atcoder/twosat.nim
  isVerificationFile: false
  path: tests/test_twosat.nim
  requiredBy: []
  timestamp: '2021-07-16 23:11:44+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_twosat.nim
layout: document
redirect_from:
- /library/tests/test_twosat.nim
- /library/tests/test_twosat.nim.html
title: tests/test_twosat.nim
---
