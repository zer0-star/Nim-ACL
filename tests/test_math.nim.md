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
  code: "import unittest\nimport atcoder/math\nimport std/math as math_lib\nimport\
    \ std/algorithm\n\ntype ll = int\ntype ull = uint\n\n#proc gcd(a, b:ll):ll =\n\
    #  assert 0 <= a and 0 <= b\n#  if b == 0: return a\n#  return gcd(b, a mod b)\n\
    \n#ll pow_mod_naive(ll x, ull n, uint32 mod) {\n#  ull y = (x % mod + mod) % mod;\n\
    #  ull z = 1;\n#  for (ull i = 0; i < n; i++) {\n#    z = (z * y) % mod;\n#  }\n\
    #  return z % mod;\n#}\n\nproc floor_sum_naive(n, m, a, b:ll):ll =\n  var sum\
    \ = 0.ll\n  for i in 0..<n:\n    sum += (a * i + b) div m\n  return sum\n\n#bool\
    \ is_prime_naive(ll n) {\n#  assert(0 <= n && n <= std::numeric_limits<int>::max());\n\
    #  if (n == 0 || n == 1) return false;\n#  for (ll i = 2; i * i <= n; i++) {\n\
    #    if (n % i == 0) return false;\n#  }\n#  return true;\n#}\n\ntest \"MathTest,\
    \ PowMod\":\n  proc naive(x, n, m:ll):ll =\n    var\n      y = floorMod(x, m)\n\
    \      z = 1 mod m\n    for i in 0..<n:\n      z = (z * y) mod m\n    return z\n\
    \  for a in -100..100:\n    for b in 0..100:\n      for c in 1..100:\n       \
    \ check naive(a, b, c) == pow_mod(a, b, c)\n\ntest \"MathTest, InvBoundHand\"\
    :\n  let\n    minll = ll.low\n    maxll = ll.high\n  check inv_mod(-1, maxll)\
    \ == inv_mod(minll, maxll)\n  check 1 == inv_mod(maxll, maxll - 1)\n  check maxll\
    \ - 1 == inv_mod(maxll - 1, maxll)\n  check 2 == inv_mod(maxll div 2 + 1, maxll)\n\
    \ntest \"MathTest, InvMod\":\n  for a in -100..100:\n    for b in 1..1000:\n \
    \     if gcd(floorMod(a, b), b) != 1: continue\n      let c = inv_mod(a, b)\n\
    \      check 0 <= c\n      check c < b\n      check 1 mod b == ((a * c) mod b\
    \ + b) mod b\n\ntest \"MathTest, InvModZero\":\n  check 0 == inv_mod(0, 1)\n \
    \ for i in 0..<10:\n    check 0 == inv_mod(i, 1)\n    check 0 == inv_mod(-i, 1)\n\
    \    check 0 == inv_mod(ll.low + i, 1)\n    check 0 == inv_mod(ll.high - i, 1)\n\
    \ntest \"MathTest, FloorSum\":\n  for n in 0..<20:\n    for m in 1..<20:\n   \
    \   for a in 0..<20:\n        for b in 0..<20:\n          check floor_sum_naive(n,\
    \ m, a, b) == floor_sum(n, m, a, b)\n\ntest \"MathTest, CRTHand\":\n  let res\
    \ = crt(@[1, 2, 1], @[2, 3, 2])\n  check 5 == res[0]\n  check 6 == res[1]\n\n\
    test \"MathTest, CRT2\":\n  for a in 1..20:\n    for b in 1..20:\n      for c\
    \ in -10..10:\n        for d in -10..10:\n          let res = crt(@[c, d], @[a,\
    \ b])\n          if res[1] == 0:\n            for x in 0 ..< a * b div gcd(a,\
    \ b):\n              check x mod a != c or x mod b != d\n            continue\n\
    \          check a * b div gcd(a, b) == res[1]\n          check floorMod(c, a)\
    \ == res[0] mod a\n          check floorMod(d, b) == res[0] mod b\n\ntest \"MathTest,\
    \ CRT3\":\n  for a in 1..5:\n    for b in 1..5:\n      for c in 1..5:\n      \
    \  for d in -5..5:\n          for e in -5..5:\n            for f in -5..5:\n \
    \             let res = crt(@[d, e, f], @[a, b, c])\n              var lcm = a\
    \ * b div gcd(a, b)\n              lcm = lcm * c div gcd(lcm, c)\n           \
    \   if res[1] == 0:\n                for x in 0..<lcm:\n                  check\
    \ x mod a != d or x mod b != e or x mod c != f\n                continue\n   \
    \           check lcm == res[1]\n              check floorMod(d, a) == res[0]\
    \ mod a\n              check floorMod(e, b) == res[0] mod b\n              check\
    \ floorMod(f, c) == res[0] mod c\n\ntest \"MathTest, CRTOverflow\":\n  let\n \
    \   r0 = 0\n    r1 = 1_000_000_000_000.int - 2\n    m0 = 900577\n    m1 = 1_000_000_000_000.int\n\
    \  let res = crt(@[r0, r1], @[m0, m1])\n  check m0 * m1 == res[1]\n  check r0\
    \ == res[0] mod m0\n  check r1 == res[0] mod m1\n\ntest \"MathTest, CRTBound\"\
    :\n  let INF = ll.high\n  var pred = newSeq[ll]()\n  for i in 1..10:\n    pred.add(i)\n\
    \    pred.add(INF - (i - 1))\n  pred.add(998244353)\n  pred.add(1_000_000_007)\n\
    \  pred.add(1_000_000_009)\n\n  for (a, b) in [(INF, INF), (1, INF), (INF, 1),\
    \ (7, INF), (INF div 337, 337), (2, (INF - 1) div 2)]:\n    var (a, b) = (a, b)\n\
    \    for ph in 0..<2:\n      for ans in pred:\n        let res = crt(@[ans mod\
    \ a, ans mod b], @[a, b])\n        let lcm = a div gcd(a, b) * b\n        check\
    \ lcm == res[1]\n        check ans mod lcm == res[0]\n      swap(a, b)\n  var\
    \ factor_inf = [49, 73, 127, 337, 92737, 649657]\n  while true:\n    for ans in\
    \ pred:\n      var r, m = newSeq[ll]()\n      for f in factor_inf:\n        r.add(ans\
    \ mod f)\n        m.add(f)\n      let res = crt(r, m)\n      check ans mod INF\
    \ == res[0]\n      check INF == res[1]\n    if not factor_inf.nextPermutation():\
    \ break\n  var factor_infn1 = [2, 3, 715827883, 2147483647]\n  while true:\n \
    \   for ans in pred:\n      var r, m = newSeq[ll]()\n      for f in factor_infn1:\n\
    \        r.add(ans mod f)\n        m.add(f)\n      let res = crt(r, m)\n     \
    \ check ans mod (INF - 1) == res[0]\n      check INF - 1 == res[1]\n    if not\
    \ factor_infn1.nextPermutation(): break\n\n#std::vector<int> factors(int m) {\n\
    #  std::vector<int> result;\n#  for (int i = 2; (ll)(i)*i <= m; i++) {\n#    if\
    \ (m % i == 0) {\n#      result.add(i);\n#      while (m % i == 0) {\n#      \
    \  m /= i;\n#      }\n#    }\n#  }\n#  if (m > 1) result.add(m);\n#  return result;\n\
    #}\n#\n#bool is_primitive_root(int m, int g) {\n#  assert(1 <= g && g < m);\n\
    #  auto prs = factors(m - 1);\n#  for (int x : factors(m - 1)) {\n#    if (internal::pow_mod_constexpr(g,\
    \ (m - 1) / x, m) == 1) return false;\n#  }\n#  return true;\n#}\n#\n#bool is_primitive_root_naive(int\
    \ m, int g) {\n#  assert(1 <= g && g < m);\n#  auto prs = factors(m - 1);\n# \
    \ int x = 1;\n#  for (int i = 1; i <= m - 2; i++) {\n#    x = (int)((long long)(x)*g\
    \ % m);\n#    // x == n^i\n#    if (x == 1) return false;\n#  }\n#  x = (int)((long\
    \ long)(x)*g % m);\n#  assert(x == 1);\n#  return true;\n#}\n"
  dependsOn:
  - atcoder/internal_math.nim
  - atcoder/math.nim
  - atcoder/internal_math.nim
  - atcoder/math.nim
  isVerificationFile: false
  path: tests/test_math.nim
  requiredBy: []
  timestamp: '2020-09-25 22:39:15+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_math.nim
layout: document
redirect_from:
- /library/tests/test_math.nim
- /library/tests/test_math.nim.html
title: tests/test_math.nim
---
