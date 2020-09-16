---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not defined ATCODER_MODINT_HPP:\n  const ATCODER_MODINT_HPP* = 1\n\n\
    \  type\n    ModInt*[M: static[int]] = distinct uint32\n\n  proc `$`*[M: static[int]](m:\
    \ ModInt[M]): string {.inline.} =\n    $m.int\n\n  #proc modulo*(x, y: int): int\
    \ {.inline.} =\n  #  ## requires: y > 0\n  #  assert y > 0\n  #  if x < 0:\n \
    \ #    let tmp = (-x) mod y\n  #    if tmp == 0:\n  #      0\n  #    else:\n \
    \ #      y - tmp\n  #  else:\n  #    x mod y\n\n  #proc extgcd*(x, y: int): (int,\
    \ int) {.inline.} =\n  #  var\n  #    a = x\n  #    p = y\n  #    b, r = 1\n \
    \ #    c, q = 0\n  #  while a mod p != 0:\n# #   while a.modulo(p) != 0:\n  #\
    \    let t = a div p\n  #    a -= p * t\n  #    b -= q * t\n  #    c -= r * t\n\
    \  #    swap(a, p)\n  #    swap(b, q)\n  #    swap(c, r)\n  #  (q, r)\n\n  proc\
    \ initModInt*(v: SomeInteger or ModInt; M: static[int] = 1_000_000_007): ModInt[M]\
    \ {.inline.} =\n    when v is ModInt: return v\n    else:\n      if 0 <= v:\n\
    \        if v < M: return ModInt[M](v.uint32)\n        else: return ModInt[M]((v\
    \ mod M).uint32)\n      else:\n        var v = v mod M\n        if v < 0: v +=\
    \ M\n        return ModInt[M](v.uint32)\n#  converter toModInt[M:static[int]](n:SomeInteger):ModInt[M]\
    \ {.inline.}= initModInt(n, M)\n\n  proc initModIntRaw*(v: SomeInteger; M: static[int]\
    \ = 1_000_000_007): ModInt[M] {.inline.} =\n    ModInt[M](v.uint32)\n\n  proc\
    \ inv[M:static[int]](v:ModInt[M]):ModInt[M] {.inline.} =\n    var\n      a = initModInt(v,\
    \ M).int\n      b = M\n      u = 1\n      v = 0\n    while b > 0:\n      let t\
    \ = a div b\n      a -= t * b;swap(a, b)\n      u -= t * v;swap(u, v)\n    return\
    \ initModInt(u, M)\n\n#  proc retake*[M: static[int]](m: var ModInt[M]) {.inline.}\
    \ =\n#    int(m) = int(m).modulo(M)\n\n  proc val*[M: static[int]](m: ModInt[M]):\
    \ int {.inline.} =\n    int(m)\n\n  proc modulo*[M: static[int]](m: ModInt[M]):\
    \ int {.inline.} =\n    M\n\n  proc `-`*[M: static[int]](m: ModInt[M]): ModInt[M]\
    \ {.inline.} =\n    if int(m) == 0: return m\n    else: return ModInt[M](M - int(m))\n\
    \n  template generateDefinitions(name, l, r, retType, body: untyped): untyped\
    \ {.dirty.} =\n    proc name*[M: static[int]](l: ModInt[M]; r: ModInt[M]): retType\
    \ {.inline.} =\n      body\n    proc name*[M: static[int]](l: SomeInteger; r:\
    \ ModInt[M]): retType {.inline.} =\n      body\n    proc name*[M: static[int]](l:\
    \ ModInt[M]; r: SomeInteger): retType {.inline.} =\n      body\n\n#  proc inv*[M:\
    \ static[int]](m: ModInt[M]): ModInt[M] {.inline.} =\n#    result = initModInt(extgcd(M,\
    \ int(m))[1], M)\n\n  proc `+=`*[M: static[int]](m: var ModInt[M]; n: SomeInteger\
    \ | ModInt[M]) {.inline.} =\n    uint32(m) += initModInt(n, M).uint32\n    if\
    \ uint32(m) >= M.uint32: uint32(m) -= M.uint32\n\n  proc `-=`*[M: static[int]](m:\
    \ var ModInt[M]; n: SomeInteger | ModInt[M]) {.inline.} =\n    uint32(m) += M.uint32\
    \ - initModInt(n, M).uint32\n    if uint32(m) >= M.uint32: uint32(m) -= M.uint32\n\
    \n  proc `*=`*[M: static[int]](m: var ModInt[M]; n: SomeInteger | ModInt[M]) {.inline.}\
    \ =\n    uint32(m) = (int(m) * initModInt(n, M).int mod M).uint32\n#    m.retake()\n\
    \n  proc `/=`*[M: static[int]](m: var ModInt[M]; n: SomeInteger | ModInt[M]) {.inline.}\
    \ =\n    uint32(m) = (int(m) * initModInt(n, M).inv().int mod M).uint32\n#   \
    \ m.retake()\n\n  generateDefinitions(`+`, m, n, ModInt[M]):\n    result = initModInt(m,\
    \ M)\n    result += n\n\n  generateDefinitions(`-`, m, n, ModInt[M]):\n    result\
    \ = initModInt(m, M)\n    result -= n\n\n  generateDefinitions(`*`, m, n, ModInt[M]):\n\
    \    result = initModInt(m, M)\n    result *= n\n\n  generateDefinitions(`/`,\
    \ m, n, ModInt[M]):\n    result = initModInt(m, M)\n    result /= n\n\n  proc\
    \ `==`*[M: static[int]](m: ModInt[M]; n: SomeInteger | ModInt[M]): bool {.inline.}\
    \ =\n    int(m) == initModInt(n, M).int\n\n  proc inc*[M: static[int]](m: var\
    \ ModInt[M]) {.inline.} =\n    uint32(m).inc\n    if m == M:\n      uint32(m)\
    \ = 0\n\n  proc dec*[M: static[int]](m: var ModInt[M]) {.inline.} =\n    if m\
    \ == 0:\n      uint32(m) = M - 1\n    else:\n      uint32(m).dec\n\n  proc pow*[M:\
    \ static[int]](m: ModInt[M]; p: SomeInteger): ModInt[M] {.inline.} =\n    var\n\
    \      p = p.int\n      m = m\n    uint32(result) = 1\n    while p > 0:\n    \
    \  if (p and 1) == 1:\n        result *= m\n      m *= m\n      p = p shr 1\n"
  dependsOn: []
  isVerificationFile: false
  path: src/nim_acl/modint_unsigned.nim
  requiredBy: []
  timestamp: '2020-09-16 18:22:00+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/nim_acl/modint_unsigned.nim
layout: document
redirect_from:
- /library/src/nim_acl/modint_unsigned.nim
- /library/src/nim_acl/modint_unsigned.nim.html
title: src/nim_acl/modint_unsigned.nim
---
