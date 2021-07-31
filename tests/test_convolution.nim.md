---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
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
    links:
    - https://github.com/atcoder/ac-library/issues/30
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import atcoder/convolution\nimport atcoder/modint\nimport std/unittest\n\
    import std/random\nimport std/sequtils\n#include <random>\n#include \"../utils/random.hpp\"\
    \n\ntype ll = int\n\nproc conv_ll_naive(a, b:seq[ll]):seq[ll] =\n  let\n    n\
    \ = a.len\n    m = b.len\n  var c = newSeq[ll](n + m - 1)\n  for i in 0..<n:\n\
    \    for j in 0..<m:\n      c[i + j] += a[i] * b[j]\n  return c\n\nproc conv_naive[mint:StaticModInt](a,\
    \ b:seq[mint]):seq[mint] =\n  let\n    n = a.len\n    m = b.len\n  var c = newSeq[mint](n\
    \ + m - 1)\n  for i in 0..<n:\n    for j in 0..<m:\n      c[i + j] += a[i] * b[j]\n\
    \  return c\n\nproc conv_naive[T:SomeInteger](a, b:seq[T], MOD:static[int]):seq[T]\
    \ =\n  let\n    n = a.len\n    m = b.len\n  var c = newSeq[T](n + m - 1)\n  for\
    \ i in 0..<n:\n    for j in 0..<m:\n      c[i + j] += (T)(a[i].int * b[j].int\
    \ mod MOD)\n      if c[i + j] >= MOD.T: c[i + j] -= MOD.T\n  return c\n\ntest\
    \ \"ConvolutionTest, Empty\":\n  check newSeq[int32]() == convolution(newSeq[int32](),\
    \ newSeq[int32]())\n  check newSeq[int32]() == convolution(newSeq[int32](), @[1.int32,\
    \ 2.int32])\n  check newSeq[int32]() == convolution(@[1.int32, 2.int32], newSeq[int32]())\n\
    \  check newSeq[int32]() == convolution(@[1.int32], newSeq[int32]())\n  check\
    \ newSeq[ll]() == convolution(newSeq[ll](), newSeq[ll]())\n  check newSeq[ll]()\
    \ == convolution(newSeq[ll](), @[1.ll, 2.ll])\n\n  check newSeq[modint998244353]()\
    \ == convolution(newSeq[modint998244353](), newSeq[modint998244353]())\n  check\
    \ newSeq[modint998244353]() == convolution(newSeq[modint998244353](), @[modint998244353.init(1),\
    \ modint998244353.init(2)])\n\ntest \"ConvolutionTest, Mid\":\n  var rnd = initRand(2020)\n\
    \  let\n    n = 1234\n    m = 2345\n  var a = newSeq[modint998244353](n)\n  var\
    \ b = newSeq[modint998244353](m)\n  \n  for i in 0..<n:\n    a[i] = modint998244353.init(rnd.next())\n\
    \  for i in 0..<m:\n    b[i] = modint998244353.init(rnd.next())\n  check conv_naive(a,\
    \ b) == convolution(a, b)\n\nconst MOD1 = 998244353\nconst MOD2 = 924844033\n\
    useStaticModInt(s_mint1, MOD1)\nuseStaticModInt(s_mint2, MOD2)\n\ntest \"ConvolutionTest,\
    \ SimpleSMod\":\n#  type s_mint1 = StaticModInt[MOD1]\n#  type s_mint2 = StaticModInt[MOD2]\n\
    \n  var rnd = initRand(2020)\n  for n in 1..<20:\n    for m in 1..<20:\n     \
    \ var a = newSeq[s_mint1](n)\n      var b = newSeq[s_mint1](m)\n      for i in\
    \ 0..<n:\n        a[i] = s_mint1.init(rnd.next())\n      for i in 0..<m:\n   \
    \     b[i] = s_mint1.init(rnd.next())\n      check conv_naive(a, b) == convolution(a,\
    \ b)\n  for n in 1..<20:\n    for m in 1..<20:\n      var a = newSeq[s_mint2](n)\n\
    \      var b = newSeq[s_mint2](m)\n      for i in 0..<n:\n        a[i] = s_mint2.init(rnd.next())\n\
    \      for i in 0..<m:\n        b[i] = s_mint2.init(rnd.next())\n      check conv_naive(a,\
    \ b) == convolution(a, b)\n\ntest \"ConvolutionTest, SimpleInt\":\n  const MOD1\
    \ = 998244353\n  const MOD2 = 924844033\n\n  var rnd = initRand(2020)\n  for n\
    \ in 1..<20:\n    for m in 1..<20:\n      var a = newSeq[int32](n)\n      var\
    \ b = newSeq[int32](m)\n      for i in 0..<n:\n        a[i] = int32(rnd.next()\
    \ mod MOD1)\n      for i in 0..<m:\n        b[i] = int32(rnd.next() mod MOD1)\n\
    \      check conv_naive(a, b, MOD1) == convolution(a, b)\n      check conv_naive(a,\
    \ b, MOD1) == convolution(a, b, MOD1)\n  for n in 1..<20:\n    for m in 1..<20:\n\
    \      var a = newSeq[int32](n)\n      var b = newSeq[int32](m)\n      for i in\
    \ 0..<n:\n        a[i] = int32(rnd.next() mod MOD2)\n      for i in 0..<m:\n \
    \       b[i] = int32(rnd.next() mod MOD2)\n      check conv_naive(a, b, MOD2)\
    \ == convolution(a, b, MOD2)\n\ntest \"ConvolutionTest, SimpleUint\":\n  const\
    \ MOD1 = 998244353\n  const MOD2 = 924844033\n\n  var rnd = initRand(2020)\n \
    \ for n in 1..<20:\n    for m in 1..<20:\n      var a = newSeq[uint32](n)\n  \
    \    var b = newSeq[uint32](m)\n      for i in 0..<n:\n        a[i] = uint32(rnd.next()\
    \ mod MOD1)\n      for i in 0..<m:\n        b[i] = uint32(rnd.next() mod MOD1)\n\
    \      check conv_naive(a, b, MOD1) == convolution(a, b)\n      check conv_naive(a,\
    \ b, MOD1) == convolution(a, b, MOD1)\n  for n in 1..<20:\n    for m in 1..<20:\n\
    \      var a = newSeq[uint32](n)\n      var b = newSeq[uint32](m)\n      for i\
    \ in 0..<n:\n        a[i] = uint32(rnd.next() mod MOD2)\n      for i in 0..<m:\n\
    \        b[i] = uint32(rnd.next() mod MOD2)\n      check conv_naive(a, b, MOD2)\
    \ == convolution(a, b, MOD2)\n\n\n\ntest \"ConvolutionTest, SimpleLL\":\n  const\
    \ MOD1 = 998244353\n  const MOD2 = 924844033\n\n  var rnd = initRand(2020)\n \
    \ for n in 1..<20:\n    for m in 1..<20:\n      var a = newSeq[int64](n)\n   \
    \   var b = newSeq[int64](m)\n      for i in 0..<n:\n        a[i] = int64(rnd.next()\
    \ mod MOD1)\n      for i in 0..<m:\n        b[i] = int64(rnd.next() mod MOD1)\n\
    \      check conv_naive(a, b, MOD1) == convolution(a, b)\n      check conv_naive(a,\
    \ b, MOD1) == convolution(a, b, MOD1)\n  for n in 1..<20:\n    for m in 1..<20:\n\
    \      var a = newSeq[int64](n)\n      var b = newSeq[int64](m)\n      for i in\
    \ 0..<n:\n        a[i] = int64(rnd.next() mod MOD2)\n      for i in 0..<m:\n \
    \       b[i] = int64(rnd.next() mod MOD2)\n      check conv_naive(a, b, MOD2)\
    \ == convolution(a, b, MOD2)\n\n\ntest \"ConvolutionTest, SimpleULL\":\n  const\
    \ MOD1 = 998244353\n  const MOD2 = 924844033\n\n  var rnd = initRand(2020)\n \
    \ for n in 1..<20:\n    for m in 1..<20:\n      var a = newSeq[uint64](n)\n  \
    \    var b = newSeq[uint64](m)\n      for i in 0..<n:\n        a[i] = uint64(rnd.next()\
    \ mod MOD1)\n      for i in 0..<m:\n        b[i] = uint64(rnd.next() mod MOD1)\n\
    \      check conv_naive(a, b, MOD1) == convolution(a, b)\n      check conv_naive(a,\
    \ b, MOD1) == convolution(a, b, MOD1)\n  for n in 1..<20:\n    for m in 1..<20:\n\
    \      var a = newSeq[uint64](n)\n      var b = newSeq[uint64](m)\n      for i\
    \ in 0..<n:\n        a[i] = uint64(rnd.next() mod MOD2)\n      for i in 0..<m:\n\
    \        b[i] = uint64(rnd.next() mod MOD2)\n      check conv_naive(a, b, MOD2)\
    \ == convolution(a, b, MOD2)\n\n##ifndef _MSC_VER\n#TEST(ConvolutionTest, SimpleInt128)\
    \ {\n#  const int MOD1 = 998244353;\n#  const int MOD2 = 924844033;\n#\n#  mt19937\
    \ mt;\n#  for (int n = 1; n < 20; n++) {\n#    for (int m = 1; m < 20; m++) {\n\
    #      seq[__int128> a(n), b(m);\n#      for (int i = 0; i < n; i++) {\n#    \
    \    a[i] = mt() % MOD1;\n#      }\n#      for (int i = 0; i < m; i++) {\n#  \
    \      b[i] = mt() % MOD1;\n#      }\n#      check conv_naive<MOD1>(a, b), convolution(a,\
    \ b));\n#      check conv_naive<MOD1>(a, b), (convolution<MOD1>(a, b)));\n#  \
    \  }\n#  }\n#  for (int n = 1; n < 20; n++) {\n#    for (int m = 1; m < 20; m++)\
    \ {\n#      seq[__int128> a(n), b(m);\n#      for (int i = 0; i < n; i++) {\n\
    #        a[i] = mt() % MOD2;\n#      }\n#      for (int i = 0; i < m; i++) {\n\
    #        b[i] = mt() % MOD2;\n#      }\n#      check conv_naive<MOD2>(a, b), (convolution<MOD2>(a,\
    \ b)));\n#    }\n#  }\n#}\n#\n#TEST(ConvolutionTest, SimpleUInt128) {\n#  const\
    \ int MOD1 = 998244353;\n#  const int MOD2 = 924844033;\n#\n#  mt19937 mt;\n#\
    \  for (int n = 1; n < 20; n++) {\n#    for (int m = 1; m < 20; m++) {\n#    \
    \  seq[unsigned __int128> a(n), b(m);\n#      for (int i = 0; i < n; i++) {\n\
    #        a[i] = mt() % MOD1;\n#      }\n#      for (int i = 0; i < m; i++) {\n\
    #        b[i] = mt() % MOD1;\n#      }\n#      check conv_naive<MOD1>(a, b), convolution(a,\
    \ b));\n#      check conv_naive<MOD1>(a, b), (convolution<998244353>(a, b)));\n\
    #    }\n#  }\n#  for (int n = 1; n < 20; n++) {\n#    for (int m = 1; m < 20;\
    \ m++) {\n#      seq[unsigned __int128> a(n), b(m);\n#      for (int i = 0; i\
    \ < n; i++) {\n#        a[i] = mt() % MOD2;\n#      }\n#      for (int i = 0;\
    \ i < m; i++) {\n#        b[i] = mt() % MOD2;\n#      }\n#      check conv_naive<MOD2>(a,\
    \ b), (convolution<MOD2>(a, b)));\n#    }\n#  }\n#}\n#\n##endif\n\ntest \"ConvolutionTest,\
    \ ConvLL\":\n  var rnd = initRand(2020)\n  for n in 1..<20:\n    for m in 1..<20:\n\
    \      var a = newSeq[ll](n)\n      var b = newSeq[ll](m)\n      for i in 0..<n:\n\
    \        a[i] = ll(rnd.next() mod 1_000_000) - 500_000\n      for i in 0..<m:\n\
    \        b[i] = ll(rnd.next() mod 1_000_000) - 500_000\n      check conv_ll_naive(a,\
    \ b) == convolution_ll(a, b)\n\ntest \"ConvolutionTest, ConvLLBound\":\n  const\n\
    \    MOD1 = 469762049.uint  # 2^26\n    MOD2 = 167772161.uint  # 2^25\n    MOD3\
    \ = 754974721.uint  # 2^24\n    M2M3 = MOD2 * MOD3\n    M1M3 = MOD1 * MOD3\n \
    \   M1M2 = MOD1 * MOD2\n  for i in -1000..1000:\n    let\n      a = @[ll(0.uint\
    \ - M1M2 - M1M3 - M2M3 + i.uint)]\n      b = @[1]\n\n    check a == convolution_ll(a,\
    \ b)\n  for i in 0..<1000:\n    let\n      a = @[ll.low + i]\n      b = @[1]\n\
    \n    check a == convolution_ll(a, b)\n\n  for i in 0..<1000:\n    let\n     \
    \ a = @[ll.high - i]\n      b = @[1]\n\n    check a == convolution_ll(a, b)\n\n\
    # https://github.com/atcoder/ac-library/issues/30\ntest \"ConvolutionTest, Conv641\"\
    :\n  # 641 = 128 * 5 + 1\n  const MOD = 641\n  var\n    rnd = initRand(2020)\n\
    \    a = newSeqWith(64, rnd.rand(MOD - 1).ll)\n    b = newSeqWith(65, rnd.rand(MOD\
    \ - 1).ll)\n\n  check conv_naive(a, b, MOD) == convolution(a, b, MOD)\n\n# https://github.com/atcoder/ac-library/issues/30\n\
    test \"ConvolutionTest, Conv18433\":\n  # 18433 = 2048 * 9 + 1\n  const MOD =\
    \ 18433\n  var\n    rnd = initRand(2020)\n    a = newSeqWith(1024, rnd.rand(MOD\
    \ - 1).ll)\n    b = newSeqWith(1025, rnd.rand(MOD - 1).ll)\n\n  check conv_naive(a,\
    \ b, MOD) == convolution(a, b, MOD)\n"
  dependsOn:
  - atcoder/generate_definitions.nim
  - atcoder/modint.nim
  - atcoder/convolution.nim
  - atcoder/element_concepts.nim
  - atcoder/internal_math.nim
  - atcoder/internal_bit.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/internal_bit.nim
  - atcoder/modint.nim
  - atcoder/convolution.nim
  - atcoder/element_concepts.nim
  isVerificationFile: false
  path: tests/test_convolution.nim
  requiredBy: []
  timestamp: '2020-11-17 21:17:38+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_convolution.nim
layout: document
redirect_from:
- /library/tests/test_convolution.nim
- /library/tests/test_convolution.nim.html
title: tests/test_convolution.nim
---
