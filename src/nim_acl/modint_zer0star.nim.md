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
    \  type\n    ModInt*[M: static[int]] = distinct int\n\n  proc `$`*[M: static[int]](m:\
    \ ModInt[M]): string {.inline.} =\n    $m.int\n\n  proc modulo*(x, y: int): int\
    \ {.inline.} =\n    ## requires: y > 0\n    assert y > 0\n    if x < 0:\n    \
    \  let tmp = (-x) mod y\n      if tmp == 0:\n        0\n      else:\n        y\
    \ - tmp\n    else:\n      x mod y\n\n  proc extgcd*(x, y: int): (int, int) {.inline.}\
    \ =\n    var\n      a = x\n      p = y\n      b, r = 1\n      c, q = 0\n    while\
    \ a.modulo(p) != 0:\n      let t = a div p\n      a -= p * t\n      b -= q * t\n\
    \      c -= r * t\n      swap(a, p)\n      swap(b, q)\n      swap(c, r)\n    (q,\
    \ r)\n\n  proc initModInt*(v: int = 0; M: static[int] = 1_000_000_007): ModInt[M]\
    \ {.inline.} =\n    ModInt[M](v.modulo(M))\n\n  proc initModIntRaw*(v: int = 0;\
    \ M: static[int] = 1_000_000_007): ModInt[M] {.inline.} =\n    ModInt[M](v)\n\n\
    \  proc retake*[M: static[int]](m: var ModInt[M]) {.inline.} =\n    int(m) = int(m).modulo(M)\n\
    \n  proc val*[M: static[int]](m: ModInt[M]): int {.inline.} =\n    int(m)\n\n\
    \  proc modulo*[M: static[int]](m: ModInt[M]): int {.inline.} =\n    M\n\n  proc\
    \ `-`*[M: static[int]](m: ModInt[M]): ModInt[M] {.inline.} =\n    ModInt[M](M\
    \ - int(m))\n\n  template generateDefinitions(name, l, r, retType, body: untyped):\
    \ untyped =\n    proc name*[M: static[int]](l: ModInt[M]; r: ModInt[M]): retType\
    \ {.inline.} =\n      body\n    proc name*[M: static[int]](l: int; r: ModInt[M]):\
    \ retType {.inline.} =\n      body\n    proc name*[M: static[int]](l: ModInt[M];\
    \ r: int): retType {.inline.} =\n      body\n\n  proc inv*[M: static[int]](m:\
    \ ModInt[M]): ModInt[M] {.inline.} =\n    result = initModInt(extgcd(M, int(m))[1],\
    \ M)\n\n  proc `+=`*[M: static[int]](m: var ModInt[M]; n: int | ModInt[M]) {.inline.}\
    \ =\n    int(m) += int(n)\n    m.retake()\n\n  proc `-=`*[M: static[int]](m: var\
    \ ModInt[M]; n: int | ModInt[M]) {.inline.} =\n    int(m) -= int(n)\n    m.retake()\n\
    \n  proc `*=`*[M: static[int]](m: var ModInt[M]; n: int | ModInt[M]) {.inline.}\
    \ =\n    int(m) *= int(n)\n    m.retake()\n\n  proc `/=`*[M: static[int]](m: var\
    \ ModInt[M]; n: int | ModInt[M]) {.inline.} =\n    int(m) *= extgcd(M, int(n).modulo(M))[1].modulo(M)\n\
    \    m.retake()\n\n  generateDefinitions(`+`, m, n, ModInt[M]):\n    result +=\
    \ m\n    result += n\n\n  generateDefinitions(`-`, m, n, ModInt[M]):\n    result\
    \ += m\n    result -= n\n\n  generateDefinitions(`*`, m, n, ModInt[M]):\n    result\
    \ += m\n    result *= n\n\n  generateDefinitions(`/`, m, n, ModInt[M]):\n    result\
    \ += m\n    result /= n\n\n  proc `==`*[M: static[int]](m: ModInt[M]; n: int |\
    \ ModInt[M]): bool {.inline.} =\n    int(m) == int(n)\n\n  proc inc*[M: static[int]](m:\
    \ var ModInt[M]) {.inline.} =\n    int(m).inc\n    if m == M:\n      int(m) =\
    \ 0\n\n  proc dec*[M: static[int]](m: var ModInt[M]) {.inline.} =\n    if m ==\
    \ 0:\n      int(m) = M - 1\n    else:\n      int(m).dec\n\n  proc pow*[M: static[int]](m:\
    \ ModInt[M]; p: int): ModInt[M] {.inline.} =\n    var\n      p = p\n      m =\
    \ m\n    int(result) = 1\n    while p > 0:\n      if (p and 1) == 1:\n       \
    \ result *= m\n      m *= m\n      p = p shr 1\n\n"
  dependsOn: []
  isVerificationFile: false
  path: src/nim_acl/modint_zer0star.nim
  requiredBy: []
  timestamp: '2020-09-16 18:22:00+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/nim_acl/modint_zer0star.nim
layout: document
redirect_from:
- /library/src/nim_acl/modint_zer0star.nim
- /library/src/nim_acl/modint_zer0star.nim.html
title: src/nim_acl/modint_zer0star.nim
---
