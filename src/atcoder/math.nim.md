---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/crt_test.nim
    title: verify/crt_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/crt_test.nim
    title: verify/crt_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/floor_sum_test.nim
    title: verify/floor_sum_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/floor_sum_test.nim
    title: verify/floor_sum_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_MATH_HPP:\n  const ATCODER_MATH_HPP* = 1\n\n  import\
    \ atcoder/internal_math\n  import std/math as math_lib_of_math\n\n  proc pow_mod*(x,n,m:int):int\
    \ =\n    assert 0 <= n and 1 <= m\n    if m == 1: return 0\n    let bt = initBarrett(m.uint)\n\
    \    var\n      r = 1.uint\n      y = x.floorMod(m).uint\n      n = n\n    while\
    \ n != 0:\n      if (n and 1) != 0: r = bt.mul(r, y)\n      y = bt.mul(y, y)\n\
    \      n = n shr 1\n    return r.int\n  \n  proc inv_mod*(x, m:int):int =\n  \
    \  assert 1 <= m\n    let z = inv_gcd(x, m)\n    assert z[0] == 1\n    return\
    \ z[1]\n  \n  # (rem, mod)\n  proc crt*(r, m:openArray[int]):(int,int) =\n   \
    \ assert r.len == m.len\n    let n = r.len\n    # Contracts: 0 <= r0 < m0\n  \
    \  var (r0, m0) = (0, 1)\n    for i in 0..<n:\n      assert 1 <= m[i]\n      var\n\
    \        r1 = floorMod(r[i], m[i])\n        m1 = m[i]\n      if m0 < m1:\n   \
    \     swap(r0, r1)\n        swap(m0, m1)\n      if m0 mod m1 == 0:\n        if\
    \ r0 mod m1 != r1: return (0, 0)\n        continue\n      #  assume: m0 > m1,\
    \ lcm(m0, m1) >= 2 * max(m0, m1)\n  \n      #  (r0, m0), (r1, m1) -> (r2, m2 =\
    \ lcm(m0, m1));\n      #  r2 % m0 = r0\n      #  r2 % m1 = r1\n      #  -> (r0\
    \ + x*m0) % m1 = r1\n      #  -> x*u0*g % (u1*g) = (r1 - r0) (u0*g = m0, u1*g\
    \ = m1)\n      #  -> x = (r1 - r0) / g * inv(u0) (mod u1)\n  \n      #  im = inv(u0)\
    \ (mod u1) (0 <= im < u1)\n      let\n        (g, im) = inv_gcd(m0, m1)\n    \
    \    u1 = m1 div g\n      # |r1 - r0| < (m0 + m1) <= lcm(m0, m1)\n      if ((r1\
    \ - r0) mod g) != 0: return (0, 0)\n  \n      # u1 * u1 <= m1 * m1 / g / g <=\
    \ m0 * m1 / g = lcm(m0, m1)\n      let x = (r1 - r0) div g mod u1 * im mod u1\n\
    \  \n      # |r0| + |m0 * x|\n      # < m0 + m0 * (u1 - 1)\n      # = m0 + m0\
    \ * m1 / g - m0\n      # = lcm(m0, m1)\n      r0 += x * m0\n      m0 *= u1  #\
    \ -> lcm(m0, m1)\n      if r0 < 0: r0 += m0\n    return (r0, m0)\n\nproc floor_sum*(n,\
    \ m, a, b:int):int =\n  assert n in 0..<(1 shl 32)\n  assert m in 1..<(1 shl 32)\n\
    \  var (a, b) = (a, b)\n  var ans = 0.uint\n  if a < 0:\n    var a2:uint = floorMod(a,\
    \ m).uint\n    ans -= n.uint * (n - 1).uint div 2 * ((a2 - a.uint) div m.uint)\n\
    \    a = a2.int\n  if b < 0:\n    var b2:uint = floorMod(b, m).uint\n    ans -=\
    \ n.uint * ((b2 - b.uint) div m.uint)\n    b = b2.int\n  return cast[int](ans\
    \ + floor_sum_unsigned(n.uint, m.uint, a.uint, b.uint))\n"
  dependsOn:
  - atcoder/internal_math.nim
  - atcoder/internal_math.nim
  isVerificationFile: false
  path: atcoder/math.nim
  requiredBy: []
  timestamp: '2021-08-23 20:29:05+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/floor_sum_test.nim
  - verify/floor_sum_test.nim
  - verify/crt_test.nim
  - verify/crt_test.nim
documentation_of: atcoder/math.nim
layout: document
redirect_from:
- /library/atcoder/math.nim
- /library/atcoder/math.nim.html
title: atcoder/math.nim
---
