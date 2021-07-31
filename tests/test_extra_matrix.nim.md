---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':x:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':x:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
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
  code: "import std/unittest, std/sugar\n\nimport atcoder/modint\nimport atcoder/extra/math/matrix\n\
    \ntype mint = modint998244353\ntype M = MatrixType(mint)\nimport rationals\ntype\
    \ MR = MatrixType(Rational[int], ()=>initRational[int](0, 1), ()=>initRational[int](1,\
    \ 1))\nconverter toRational[T](a:T):Rational[T] = initRational[T](a, T(1))\ntype\
    \ MF = MatrixType(float, ()=>0.0, ()=>1.0, (a:float)=>a<0.00000001)\n\ntest \"\
    MatrixOperation\":\n  var A = M.init([[1, 2], [3, 4], [5, 6]])\n  var A2 = M.init([[3,\
    \ 7], [2, 9], [5, 7]])\n  var S = M.init([[4, 9], [5, 13], [10, 13]])\n  var D\
    \ = M.init([[-2, -5], [1, -5], [0, -1]])\n  var B = M.init([[3, 1, 4], [1, 5,\
    \ 9]])\n  var v = M.initVector([2, 7])\n  var w = M.initVector([16, 34, 52])\n\
    \  var C = M.init([[5, 11, 22], [13, 23, 48], [21, 35, 74]])\n  check A + A2 ==\
    \ S\n  check A - A2 == D\n  check A * B == C\n  check A * v == w\n\ntest \"MatrixPower\"\
    :\n  var A = M.init([[1, 2, 3], [3, 4, 5], [5, 6, 7]])\n  let\n    a = 314\n \
    \   b = 159\n  check A^(a * b) == (A^a)^b\n\ntest \"MatrixDeterminant\":\n  var\
    \ A = M.init([[3, 1, 1, 2], [5, 1, 3, 4], [2, 0, 1, 0], [1, 3, 2, 1]])\n  check\
    \ A.determinant == -22\n  var B = M.init([[2, 7, 9, 8], [1, 7, 9, 6], [3, 2, 1,\
    \ 9], [8, 9, 5, 2]])\n  check (A * B).determinant == A.determinant * B.determinant\n\
    \ntest \"MatrixInv\":\n  var A = M.init([[3, 1, 1, 2], [5, 1, 3, 4], [2, 0, 1,\
    \ 0], [1, 3, 2, 1]])\n  check A.inv() * A == A.unit()\n\ntest \"MatrixInvRational\"\
    :\n  var A = MR.init([[3, 1, 1, 2], [5, 1, 3, 4], [2, 0, 1, 0], [1, 3, 2, 1]])\n\
    \  check A.inv() * A == A.unit()\n\ntest \"MatrixInvFloat\":\n  var A = MF.init([[3,\
    \ 1, 1, 2], [5, 1, 3, 4], [2, 0, 1, 0], [1, 3, 2, 1]])\n  check (A.inv() * A).equals(A.unit())\n"
  dependsOn:
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/modint.nim
  - atcoder/element_concepts.nim
  - atcoder/internal_math.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/modint.nim
  - atcoder/element_concepts.nim
  isVerificationFile: false
  path: tests/test_extra_matrix.nim
  requiredBy: []
  timestamp: '2020-12-19 22:31:09+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_extra_matrix.nim
layout: document
redirect_from:
- /library/tests/test_extra_matrix.nim
- /library/tests/test_extra_matrix.nim.html
title: tests/test_extra_matrix.nim
---
