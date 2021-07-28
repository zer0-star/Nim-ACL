---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/math.nim
    title: atcoder/math.nim
  - icon: ':question:'
    path: atcoder/math.nim
    title: atcoder/math.nim
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
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/internal_math>\n#include <numeric>\n\
    #include \"../utils/math.hpp\"\n\nimport std/unittest\nimport atcoder/internal_math\n\
    import atcoder/math\nimport std/math as math_lib\nimport ../test/utils/math as\
    \ math_util_lib\n#using namespace atcoder;\n#using uint = unsigned int;\ntype\
    \ ll = int\n#using ull = unsigned long long;\n\n#ll gcd(ll a, ll b) {\n#  assert(0\
    \ <= a && 0 <= b);\n#  if (b == 0) return a;\n#  return gcd(b, a % b);\n#}\n\n\
    #ll pow_mod_naive(ll x, ull n, uint mod) {\n#  ull y = (x % mod + mod) % mod;\n\
    #  ull z = 1;\n#  for (ull i = 0; i < n; i++) {\n#    z = (z * y) % mod;\n#  }\n\
    #  return z % mod;\n#}\n\n#ll floor_sum_naive(ll n, ll m, ll a, ll b) {\n#  ll\
    \ sum = 0;\n#  for (ll i = 0; i < n; i++) {\n#    sum += (a * i + b) div m;\n\
    #  }\n#  return sum;\n#}\n\nproc is_prime_naive(n:ll):bool =\n  assert 0 <= n\
    \ and n <= int32.high.ll\n  if n == 0 or n == 1: return false\n  var i = 2\n \
    \ while i * i <= n:\n    if n mod i == 0: return false\n    i.inc\n  return true\n\
    \ntest \"InternalMathTest, Barrett\":\n  for m in 1..100:\n    var bt = initBarrett(m.uint)\n\
    \    for a in 0..<m:\n      for b in 0..<m:\n        check (a * b) mod m == bt.mul(a.uint,\
    \ b.uint).int\n\n  var bt = initBarrett(1)\n  check 0 == bt.mul(0.uint, 0.uint).int\n\
    \ntest \"InternalMathTest, BarrettBorder\":\n  const mod_upper = int32.high.uint32\n\
    \  for m in countdown(mod_upper, mod_upper - 20.uint32):\n    var bt = initBarrett(m)\n\
    \    var v = newSeq[uint32]()\n    for i in 0.uint32..<10.uint32:\n      v.add(i)\n\
    \      v.add(m - i)\n      v.add(m div 2.uint32 + i)\n      v.add(m div 2.uint32\
    \ - i)\n    for a in v:\n      let a2 = a.ll\n      check ((a2 * a2) mod m.ll\
    \ * a2) mod m.ll == bt.mul(a, bt.mul(a, a)).ll\n      for b in v:\n        let\
    \ b2 = b.ll\n        check (a2 * b2) mod m.ll == bt.mul(a, b).ll\n\ntest \"InternalMathTest,\
    \ IsPrime\":\n  check not is_prime[121]()\n  check not is_prime[11 * 13]()\n \
    \ check is_prime[1_000_000_007]()\n  check not is_prime[1_000_000_008]()\n  check\
    \ is_prime[1_000_000_009]()\n  for i in 1..10000:\n    check is_prime_naive(i)\
    \ == is_prime_constexpr(i)\n  for i in 1..10000:\n    let x = int32.high.int -\
    \ i\n    check is_prime_naive(x) == is_prime_constexpr(x)\n\n##ifndef _MSC_VER\n\
    #test \"InternalMathTest, SafeMod) {\n#  std::vector<ll> preds;\n#  for (int i\
    \ = 0; i <= 100; i++) {\n#    preds.add(i);\n#    preds.add(-i);\n#    preds.add(i);\n\
    #    preds.add(ll.low + i);\n#    preds.add(ll.high - i);\n#  }\n#\n#  for (auto\
    \ a : preds) {\n#    for (auto b : preds) {\n#      if (b <= 0) continue;\n# \
    \     ll ans = (ll)((__int128(a) % b + b) % b);\n#      ASSERT_EQ(ans, safe_mod(a,\
    \ b));\n#    }\n#  }\n#}\n##endif\n\ntest \"InternalMathTest, InvGcdBound\":\n\
    \  var pred = newSeq[ll]()\n  for i in 0..10:\n    pred.add(i)\n    pred.add(-i)\n\
    \    pred.add(ll.low + i)\n    pred.add(ll.high - i)\n\n    pred.add(ll.low div\
    \ 2 + i)\n    pred.add(ll.low div 2 - i)\n    pred.add(ll.high div 2 + i)\n  \
    \  pred.add(ll.high div 2 - i)\n\n    pred.add(ll.low div 3 + i)\n    pred.add(ll.low\
    \ div 3 - i)\n    pred.add(ll.high div 3 + i)\n    pred.add(ll.high div 3 - i)\n\
    \  pred.add(998244353)\n  pred.add(1_000_000_007)\n  pred.add(1_000_000_009)\n\
    \  pred.add(-998244353)\n  pred.add(-1_000_000_007)\n  pred.add(-1_000_000_009)\n\
    \n  for a in pred:\n    for b in pred:\n      if b <= 0: continue\n      let a2\
    \ = floorMod(a, b)\n      let eg = inv_gcd(a, b)\n      let g = gcd(a2, b)\n \
    \     check g == eg[0]\n      check 0 <= eg[1]\n      check eg[1] <= b div eg[0]\n\
    ##ifndef _MSC_VER\n#      ASSERT_EQ(g % b, (unsigned __int128)(eg.second) * a2\
    \ % b);\n##endif\n\ntest \"InternalMathTest, PrimitiveRootTestNaive\":\n  for\
    \ m in 2..10000:\n    if not is_prime_constexpr(m): continue\n    let n = primitive_root_constexpr(m)\n\
    \    check 1 <= n\n    check n < m\n    var x = 1\n    for i in 1..m-2:\n    \
    \  x = x * n mod m\n      # x == n^i\n      check 1 != x\n    x = x * n mod m\n\
    \    check 1 == x\n\ntest \"InternalMathTest, PrimitiveRootTemplateTest\":\n \
    \ check is_primitive_root(2, (primitive_root[2]()))\n  check is_primitive_root(3,\
    \ (primitive_root[3]()))\n  check is_primitive_root(5, (primitive_root[5]()))\n\
    \  check is_primitive_root(7, (primitive_root[7]()))\n  check is_primitive_root(11,\
    \ (primitive_root[11]()))\n  check is_primitive_root(998244353, (primitive_root[998244353]()))\n\
    \  check is_primitive_root(1000000007, (primitive_root[1000000007]()))\n  check\
    \ is_primitive_root(469762049, (primitive_root[469762049]()))\n  check is_primitive_root(167772161,\
    \ (primitive_root[167772161]()))\n  check is_primitive_root(754974721, (primitive_root[754974721]()))\n\
    \  check is_primitive_root(324013369, (primitive_root[324013369]()))\n  check\
    \ is_primitive_root(831143041, (primitive_root[831143041]()))\n  check is_primitive_root(1685283601,\
    \ (primitive_root[1685283601]()))\n\ntest \"InternalMathTest, PrimitiveRootTest\"\
    :\n  for i in 0..<1000:\n    let x = int32.high.int - i\n    if not is_prime_constexpr(x):\
    \ continue\n    check is_primitive_root(x, (primitive_root_constexpr(x)))\n"
  dependsOn:
  - atcoder/internal_math.nim
  - atcoder/math.nim
  - atcoder/internal_math.nim
  - atcoder/math.nim
  isVerificationFile: false
  path: tests/test_internal_math.nim
  requiredBy: []
  timestamp: '2020-09-25 22:39:15+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_internal_math.nim
layout: document
redirect_from:
- /library/tests/test_internal_math.nim
- /library/tests/test_internal_math.nim.html
title: tests/test_internal_math.nim
---
