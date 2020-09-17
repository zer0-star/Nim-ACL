---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/math.nim
    title: atcoder/math.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/math.nim
    title: atcoder/math.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_test.nim
    title: verify/lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_test.nim
    title: verify/lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_dynamicmodint_test.nim
    title: verify/lazy_segtree_dynamicmodint_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_dynamicmodint_test.nim
    title: verify/lazy_segtree_dynamicmodint_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/convolution_test.nim
    title: verify/convolution_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/convolution_test.nim
    title: verify/convolution_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/floor_sum_test.nim
    title: verify/floor_sum_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/floor_sum_test.nim
    title: verify/floor_sum_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/modint_test.nim
    title: verify/modint_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/modint_test.nim
    title: verify/modint_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra_lazy_segtree_test.nim
    title: verify/extra_lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra_lazy_segtree_test.nim
    title: verify/extra_lazy_segtree_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_INTERNAL_MATH_HPP:\n  const ATCODER_INTERNAL_MATH_HPP*\
    \ = 1\n  import std/math\n\n  # Fast moduler by barrett reduction\n  # Reference:\
    \ https:#en.wikipedia.org/wiki/Barrett_reduction\n  # NOTE: reconsider after Ice\
    \ Lake\n  type Barrett* = object\n    m*, im:uint\n\n  # @param m `1 <= m`\n \
    \ proc initBarrett*(m:uint):auto = Barrett(m:m, im:(0'u - 1'u) div m + 1)\n\n\
    \  # @return m\n  proc umod*(self: Barrett):uint =\n    self.m\n\n  {.emit: \"\
    \"\"\ninline unsigned long long calc_mul(const unsigned long long &a, const unsigned\
    \ long long &b){\n  return (unsigned long long)(((unsigned __int128)(a)*b) >>\
    \ 64);\n}\n\"\"\".}\n  proc calc_mul*(a,b:culonglong):culonglong {.importcpp:\
    \ \"calc_mul(#,#)\", nodecl.}\n  # @param a `0 <= a < m`\n  # @param b `0 <= b\
    \ < m`\n  # @return `a * b % m`\n  proc mul*(self: Barrett, a:uint, b:uint):uint\
    \ =\n    # [1] m = 1\n    # a = b = im = 0, so okay\n\n    # [2] m >= 2\n    #\
    \ im = ceil(2^64 / m)\n    # -> im * m = 2^64 + r (0 <= r < m)\n    # let z =\
    \ a*b = c*m + d (0 <= c, d < m)\n    # a*b * im = (c*m + d) * im = c*(im*m) +\
    \ d*im = c*2^64 + c*r + d*im\n    # c*r + d*im < m * m + m * im < m * m + 2^64\
    \ + m <= 2^64 + m * (m + 1) < 2^64 * 2\n    # ((ab * im) >> 64) == c or c + 1\n\
    \    let z = a * b\n    #  #ifdef _MSC_VER\n    #      unsigned long long x;\n\
    \    #      _umul128(z, im, &x);\n    #  #else\n    ##TODO\n    #      unsigned\
    \ long long x =\n    #        (unsigned long long)(((unsigned __int128)(z)*im)\
    \ >> 64);\n    #  #endif\n    let x = calc_mul(z.culonglong, self.im.culonglong).uint\n\
    \    var v = z - x * self.m\n    if self.m <= v: v += self.m\n    return v\n\n\
    \  # @param n `0 <= n`\n  # @param m `1 <= m`\n  # @return `(x ** n) % m`\n  proc\
    \ pow_mod_constexpr*(x,n,m:int):int {.compileTime.} =\n    if m == 1: return 0\n\
    \    var\n      r = 1\n      y = floorMod(x, m)\n      n = n\n    while n != 0:\n\
    \      if (n and 1) != 0: r = (r * y) mod m\n      y = (y * y) mod m\n      n\
    \ = n shr 1\n    return r.int\n  \n  # Reference:\n  # M. Forisek and J. Jancina,\n\
    \  # Fast Primality Testing for Integers That Fit into a Machine Word\n  # @param\
    \ n `0 <= n`\n  proc is_prime_constexpr*(n:int):bool {.compileTime.} =\n    if\
    \ n <= 1: return false\n    if n == 2 or n == 7 or n == 61: return true\n    if\
    \ n mod 2 == 0: return false\n    var d = n - 1\n    while d mod 2 == 0: d = d\
    \ div 2\n    for a in [2, 7, 61]:\n      var\n        t = d\n        y = pow_mod_constexpr(a,\
    \ t, n)\n      while t != n - 1 and y != 1 and y != n - 1:\n        y = y * y\
    \ mod n\n        t =  t shl 1\n      if y != n - 1 and t mod 2 == 0:\n       \
    \ return false\n    return true\n  proc is_prime*[n:static[int]]():bool {.compileTime.}\
    \ = is_prime_constexpr(n)\n#  \n#  # @param b `1 <= b`\n#  # @return pair(g, x)\
    \ s.t. g = gcd(a, b), xa = g (mod b), 0 <= x < b/g\n  proc inv_gcd*(a, b:int):(int,int)\
    \ {.compileTime} =\n    var a = floorMod(a, b)\n    if a == 0: return (b, 0)\n\
    \  \n    # Contracts:\n    # [1] s - m0 * a = 0 (mod b)\n    # [2] t - m1 * a\
    \ = 0 (mod b)\n    # [3] s * |m1| + t * |m0| <= b\n    var\n      s = b\n    \
    \  t = a\n      m0 = 0\n      m1 = 1\n  \n    while t != 0:\n      var u = s div\
    \ t\n      s -= t * u;\n      m0 -= m1 * u;  # |m1 * u| <= |m1| * s <= b\n  \n\
    \      # [3]:\n      # (s - t * u) * |m1| + t * |m0 - m1 * u|\n      # <= s *\
    \ |m1| - t * u * |m1| + t * (|m0| + |m1| * u)\n      # = s * |m1| + t * |m0| <=\
    \ b\n  \n      var tmp = s\n      s = t;t = tmp;\n      tmp = m0;m0 = m1;m1 =\
    \ tmp;\n    # by [3]: |m0| <= b/g\n    # by g != b: |m0| < b/g\n    if m0 < 0:\
    \ m0 += b div s\n    return (s, m0)\n\n  # Compile time primitive root\n  # @param\
    \ m must be prime\n  # @return primitive root (and minimum in now)\n  proc primitive_root_constexpr*(m:int):int\
    \ {.compileTime.} =\n    if m == 2: return 1\n    if m == 167772161: return 3\n\
    \    if m == 469762049: return 3\n    if m == 754974721: return 11\n    if m ==\
    \ 998244353: return 3\n    var divs:array[20, int]\n    divs[0] = 2\n    var cnt\
    \ = 1\n    var x = (m - 1) div 2\n    while x mod 2 == 0: x = x div 2\n    var\
    \ i = 3\n    while i * i <= x:\n      if x mod i == 0:\n        divs[cnt] = i\n\
    \        cnt.inc\n        while x mod i == 0:\n          x = x div i\n      i\
    \ += 2\n    if x > 1:\n      divs[cnt] = x\n      cnt.inc\n    var g = 2\n   \
    \ while true:\n      var ok = true\n      for i in 0..<cnt:\n        if pow_mod_constexpr(g,\
    \ (m - 1) div divs[i], m) == 1:\n          ok = false\n          break\n     \
    \ if ok: return g\n      g.inc\n  proc primitive_root*[m:static[int]]():auto {.compileTime.}\
    \ =\n    primitive_root_constexpr(m)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/internal_math.nim
  requiredBy:
  - atcoder/convolution.nim
  - atcoder/convolution.nim
  - atcoder/math.nim
  - atcoder/math.nim
  - atcoder/modint.nim
  - atcoder/modint.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/lazy_segtree_test.nim
  - verify/lazy_segtree_test.nim
  - verify/lazy_segtree_dynamicmodint_test.nim
  - verify/lazy_segtree_dynamicmodint_test.nim
  - verify/convolution_test.nim
  - verify/convolution_test.nim
  - verify/floor_sum_test.nim
  - verify/floor_sum_test.nim
  - verify/modint_test.nim
  - verify/modint_test.nim
  - verify/extra_lazy_segtree_test.nim
  - verify/extra_lazy_segtree_test.nim
documentation_of: atcoder/internal_math.nim
layout: document
redirect_from:
- /library/atcoder/internal_math.nim
- /library/atcoder/internal_math.nim.html
title: atcoder/internal_math.nim
---
