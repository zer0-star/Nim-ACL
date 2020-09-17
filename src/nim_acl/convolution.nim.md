---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_math.nim
    title: src/nim_acl/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_bit.nim
    title: src/nim_acl/internal_bit.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/modint.nim
    title: src/nim_acl/modint.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_math.nim
    title: src/nim_acl/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/modint.nim
    title: src/nim_acl/modint.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/internal_bit.nim
    title: src/nim_acl/internal_bit.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/convolution_test.nim
    title: verify/convolution_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/convolution_test.nim
    title: verify/convolution_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_CONVOLUTION_HPP:\n  const ATCODER_CONVOLUTION_HPP\
    \ = 1\n\n#include <algorithm>\n#include <array>\n#include <atcoder/internal_bit>\n\
    #include <atcoder/modint>\n#include <cassert>\n#include <type_traits>\n#include\
    \ <vector>\n  import std/math\n  import src/nim_acl/internal_math, src/nim_acl/internal_bit,\
    \ src/nim_acl/modint\n  \n#  template <class mint, internal::is_static_modint_t<mint>*\
    \ = nullptr>\n  proc butterfly*[mint:StaticModInt](a:var seq[mint]) =\n    const\
    \ g = primitive_root[mint.M]()\n    let\n      n = a.len\n      h = ceil_pow2(n)\n\
    \    \n    var \n      first {.global.} = true\n      sum_e {.global.} :array[30,\
    \ mint]   # sum_e[i] = ies[0] * ... * ies[i - 1] * es[i]\n    if first:\n    \
    \  first = false\n      var es, ies:array[30, mint] # es[i]^(2^(2+i)) == 1\n \
    \     let cnt2 = bsf(mint.M - 1)\n      var\n        e = mint(g).pow((mint.M -\
    \ 1) shr cnt2)\n        ie = e.inv()\n      for i in countdown(cnt2, 2):\n   \
    \     # e^(2^i) == 1\n        es[i - 2] = e\n        ies[i - 2] = ie\n       \
    \ e *= e\n        ie *= ie\n      var now = mint(1)\n      for i in 0..<cnt2 -\
    \ 2:\n        sum_e[i] = es[i] * now\n        now *= ies[i]\n    for ph in 1..h:\n\
    \      let\n        w = 1 shl (ph - 1)\n        p = 1 shl (h - ph)\n      var\
    \ now = mint(1)\n      for s in 0..<w:\n        let offset = s shl (h - ph + 1)\n\
    \        for i in 0..<p:\n          let\n            l = a[i + offset]\n     \
    \       r = a[i + offset + p] * now\n          a[i + offset] = l + r\n       \
    \   a[i + offset + p] = l - r\n        now *= sum_e[bsf(not s.uint)]\n  \n  proc\
    \ butterfly_inv*[mint:StaticModInt](a:var seq[mint]) =\n    const g = primitive_root[mint.M]()\n\
    \    let\n      n = a.len\n      h = ceil_pow2(n)\n    var\n      first{.global.}\
    \ = true\n      sum_ie{.global.}:array[30, mint]  # sum_ie[i] = es[0] * ... *\
    \ es[i - 1] * ies[i]\n    if first:\n      first = false\n      var es, ies: array[30,\
    \ mint] # es[i]^(2^(2+i)) == 1\n      let cnt2 = bsf(mint.M - 1)\n      var\n\
    \        e = mint(g).pow((mint.M - 1) shr cnt2)\n        ie = e.inv()\n      for\
    \ i in countdown(cnt2, 2):\n        # e^(2^i) == 1\n        es[i - 2] = e\n  \
    \      ies[i - 2] = ie\n        e *= e\n        ie *= ie\n      var now = mint(1)\n\
    \      for i in 0..<cnt2 - 2:\n        sum_ie[i] = ies[i] * now\n        now *=\
    \ es[i]\n  \n    for ph in countdown(h, 1):\n      let\n        w = 1 shl (ph\
    \ - 1)\n        p = 1 shl (h - ph)\n      var inow = mint(1)\n      for s in 0..<w:\n\
    \        let offset = s shl (h - ph + 1)\n        for i in 0..<p:\n          let\n\
    \            l = a[i + offset]\n            r = a[i + offset + p]\n          a[i\
    \ + offset] = l + r\n          a[i + offset + p] = mint.init((mint.umod.uint +\
    \ l.uint - r.uint) * uint(inow))\n        inow *= sum_ie[bsf(not s.uint)]\n\n\
    #  template <class mint, internal::is_static_modint_t<mint>* = nullptr>\n  proc\
    \ convolution*[mint:StaticModInt](a, b:seq[mint]):seq[mint] =\n    var\n     \
    \ n = a.len\n      m = b.len\n    if n == 0 or m == 0: return newSeq[mint]()\n\
    \    var (a, b) = (a, b)\n    if min(n, m) <= 60:\n      if n < m:\n        swap(n,\
    \ m)\n        swap(a, b)\n      var ans = newSeq[mint](n + m - 1)\n      for i\
    \ in 0..<n:\n        for j in 0..<m:\n          ans[i + j] += a[i] * b[j]\n  \
    \    return ans\n    let z = 1 shl ceil_pow2(n + m - 1)\n    a.setlen(z)\n   \
    \ butterfly(a)\n    b.setlen(z)\n    butterfly(b);\n    for i in 0..<z:\n    \
    \  a[i] *= b[i]\n    butterfly_inv(a)\n    a.setlen(n + m - 1)\n    let iz = mint(z).inv()\n\
    \    for i in 0..<n+m-1: a[i] *= iz\n    return a\n  \n#  template <unsigned int\
    \ mod = 998244353,\n#      class T,\n#      std::enable_if_t<internal::is_integral<T>::value>*\
    \ = nullptr>\n  proc convolution*[M:static[uint] = 998244353, T:SomeInteger](a,\
    \ b:seq[T]):seq[T] =\n    let (n, m) = (a.len, b.len)\n    if n == 0 or m == 0:\
    \ return newSeq[T]()\n  \n    type mint = StaticModInt[M.int]\n    var\n     \
    \ a2 = newSeq[mint](n)\n      b2 = newSeq[mint](m)\n    for i in 0..<n:\n    \
    \  a2[i] = mint(a[i])\n    for i in 0..<m:\n      b2[i] = mint(b[i])\n#    let\
    \ c2 = convolution(move(a2), move(b2))\n    let c2 = convolution(a2, b2)\n   \
    \ var c = newSeq[T](n + m - 1)\n    for i in 0..<n + m - 1:\n      c[i] = c2[i].val()\n\
    \    return c\n  proc convolution_ll*(a, b:seq[int]):seq[int] =\n    let (n, m)\
    \ = (a.len, b.len)\n    if n == 0 or m == 0: return newSeq[int]()\n    const\n\
    \      MOD1:uint = 754974721  # 2^24\n      MOD2:uint = 167772161  # 2^25\n  \
    \    MOD3:uint = 469762049  # 2^26\n      M2M3 = MOD2 * MOD3\n      M1M3 = MOD1\
    \ * MOD3\n      M1M2 = MOD1 * MOD2\n      M1M2M3 = MOD1 * MOD2 * MOD3\n\n    \
    \  i1 = inv_gcd((MOD2 * MOD3).int, MOD1.int)[1].uint\n      i2 = inv_gcd((MOD1\
    \ * MOD3).int, MOD2.int)[1].uint\n      i3 = inv_gcd((MOD1 * MOD2).int, MOD3.int)[1].uint\n\
    \    \n    let\n      c1 = convolution[MOD1,int](a, b)\n      c2 = convolution[MOD2,int](a,\
    \ b)\n      c3 = convolution[MOD3,int](a, b)\n  \n    var c = newSeq[int](n +\
    \ m - 1)\n    for i in 0..<n + m - 1:\n      var x = 0.uint\n      x += (c1[i].uint\
    \ * i1) mod MOD1 * M2M3\n      x += (c2[i].uint * i2) mod MOD2 * M1M3\n      x\
    \ += (c3[i].uint * i3) mod MOD3 * M1M2\n      # B = 2^63, -B <= x, r(real value)\
    \ < B\n      # (x, x - M, x - 2M, or x - 3M) = r (mod 2B)\n      # r = c1[i] (mod\
    \ MOD1)\n      # focus on MOD1\n      # r = x, x - M', x - 2M', x - 3M' (M' =\
    \ M % 2^64) (mod 2B)\n      # r = x,\n      #   x - M' + (0 or 2B),\n      # \
    \  x - 2M' + (0, 2B or 4B),\n      #   x - 3M' + (0, 2B, 4B or 6B) (without mod!)\n\
    \      # (r - x) = 0, (0)\n      #       - M' + (0 or 2B), (1)\n      #      \
    \ -2M' + (0 or 2B or 4B), (2)\n      #       -3M' + (0 or 2B or 4B or 6B) (3)\
    \ (mod MOD1)\n      # we checked that\n      #   ((1) mod MOD1) mod 5 = 2\n  \
    \    #   ((2) mod MOD1) mod 5 = 3\n      #   ((3) mod MOD1) mod 5 = 4\n      var\
    \ diff = c1[i] - floorMod(x.int, MOD1.int)\n      if diff < 0: diff += MOD1.int\n\
    \      const offset = [0'u, 0'u, M1M2M3, 2'u * M1M2M3, 3'u * M1M2M3]\n      x\
    \ -= offset[diff mod 5]\n      c[i] = x.int\n    return c\n"
  dependsOn:
  - src/nim_acl/internal_math.nim
  - src/nim_acl/internal_bit.nim
  - src/nim_acl/modint.nim
  - src/nim_acl/internal_math.nim
  - src/nim_acl/modint.nim
  - src/nim_acl/internal_bit.nim
  isVerificationFile: false
  path: src/nim_acl/convolution.nim
  requiredBy: []
  timestamp: '2020-09-17 20:03:53+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/convolution_test.nim
  - verify/convolution_test.nim
documentation_of: src/nim_acl/convolution.nim
layout: document
redirect_from:
- /library/src/nim_acl/convolution.nim
- /library/src/nim_acl/convolution.nim.html
title: src/nim_acl/convolution.nim
---
