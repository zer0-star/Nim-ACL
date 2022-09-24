---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/string/aoj_alds_1_14_b_test.nim
    title: verify/extra/string/aoj_alds_1_14_b_test.nim
  - icon: ':x:'
    path: verify/extra/string/aoj_alds_1_14_b_test.nim
    title: verify/extra/string/aoj_alds_1_14_b_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_ROLLING_HASH_HPP:\n  const ATCODER_ROLLING_HASH_HPP*\
    \ = 1\n  import std/sequtils\n  import atcoder/rangeutils\n  \n  template MASK*(n:static[int]):auto\
    \ = (1'u shl n.uint) - 1\n  \n  const base* = 1000000007'u\n  \n  type RH_Base*[Mod:static[uint],\
    \ base:static[uint]] = object\n    h:uint\n  \n  type RH* = RH_Base[(1'u shl 61)\
    \ - 1, base]\n  \n  converter toRH*(t:SomeInteger or char):RH = RH(h:t.uint)\n\
    \  \n  proc multRaw*(a, b:RH):RH =\n    let\n      au = a.h shr 31\n      ad =\
    \ a.h and MASK(31)\n      bu = b.h shr 31\n      bd = b.h and MASK(31)\n     \
    \ mid = ad * bu + au * bd\n      midu = mid shr 30\n      midd = mid and MASK(30)\n\
    \    RH(h:au * bu * 2 + midu + (midd shl 31) + ad * bd)\n  \n  proc calcMod*[T:RH](x:T):T\
    \ =\n    let\n      xu = x.h shr 61\n      xd = x.h and MASK(61)\n    result =\
    \ RH(xu + xd)\n    if result.h >= T.Mod: result.h -= T.Mod\n  \n  proc `*=`*(a:\
    \ var RH, b:RH) =  a = calcMod(multRaw(a, b))\n  proc `*`*(a, b:RH):RH = result\
    \ = a;result *= b\n  proc `==`*(a, b:RH):bool = a.h == b.h\n  proc `+=`*(a:var\
    \ RH, b:RH) =\n    a.h += b.h\n    if a.h >= RH.Mod: a.h -= RH.Mod\n  proc `+`*(a,\
    \ b:RH):RH = result = a;result += b\n  proc `-=`*(a:var RH, b:RH) =\n    a.h +=\
    \ RH.Mod - b.h\n    if a.h >= RH.Mod: a.h -= RH.Mod\n  proc `-`*(a, b:RH):RH =\
    \ result = a;result -= b\n  proc `&=`*(a:var RH, c:SomeInteger or char) =\n  \
    \  a = multRaw(a, RH(base))\n    a += RH(c)\n    a = a.calcMod()\n  proc `&`*(a:RH,\
    \ c:SomeInteger or char):RH = result = a;result &= c\n  \n  import hashes\n  proc\
    \ hash*(a:RH):Hash = a.h.hash\n  \n  type RollingHash*[RH] = object\n    len*:\
    \ int\n    hashed, power: seq[RH]\n  \n  proc initRollingHash*(s:string):auto\
    \ =\n    var\n      sz = s.len\n      hashed = newSeqWith(sz + 1, RH(0))\n   \
    \   power = newSeqWith(sz + 1, RH(0))\n    power[0] = 1'u\n    for i in 0..<sz:\n\
    \      power[i + 1] = power[i] * RH(base)\n      hashed[i + 1] = calcMod(multRaw(hashed[i],\
    \ RH(base)) + RH(s[i]))\n  #    if hashed[i + 1] >= MOD: hashed[i + 1] -= MOD\n\
    \    return RollingHash[RH](hashed: hashed, power: power, len: sz)\n  \n  proc\
    \ `[]`*(self: RollingHash; s:RangeType):RH =\n    let (l, r) = self.halfOpenEndpoints(s)\n\
    \    result = RH(self.hashed[r].h + (RH.MOD shl 2) - multRaw(self.hashed[l], self.power[r\
    \ - l]).h)\n    result = result.calcMod()\n  \n  proc connect*(self: RollingHash;\
    \ h1, h2:uint, h2len:int):RH =\n    result = multRaw(RH(h1), self.power[h2len])\
    \ + RH(h2)\n    result = result.calcMod\n  \n  proc LCP*(self, b:RollingHash;\
    \ p1, p2:RangeType):int =\n    let\n      (l1, r1) = self.halfOpenEndpoints(p1)\n\
    \      (l2, r2) = b.halfOpenEndpoints(p2)\n    var\n      low = -1\n      high\
    \ = min(r1 - l1, r2 - l2) + 1\n    while high - low > 1:\n      let mid = (low\
    \ + high) div 2\n      if self[l1 ..< l1 + mid] == b[l2 ..< l2 + mid]: low = mid\n\
    \      else: high = mid\n    return low\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  isVerificationFile: false
  path: atcoder/extra/string/rolling_hash.nim
  requiredBy: []
  timestamp: '2022-09-24 20:04:56+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/string/aoj_alds_1_14_b_test.nim
  - verify/extra/string/aoj_alds_1_14_b_test.nim
documentation_of: atcoder/extra/string/rolling_hash.nim
layout: document
redirect_from:
- /library/atcoder/extra/string/rolling_hash.nim
- /library/atcoder/extra/string/rolling_hash.nim.html
title: atcoder/extra/string/rolling_hash.nim
---
