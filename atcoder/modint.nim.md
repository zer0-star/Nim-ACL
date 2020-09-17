---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
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
  code: "when not defined ATCODER_MODINT_HPP:\n  const ATCODER_MODINT_HPP* = 1\n\n\
    \  type\n    StaticModInt*[M: static[int]] = distinct uint32\n  type\n    DynamicModInt*[T:\
    \ static[int]] = distinct uint32\n  \n  type ModInt = StaticModInt or DynamicModInt\n\
    \n  import atcoder/internal_math\n\n  proc getBarrett*[T:static[int]](t:typedesc[DynamicModInt[T]],\
    \ set = false, M:SomeInteger = 0.uint32):ptr Barrett =\n    var Barrett_of_DynamicModInt\
    \ {.global.} :Barrett\n    return Barrett_of_DynamicModInt.addr\n  proc getMod*[T:static[int]](t:typedesc[DynamicModInt[T]]):uint32\
    \ {.inline.} =\n    (t.getBarrett)[].m.uint32\n  proc setMod*[T:static[int]](t:typedesc[DynamicModInt[T]],\
    \ M:SomeInteger){.used.} =\n    (t.getBarrett)[] = initBarrett(M.uint)\n\n  proc\
    \ `$`*(m: ModInt): string {.inline.} =\n    $m.int\n\n  template umod*[T:ModInt](self:\
    \ typedesc[T]):uint32 =\n    when T is StaticModInt:\n      T.M\n    elif T is\
    \ DynamicModInt:\n      T.getMod()\n    else:\n      static: assert false\n  template\
    \ umod*[T:ModInt](self: T):uint32 = self.type.umod\n\n  proc init*[T:ModInt](t:typedesc[T],\
    \ v: SomeInteger or T): auto {.inline.} =\n    when v is T: return v\n    else:\n\
    \      var v = v.int\n      if 0 <= v:\n        if v < T.umod.int: return T(v.uint32)\n\
    \        else: return T((v mod T.umod.int).uint32)\n      else:\n        v = v\
    \ mod T.umod.int\n        if v < 0: v += T.umod.int\n        return T(v.uint32)\n\
    \  template initModInt*(v: SomeInteger or ModInt; M: static[int] = 1_000_000_007):\
    \ auto =\n    StaticModInt[M].init(v)\n\n# TODO\n#  converter toModInt[M:static[int]](n:SomeInteger):ModInt[M]\
    \ {.inline.}= initModInt(n, M)\n\n  proc initModIntRaw*(v: SomeInteger; M: static[int]\
    \ = 1_000_000_007): auto {.inline.} =\n    ModInt[M](v.uint32)\n\n  proc inv*[T](v:T):T\
    \ {.inline.} =\n    var\n      a = T.init(v).int\n      b = T.umod.int\n     \
    \ u = 1\n      v = 0\n    while b > 0:\n      let t = a div b\n      a -= t *\
    \ b;swap(a, b)\n      u -= t * v;swap(u, v)\n    return T.init(u)\n\n  proc val*(m:\
    \ ModInt): int {.inline.} =\n    int(m)\n\n  proc `-`*[T:ModInt](m: T): T {.inline.}\
    \ =\n    if int(m) == 0: return m\n    else: return T(m.umod() - uint32(m))\n\n\
    \  template generateDefinitions(name, l, r, body: untyped): untyped {.dirty.}\
    \ =\n    proc name*[T:ModInt](l: T; r: T): auto {.inline.} =\n      body\n   \
    \ proc name*[T:ModInt](l: SomeInteger; r: T): auto {.inline.} =\n      body\n\
    \    proc name*[T:ModInt](l: T; r: SomeInteger): auto {.inline.} =\n      body\n\
    \n  proc `+=`*[T:ModInt](m: var T; n: SomeInteger | T) {.inline.} =\n    uint32(m)\
    \ += T.init(n).uint32\n    if uint32(m) >= T.umod: uint32(m) -= T.umod\n\n  proc\
    \ `-=`*[T:ModInt](m: var T; n: SomeInteger | T) {.inline.} =\n    uint32(m) +=\
    \ T.umod - T.init(n).uint32\n    if uint32(m) >= T.umod: uint32(m) -= T.umod\n\
    \n  proc `*=`*[T:ModInt](m: var T; n: SomeInteger | T) {.inline.} =\n    when\
    \ T is StaticModInt:\n      uint32(m) = (uint(m) * T.init(n).uint mod T.umod()).uint32\n\
    \    elif T is DynamicModInt:\n      uint32(m) = T.getBarrett[].mul(uint(m), T.init(n).uint).uint32\n\
    \    else:\n      static: assert false\n\n  proc `/=`*[T:ModInt](m: var T; n:\
    \ SomeInteger | T) {.inline.} =\n    uint32(m) = (uint(m) * T.init(n).inv().uint\
    \ mod T.umod).uint32\n\n  generateDefinitions(`+`, m, n):\n    result = T.init(m)\n\
    \    result += n\n\n  generateDefinitions(`-`, m, n):\n    result = T.init(m)\n\
    \    result -= n\n\n  generateDefinitions(`*`, m, n):\n    result = T.init(m)\n\
    \    result *= n\n\n  generateDefinitions(`/`, m, n):\n    result = T.init(m)\n\
    \    result /= n\n\n  proc `==`*[T:ModInt](m: T; n: SomeInteger | T): bool {.inline.}\
    \ =\n    int(m) == T.init(n).int\n\n  proc inc*[T:ModInt](m: var T) {.inline.}\
    \ =\n    uint32(m).inc\n    if m == T.umod:\n      uint32(m) = 0\n\n  proc dec*[T:ModInt](m:\
    \ var T) {.inline.} =\n    if m == 0:\n      uint32(m) = T.umod - 1\n    else:\n\
    \      uint32(m).dec\n\n  proc pow*[T:ModInt](m: T; p: SomeInteger): T {.inline.}\
    \ =\n    var\n      p = p.int\n      m = m\n    uint32(result) = 1\n    while\
    \ p > 0:\n      if (p and 1) == 1:\n        result *= m\n      m *= m\n      p\
    \ = p shr 1\n\n  type modint998244353* = StaticModInt[998244353]\n  type modint1000000007*\
    \ = StaticModInt[1000000007]\n  type modint* = DynamicModInt[-1]\n"
  dependsOn:
  - atcoder/internal_math.nim
  - atcoder/internal_math.nim
  isVerificationFile: false
  path: atcoder/modint.nim
  requiredBy:
  - atcoder/convolution.nim
  - atcoder/convolution.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/lazy_segtree_test.nim
  - verify/lazy_segtree_test.nim
  - verify/lazy_segtree_dynamicmodint_test.nim
  - verify/lazy_segtree_dynamicmodint_test.nim
  - verify/convolution_test.nim
  - verify/convolution_test.nim
  - verify/modint_test.nim
  - verify/modint_test.nim
  - verify/extra_lazy_segtree_test.nim
  - verify/extra_lazy_segtree_test.nim
documentation_of: atcoder/modint.nim
layout: document
redirect_from:
- /library/atcoder/modint.nim
- /library/atcoder/modint.nim.html
title: atcoder/modint.nim
---