---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_ZETA_TRANSFORM_HPP:\n  const ATCODER_ZETA_TRANSFORM_HPP*\
    \ = 1\n  import std/bitops, std/math\n\n  proc zeta_transform*[T](f:openArray[T],\
    \ subset:static[bool] = false,\n    add:proc(a:var T, b:T):void =\n      proc(a:var\
    \ T, b:T):void =\n        a += b):seq[T] = \n    let n = fastLog2(f.len)\n   \
    \ let N = 2^n\n    doAssert f.len == N\n    result = f.toSeq\n\n    for k in 0..<n:\n\
    \      for s in 0..<N:\n        when not subset:\n          if ((s shr k) and\
    \ 1) == 0:\n            add(result[s], result[s xor (1 shl k)])\n        else:\n\
    \          if ((s shr k) and 1) != 0:\n            add(result[s], result[s xor\
    \ (1 shl k)])\n\n  proc movius_transform*[T](f:openArray[T], subset:static[bool]\
    \ = false,\n    subt:proc(a:var T, b:T):void =\n      proc(a:var T, b:T):void\
    \ =\n        a -= b):seq[T] = \n    let n = fastLog2(f.len)\n    let N = 2^n\n\
    \    doAssert f.len == N\n    result = f.toSeq\n\n    for k in 0..<n:\n      for\
    \ s in 0..<N:\n        when not subset:\n          if ((s shr k) and 1) == 0:\n\
    \            subt(result[s], result[s xor (1 shl k)])\n        else:\n       \
    \   if ((s shr k) and 1) != 0:\n            subt(result[s], result[s xor (1 shl\
    \ k)])\n  proc zeta_superset*[T](f:openArray[T],\n    add:proc(a:var T, b:T):void\
    \ =\n      proc(a:var T, b:T):void =\n        a += b) =\n    zeta_transform[T](f,\
    \ false, add)\n  proc movius_superset*[T](f:openArray[T],\n    subt:proc(a:var\
    \ T, b:T):void =\n      proc(a:var T, b:T):void =\n        a -= b):seq[T] = \n\
    \    movius_transform[T](f, false, subt)\n  proc zeta_subset*[T](f:openArray[T],\n\
    \    add:proc(a:var T, b:T):void =\n      proc(a:var T, b:T):void =\n        a\
    \ += b) =\n    zeta_transform[T](f, true, add)\n  proc movius_subset*[T](f:openArray[T],\n\
    \    subt:proc(a:var T, b:T):void =\n      proc(a:var T, b:T):void =\n       \
    \ a -= b):seq[T] = \n    movius_transform[T](f, true)\n\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/zeta_transform.nim
  requiredBy: []
  timestamp: '2021-08-27 01:32:26+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/zeta_transform.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/zeta_transform.nim
- /library/atcoder/extra/math/zeta_transform.nim.html
title: atcoder/extra/math/zeta_transform.nim
---
