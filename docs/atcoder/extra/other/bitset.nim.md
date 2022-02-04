---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: atcoder/extra/other/bitutils.nim
    title: atcoder/extra/other/bitutils.nim
  - icon: ':warning:'
    path: atcoder/extra/other/bitutils.nim
    title: atcoder/extra/other/bitutils.nim
  - icon: ':warning:'
    path: atcoder/extra/other/bitutils.nim
    title: atcoder/extra/other/bitutils.nim
  - icon: ':warning:'
    path: atcoder/extra/other/bitutils.nim
    title: atcoder/extra/other/bitutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_BITSET_HPP:\n  const ATCODER_BITSET_HPP* = 1\n\
    \  import strutils, sequtils, algorithm\n  import atcoder/extra/other/bitutils\n\
    \  \n  const BitWidth = 64\n  \n  # bitset\n  type BitSet*[N:static[int]] = object\n\
    \    data: array[(N + BitWidth - 1) div BitWidth, uint64]\n  \n  proc initBitSet*[N:static[int]]():\
    \ BitSet[N] =\n    discard\n  proc initBitSet1*[N:static[int]](): BitSet[N] =\n\
    \    result = initBitSet(N)\n    let\n      q = N div BitWidth\n      r = N mod\
    \ BitWidth\n    for i in 0..<q:result.data[i] = (not 0'u64)\n    if r > 0:result.data[q]\
    \ = ((1'u64 shl uint64(r)) - 1)\n  proc init*[N:static[int]](self: BitSet[N]):BitSet[N]\
    \ = initBitSet[N]()\n  proc init1*[N:static[int]](self: BitSet[N]):BitSet[N] =\
    \ initBitSet1[N]()\n  proc getSize*[N:static[int]](self: BitSet[N]):int = N\n\n\
    \  # dynamic bitset\n  type DynamicBitSet* = object\n    N:int\n    data: seq[uint64]\n\
    \  \n  proc initDynamicBitSet*(N:int): DynamicBitSet =\n    let size = (N + BitWidth\
    \ - 1) div BitWidth\n    return DynamicBitSet(N:N, data:newSeqWith(size, 0'u64))\n\
    \  proc initDynamicBitSet1*(N:int): DynamicBitSet =\n    result = initDynamicBitSet(N)\n\
    \    let\n      q = N div BitWidth\n      r = N mod BitWidth\n    for i in 0..<q:result.data[i]\
    \ = (not 0'u64)\n    if r > 0:result.data[q] = ((1'u64 shl uint64(r)) - 1)\n \
    \ proc init*(self: DynamicBitSet):DynamicBitSet = initDynamicBitSet(self.N)\n\
    \  proc init1*(self: DynamicBitSet):DynamicBitSet = initDynamicBitSet1(self.N)\n\
    \  proc getSize*(self: DynamicBitSet):int = self.N\n\n  type SomeBitSet* = BitSet\
    \ | DynamicBitSet\n  \n  proc toBin*(b:uint64, n: int): string =\n    result =\
    \ \"\"\n    for i in countdown(n-1, 0):\n      if (b and (1'u64 shl uint64(i)))\
    \ != 0'u64: result &= \"1\"\n      else: result &= \"0\"\n  \n  proc `$`*(a: SomeBitSet):string\
    \ =\n    let N = a.getSize()\n    var\n      q = N div BitWidth\n      r = N mod\
    \ BitWidth\n    var v = newSeq[string]()\n    for i in 0..<q: v.add(a.data[i].toBin(BitWidth))\n\
    \    if r > 0: v.add(a.data[q].toBin(r))\n    v.reverse()\n    return v.join(\"\
    \")\n  \n  proc `not`*(a: SomeBitSet): auto =\n    result = a.init1()\n    for\
    \ i in 0..<a.data.len: result.data[i] = (not a.data[i]) and result.data[i]\n \
    \ proc `or`*(a, b: SomeBitSet): auto =\n    result = a.init()\n    for i in 0..<a.data.len:\
    \ result.data[i] = a.data[i] or b.data[i]\n  proc `and`*(a, b: SomeBitSet): auto\
    \ =\n    result = a.init()\n    for i in 0..<a.data.len: result.data[i] = a.data[i]\
    \ and b.data[i]\n  proc `xor`*(a, b: SomeBitSet): auto =\n    result = a.init()\n\
    \    for i in 0..<a.data.len: result.data[i] = a.data[i] xor b.data[i]\n  \n \
    \ proc any*(a: SomeBitSet): bool = \n    let N = a.getSize()\n    var\n      q\
    \ = N div BitWidth\n      r = N mod BitWidth\n    for i in 0..<q:\n      if a.data[i]\
    \ != 0.uint64: return true\n    if r > 0 and (a.data[^1] and setBits[uint64](r))\
    \ != 0.uint64: return true\n    return false\n  \n  proc all*(a: SomeBitSet):\
    \ bool =\n    let N = a.getSize()\n    var\n      q = N div BitWidth\n      r\
    \ = N mod BitWidth\n    for i in 0..<q:\n      if (not a.data[i]) != 0.uint64:\
    \ return false\n    if r > 0 and a.data[^1] != setBits[uint64](r): return false\n\
    \    return true\n  \n  proc `[]`*(b:SomeBitSet,n:int):int =\n    let N = b.getSize()\n\
    \    assert 0 <= n and n < N\n    let\n      q = n div BitWidth\n      r = n mod\
    \ BitWidth\n    return b.data[q][r].int\n  proc `[]=`*(b:var SomeBitSet,n:int,t:int)\
    \ =\n    let N = b.getSize()\n    assert 0 <= n and n < N\n    assert t == 0 or\
    \ t == 1\n    let\n      q = n div BitWidth\n      r = n mod BitWidth\n    b.data[q][r]\
    \ = t\n  \n  proc `shl`*(a: SomeBitSet, n:int): auto =\n    result = a.init()\n\
    \    var r = int(n mod BitWidth)\n    if r < 0: r += BitWidth\n    let q = (n\
    \ - r) div BitWidth\n    let maskl = allSetBits[uint64](BitWidth - r)\n    for\
    \ i in 0..<a.data.len:\n      let d = (a.data[i] and maskl) shl uint64(r)\n  \
    \    let i2 = i + q\n      if 0 <= i2 and i2 < a.data.len: result.data[i2] = result.data[i2]\
    \ or d\n    if r != 0:\n      let maskr = allSetBits[uint64](r) shl uint64(BitWidth\
    \ - r)\n      for i in 0..<a.data.len:\n        let d = (a.data[i] and maskr)\
    \ shr uint64(BitWidth - r)\n        let i2 = i + q + 1\n        if 0 <= i2 and\
    \ i2 < a.data.len: result.data[i2] = result.data[i2] or d\n    block:\n      let\
    \ r = a.getSize() mod BitWidth\n      if r != 0:\n        let mask = not (allSetBits[uint64](BitWidth\
    \ - r) shl uint64(r))\n        result.data[^1] = result.data[^1] and mask\n  proc\
    \ `shr`*(a: SomeBitSet, n:int): auto = a shl (-n)\n"
  dependsOn:
  - atcoder/extra/other/bitutils.nim
  - atcoder/extra/other/bitutils.nim
  - atcoder/extra/other/bitutils.nim
  - atcoder/extra/other/bitutils.nim
  isVerificationFile: false
  path: atcoder/extra/other/bitset.nim
  requiredBy: []
  timestamp: '2022-02-05 00:42:13+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/bitset.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/bitset.nim
- /library/atcoder/extra/other/bitset.nim.html
title: atcoder/extra/other/bitset.nim
---
