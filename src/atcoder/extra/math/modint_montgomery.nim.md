---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/math/convolution_montgomery_test.nim
    title: verify/extra/math/convolution_montgomery_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/math/convolution_montgomery_test.nim
    title: verify/extra/math/convolution_montgomery_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_MONTGOMERY_MODINT_HPP:\n  const ATCODER_MONTGOMERY_MODINT_HPP*\
    \ = 1\n\n  import std/macros\n  import atcoder/generate_definitions\n\n  type\
    \ StaticLazyMontgomeryModInt*[M:static[uint32]] = object\n    a:uint32\n  type\
    \ DynamicLazyMontgomeryModInt*[T:static[int]] = object\n    a:uint32\n  type LazyMontgomeryModInt\
    \ = StaticLazyMontgomeryModInt or DynamicLazyMontgomeryModInt\n\n  proc isStaticModInt*(T:typedesc[LazyMontgomeryModInt]):bool\
    \ = T is StaticLazyMontgomeryModInt\n  proc isDynamicModInt*(T:typedesc[LazyMontgomeryModInt]):bool\
    \ = T is DynamicLazyMontgomeryModInt\n  #proc isModInt*(T:typedesc):bool = T.isStaticModInt\
    \ or T.isDynamicModInt\n  proc isStatic*(T:typedesc[LazyMontgomeryModInt]):bool\
    \ = T is StaticLazyMontgomeryModInt\n\n  proc get_r*(M:uint32):auto =\n    result\
    \ = M\n    for i in 0..<4: result *= 2.uint32 - M * result\n  proc get_n2*(M:uint32):auto\
    \ = (((not M.uint) + 1.uint) mod M.uint).uint32\n\n  proc getMontgomeryParameters(M:uint32):tuple[M,\
    \ r, n2:uint32] =\n    (M, get_r(M), get_n2(M))\n\n  proc getParameters*[T:static[int]](t:typedesc[DynamicLazyMontgomeryModInt[T]]):ptr[tuple[M,\
    \ r, n2:uint32]] =\n    var p {.global.} : tuple[M, r, n2:uint32] = getMontgomeryParameters(998244353.uint32)\n\
    \    return p.addr\n\n  proc checkParameters(M, r:uint32) =\n    assert r * M\
    \ == 1, \"invalid, r * mod != 1\"\n    assert M < (1 shl 30), \"invalid, mod >=\
    \ 2 ^ 30\"\n    assert (M and 1) == 1, \"invalid, mod % 2 == 0\"\n\n  proc setMod*[T:static[int]](self:typedesc[DynamicLazyMontgomeryModInt[T]],\
    \ M:SomeInteger) =\n    let p = getMontgomeryParameters(M.uint32)\n    checkParameters(p.M,\
    \ p.r)\n    (self.getParameters)[] = p\n\n  template getMod*[T:StaticLazyMontgomeryModInt](self:T\
    \ or typedesc[T]):uint32 = T.M.uint32\n  template getMod*[T:static[int]](self:typedesc[DynamicLazyMontgomeryModInt[T]]\
    \ or DynamicLazyMontgomeryModInt[T]):uint32 =\n    (DynamicLazyMontgomeryModInt[T].getParameters)[].M.uint32\n\
    \  template `mod`*[T:LazyMontgomeryModInt](self:T or typedesc[T]):int = T.get_mod.int\n\
    \n  template reduce(T:typedesc[LazyMontgomeryModInt], b:uint):uint32 =\n    when\
    \ T is StaticLazyMontgomeryModInt:\n      const M = T.get_mod\n      const r =\
    \ get_r(M)\n      static:\n        checkParameters(M, r)\n      ((b + (cast[uint32](b)\
    \ * ((not r) + 1.uint32)).uint * M.uint) shr 32).uint32\n    elif T is DynamicLazyMontgomeryModInt:\n\
    \      let p = (T.getParameters)[]\n      ((b + (cast[uint32](b) * ((not p.r)\
    \ + 1.uint32)).uint * p.M.uint) shr 32).uint32\n    else:\n      assert false,\
    \ \"no such lazy montgomerymodint\"\n\n  proc init*[T:LazyMontgomeryModInt](t:typedesc[T],\
    \ b:T or SomeInteger):auto {.inline.} =\n    when b is LazyMontgomeryModInt: return\
    \ b\n    else:\n      when b is SomeUnsignedInt:\n        let b = (b.uint mod\
    \ T.get_mod.uint).int\n      when T is StaticLazyMontgomeryModInt:\n        const\
    \ n2 = get_n2(T.get_mod)\n        return T(a:T.reduce((b.int mod T.get_mod.int\
    \ + T.get_mod.int).uint * n2))\n      elif T is DynamicLazyMontgomeryModInt:\n\
    \        let p = (T.getParameters)[]\n        return T(a:T.reduce((b.int mod p.M.int\
    \ + p.M.int).uint * p.n2))\n  proc unit*[T:LazyMontgomeryModInt](t:typedesc[T]\
    \ or T):T = T.init(1)\n\n  proc val*[T:LazyMontgomeryModInt](self: T):int =\n\
    \    var a = T.reduce(self.a.uint)\n    if a >= T.get_mod: a -= T.get_mod\n  \
    \  return a.int\n\n  proc `+=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable,\
    \ inline.} =\n    self.a += b.a - 2.uint32 * T.get_mod\n    if cast[int32](self.a)\
    \ < 0.int32: self.a += 2.uint32 * T.get_mod\n    return self\n\n  proc `-=`*[T:LazyMontgomeryModInt](self:\
    \ var T, b:T):T {.discardable, inline.} =\n    self.a -= b.a\n    if cast[int32](self.a)\
    \ < 0.int32: self.a += 2.uint32 * T.get_mod\n    return self\n\n  proc inc*[T:LazyMontgomeryModInt](self:\
    \ var T):T {.discardable, inline.} =\n    return self += 1\n  proc dec*[T:LazyMontgomeryModInt](self:\
    \ var T):T {.discardable, inline.} =\n    return self -= 1\n\n  proc `*=`*[T:LazyMontgomeryModInt](self:\
    \ var T, b:T):T {.discardable, inline.} =\n    self.a = T.reduce(self.a.uint *\
    \ b.a.uint)\n    return self\n\n  generatePow(LazyMontgomeryModInt)\n\n  proc\
    \ inv*[T:LazyMontgomeryModInt](self: T):T = self.pow(T.mod - 2)\n\n  proc `/=`*[T:LazyMontgomeryModInt](self:\
    \ var T, b:T):T {.discardable, inline.} =\n    self *= b.inv()\n    return self\n\
    \n  generateDefinitions(`+`, m, n, LazyMontgomeryModInt, SomeInteger):\n    result\
    \ = T.init(m)\n    result += T.init(n)\n\n  generateDefinitions(`-`, m, n, LazyMontgomeryModInt,\
    \ SomeInteger):\n    result = T.init(m)\n    result -= T.init(n)\n\n  generateDefinitions(`*`,\
    \ m, n, LazyMontgomeryModInt, SomeInteger):\n    result = T.init(m)\n    result\
    \ *= T.init(n)\n\n  generateDefinitions(`/`, m, n, LazyMontgomeryModInt, SomeInteger):\n\
    \    result = T.init(m)\n    result /= T.init(n)\n\n  generateDefinitions(`==`,\
    \ m, n, LazyMontgomeryModInt, SomeInteger):\n    result = (T.init(m).val() ==\
    \ T.init(n).val())\n\n  proc `$`*(m: LazyMontgomeryModInt): string {.inline.}\
    \ = $(m.val())\n  proc `-`*[T:LazyMontgomeryModInt](self:T):T = T.init(0) - self\n\
    \n  template useStaticMontgomery*(name, M) =\n    generateConverter(name, int,\
    \ StaticLazyMontgomeryModInt[M])\n  template useDynamicMontgomery*(name, M) =\n\
    \    generateConverter(name, int, DynamicLazyMontgomeryModInt[M])\n\n  useStaticMontgomery(modint_montgomery_998244353,\
    \ 998244353)\n  useStaticMontgomery(modint_montgomery_1000000007, 1000000007)\n\
    \  useDynamicMontgomery(modint_montgomery, -1)\n"
  dependsOn:
  - atcoder/generate_definitions.nim
  - atcoder/generate_definitions.nim
  - atcoder/generate_definitions.nim
  - atcoder/generate_definitions.nim
  isVerificationFile: false
  path: atcoder/extra/math/modint_montgomery.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/math/convolution_montgomery_test.nim
  - verify/extra/math/convolution_montgomery_test.nim
documentation_of: atcoder/extra/math/modint_montgomery.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/modint_montgomery.nim
- /library/atcoder/extra/math/modint_montgomery.nim.html
title: atcoder/extra/math/modint_montgomery.nim
---
