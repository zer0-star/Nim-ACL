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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "#{{{ bitset\nimport strutils, sequtils, algorithm\n\nconst BitWidth = 64\n\
    \n# {{{ BitSet\ntype BitSet[N:static[int]] = ref object\n  data: array[(N + BitWidth\
    \ - 1) div BitWidth, uint64]\n\nproc initBitSet[N:static[int]](): BitSet[N] =\n\
    \  const size = (N + BitWidth - 1) div BitWidth\n  var data: array[size, uint64]\n\
    \  return BitSet[N](data: data)\nproc initBitSet1[N:static[int]](): BitSet[N]\
    \ =\n  result = initBitSet(N)\n  let\n    q = (N + BitWidth - 1) div BitWidth\n\
    \    r = N div BitWidth\n  for i in 0..<q:result.data[i] = (not 0'u64)\n  if r\
    \ > 0:result.data[q] = ((1'u64 shl uint64(r)) - 1)\nproc init[N:static[int]](self:\
    \ BitSet[N]):BitSet[N] = initBitSet[N]()\nproc init1[N:static[int]](self: BitSet[N]):BitSet[N]\
    \ = initBitSet1[N]()\nproc getSize[N:static[int]](self: BitSet[N]):int = N\n#}}}\n\
    # {{{ DynamicBitSet\ntype DynamicBitSet = ref object\n  N:int\n  data: seq[uint64]\n\
    \nproc initDynamicBitSet(N:int): DynamicBitSet =\n  let size = (N + BitWidth -\
    \ 1) div BitWidth\n  return DynamicBitSet(N:N, data:newSeqWith(size, 0'u64))\n\
    proc initDynamicBitSet1(N:int): DynamicBitSet =\n  result = initDynamicBitSet(N)\n\
    \  let\n    q = (N + BitWidth - 1) div BitWidth\n    r = N div BitWidth\n  for\
    \ i in 0..<q:result.data[i] = (not 0'u64)\n  if r > 0:result.data[q] = ((1'u64\
    \ shl uint64(r)) - 1)\nproc init(self: DynamicBitSet):DynamicBitSet = initDynamicBitSet(self.N)\n\
    proc init1(self: DynamicBitSet):DynamicBitSet = initDynamicBitSet1(self.N)\nproc\
    \ getSize(self: DynamicBitSet):int = self.N\n#}}}\n\n# operations {{{\ntype BitSetC\
    \ = concept x\n#  x.data\n  x.getSize()\n  x.init()\n#  x.init1()\n\nproc toBin(b:uint64,\
    \ n: int): string =\n  result = \"\"\n  for i in countdown(n-1, 0):\n    if (b\
    \ and (1'u64 shl uint64(i))) != 0'u64: result &= \"1\"\n    else: result &= \"\
    0\"\n\nproc `$`(a: BitSetC):string =\n  let N = a.getSize()\n  var\n    q = N\
    \ div BitWidth\n    r = N mod BitWidth\n  var v = newSeq[string]()\n  for i in\
    \ 0..<q: v.add(a.data[i].toBin(BitWidth))\n  if r > 0: v.add(a.data[q].toBin(r))\n\
    \  v.reverse()\n  return v.join(\"\")\n\nproc `not`(a: BitSetC): auto =\n  result\
    \ = a.init1()\n  for i in 0..<a.data.len: result.data[i] = (not a.data[i]) and\
    \ result.data[i]\nproc `or`(a, b: BitSetC): auto =\n  result = a.init()\n  for\
    \ i in 0..<a.data.len: result.data[i] = a.data[i] or b.data[i]\nproc `and`(a,\
    \ b: BitSetC): auto =\n  result = a.init()\n  for i in 0..<a.data.len: result.data[i]\
    \ = a.data[i] and b.data[i]\nproc `xor`(a, b: BitSetC): auto =\n  result = a.init()\n\
    \  for i in 0..<a.data.len: result.data[i] = a.data[i] xor b.data[i]\n\nproc any(a:\
    \ BitSetC): bool = \n  let N = a.getSize()\n  var\n    q = N div BitWidth\n  \
    \  r = N mod BitWidth\n  for i in 0..<q:\n    if a.data[i] != 0.uint64: return\
    \ true\n  if r > 0 and (a.data[^1] and setBits[uint64](r)) != 0.uint64: return\
    \ true\n  return false\n\nproc all(a: BitSetC): bool =\n  let N = a.getSize()\n\
    \  var\n    q = N div BitWidth\n    r = N mod BitWidth\n  for i in 0..<q:\n  \
    \  if (not a.data[i]) != 0.uint64: return false\n  if r > 0 and a.data[^1] !=\
    \ setBits[uint64](r): return false\n  return true\n\nproc `[]`(b:BitSetC,n:int):int\
    \ =\n  let N = b.getSize()\n  assert 0 <= n and n < N\n  let\n    q = n div BitWidth\n\
    \    r = n mod BitWidth\n  return b.data[q][r]\nproc `[]=`(b:var BitSetC,n:int,t:int)\
    \ =\n  let N = b.getSize()\n  assert 0 <= n and n < N\n  assert t == 0 or t ==\
    \ 1\n  let\n    q = n div BitWidth\n    r = n mod BitWidth\n  b.data[q][r] = t\n\
    \nproc `shl`(a: BitSetC, n:int): auto =\n  result = a.init()\n  var r = int(n\
    \ mod BitWidth)\n  if r < 0: r += BitWidth\n  let q = (n - r) div BitWidth\n \
    \ let maskl = setBits[uint64](BitWidth - r)\n  for i in 0..<a.data.len:\n    let\
    \ d = (a.data[i] and maskl) shl uint64(r)\n    let i2 = i + q\n    if 0 <= i2\
    \ and i2 < a.data.len: result.data[i2] = result.data[i2] or d\n  if r != 0:\n\
    \    let maskr = setBits[uint64](r) shl uint64(BitWidth - r)\n    for i in 0..<a.data.len:\n\
    \      let d = (a.data[i] and maskr) shr uint64(BitWidth - r)\n      let i2 =\
    \ i + q + 1\n      if 0 <= i2 and i2 < a.data.len: result.data[i2] = result.data[i2]\
    \ or d\n  block:\n    let r = a.getSize() mod BitWidth\n    if r != 0:\n     \
    \ let mask = not (setBits[uint64](BitWidth - r) shl uint64(r))\n      result.data[^1]\
    \ = result.data[^1] and mask\nproc `shr`(a: BitSetC, n:int): auto = a shl (-n)\n\
    #}}}\n#}}}\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/bitset.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/bitset.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/bitset.nim
- /library/atcoder/extra/other/bitset.nim.html
title: atcoder/extra/other/bitset.nim
---
