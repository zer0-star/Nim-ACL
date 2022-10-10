---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/other/bitset.nim
    title: atcoder/extra/other/bitset.nim
  - icon: ':warning:'
    path: atcoder/extra/other/bitset.nim
    title: atcoder/extra/other/bitset.nim
  - icon: ':warning:'
    path: atcoder/extra/other/bitset.nim
    title: atcoder/extra/other/bitset.nim
  - icon: ':warning:'
    path: atcoder/extra/other/bitset.nim
    title: atcoder/extra/other/bitset.nim
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_BITUTILS_HPP:\n  const ATCODER_BITUTILS_HPP* =\
    \ 1\n  import bitops\n\n  proc `<<`*[B:SomeInteger](b:B, n:SomeInteger):B = b\
    \ shl n\n  proc `>>`*[B:SomeInteger](b:B, n:SomeInteger):B = b shr n\n\n  proc\
    \ seqToBits*[B:SomeInteger](v:varargs[int]): B =\n    result = 0\n    for x in\
    \ v: result = (result or (B(1) shl B(x)))\n\n  proc `[]`*[B:SomeInteger](b:B,n:int):int\
    \ = (if b.testBit(n): 1 else: 0)\n  proc `[]`*[B:SomeInteger](b:B,s:Slice[int]):int\
    \ = (b shr s.a) mod (B(1) shl (s.b - s.a + 1))\n  \n  proc `[]=`*[B:SomeInteger](b:var\
    \ B,n:int,t:int) =\n    if t == 0: b.clearBit(n)\n    elif t == 1: b.setBit(n)\n\
    \    else: doAssert(false)\n  proc `and`*[B:SomeInteger](b:B, v:openArray[int]):B\
    \ = b and seqToBits[B](v)\n  proc `or`*[B:SomeInteger](b:B, v:openArray[int]):B\
    \ = b or seqToBits[B](v)\n  proc `xor`*[B:SomeInteger](b:B, v:openArray[int]):B\
    \ = b xor seqToBits[B](v)\n  proc `&`*[B:SomeInteger](a:B, b:openarray[int]):auto\
    \ = a and b\n  proc `|`*[B:SomeInteger](a:B, b:openarray[int]):auto = a or b\n\
    \  proc `&`*(a:SomeInteger, b:SomeInteger):auto = a and b\n  proc `|`*(a:SomeInteger,\
    \ b:SomeInteger):auto = a or b\n\n  proc `@`*[B:SomeInteger](b:B): seq[int] =\n\
    \    result = newSeq[int]()\n    for i in 0..<(8 * sizeof(B)):\n      if b[i]\
    \ == 1: result.add(i)\n  proc `@^`*(v:openArray[int]): int =\n    result = 0\n\
    \    for i in v:\n      result[i] = 1\n\n  proc toBitStr*[B:SomeInteger](b:B,\
    \ n = -1):string =\n    let n = if n == -1: sizeof(B) * 8 else: n\n    result\
    \ = \"\"\n    for i in countdown(n-1,0):result.add if b[i] == 1: '1' else: '0'\n\
    \  proc allSetBits*[B:SomeInteger](n:int):B =\n    if n == 64:\n      return not\
    \ uint64(0)\n    else:\n      return (B(1) shl B(n)) - B(1)\n  iterator subsets*(v:seq[int],\
    \ B:typedesc[SomeInteger] = int):B =\n    var s = B(0)\n    yield s\n    while\
    \ true:\n      var found = false\n      for i in v:\n        if not s.testBit(i):\n\
    \          found = true\n          s.setBit(i)\n          yield s\n          break\n\
    \        else:\n          s[i] = 0\n      if not found: break\n\n  iterator subsets*[B:SomeInteger](b:B):B\
    \ =\n    for b in subsets[B](@b):\n      yield b\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/bitutils.nim
  requiredBy:
  - atcoder/extra/other/bitset.nim
  - atcoder/extra/other/bitset.nim
  - atcoder/extra/other/bitset.nim
  - atcoder/extra/other/bitset.nim
  timestamp: '2022-02-05 00:42:13+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/bitutils.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/bitutils.nim
- /library/atcoder/extra/other/bitutils.nim.html
title: atcoder/extra/other/bitutils.nim
---
