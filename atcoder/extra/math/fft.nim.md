---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  _extendedRequiredBy:
  - icon: ':warning:'
    path: tests/test_extra_formal_power_series_float.nim
    title: tests/test_extra_formal_power_series_float.nim
  - icon: ':warning:'
    path: tests/test_extra_formal_power_series_float.nim
    title: tests/test_extra_formal_power_series_float.nim
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
  code: "#{{{ FastFourierTransform\nwhen not declared ATCODER_FFT_HPP:\n  const ATCODER_FFT_HPP*\
    \ = 1\n\n  import std/sequtils, std/bitops, std/math\n#  import atcoder/extra/math/longdouble\n\
    \  import atcoder/internal_bit\n  \n#  type Real = LongDouble\n  type Real = float\n\
    #  type Real = clongdouble\n  \n  type Complex = tuple[x, y:Real]\n\n  proc initComplex*[S,T](x:S,\
    \ y:T):Complex =\n    (Real(x), Real(y))\n  \n  proc `+`*(a,b:Complex):Complex\
    \ = initComplex(a.x + b.x, a.y + b.y)\n  proc `-`*(a,b:Complex):Complex = initComplex(a.x\
    \ - b.x, a.y - b.y)\n  proc `*`*(a,b:Complex):Complex = initComplex(a.x * b.x\
    \ - a.y * b.y, a.x * b.y + a.y * b.x)\n  proc conj*(a:Complex):Complex = initComplex(a.x,\
    \ -a.y)\n  \n  type SeqComplex = object\n    real, imag: seq[Real]\n  \n  proc\
    \ initSeqComplex*(n:int):SeqComplex = SeqComplex(real: newSeqWith(n, Real(0)),\
    \ imag: newSeqWith(n, Real(0)))\n  \n  proc setLen*(self: var SeqComplex, n:int)\
    \ =\n    self.real.setLen(n)\n    self.imag.setLen(n)\n  proc swap*(self: var\
    \ SeqComplex, i, j:int) =\n    swap(self.real[i], self.real[j])\n    swap(self.imag[i],\
    \ self.imag[j])\n  \n  type FastFourierTransform* = object of RootObj\n    base:int\n\
    \    rts: SeqComplex\n    rev:seq[int]\n  \n  proc getC*(self: SeqComplex, i:int):Complex\
    \ = (self.real[i], self.imag[i])\n  proc `[]`*(self: SeqComplex, i:int):Complex\
    \ = self.getC(i)\n  proc `[]=`*(self: var SeqComplex, i:int, x:Complex) =\n  \
    \  self.real[i] = x.x\n    self.imag[i] = x.y\n  \n  proc initFastFourierTransform*():FastFourierTransform\
    \ = \n    return FastFourierTransform(base:1, rts: SeqComplex(real: @[Real(0),\
    \ Real(1)], imag: @[Real(0), Real(0)]), rev: @[0, 1])\n  #proc init(self:typedesc[FastFourierTransform]):auto\
    \ = initFastFourierTransform()\n\n  proc ensureBase*(self:var FastFourierTransform;\
    \ nbase:int) =\n    if nbase <= self.base: return\n    self.rev.setlen(1 shl nbase)\n\
    \    self.rts.setlen(1 shl nbase)\n    for i in 0..<(1 shl nbase): self.rev[i]\
    \ = (self.rev[i shr 1] shr 1) + ((i and 1) shl (nbase - 1))\n    while self.base\
    \ < nbase:\n      let angle = arccos(Real(-1)) * Real(2) / Real(1 shl (self.base\
    \ + 1))\n      for i in (1 shl (self.base - 1))..<(1 shl self.base):\n       \
    \ self.rts[i shl 1] = self.rts[i]\n        let angle_i = angle * Real(2 * i +\
    \ 1 - (1 shl self.base))\n        self.rts[(i shl 1) + 1] = initComplex(cos(angle_i),\
    \ sin(angle_i))\n      self.base.inc\n  \n  proc fft(self:var FastFourierTransform;\
    \ a:var SeqComplex, n:int) =\n    assert((n and (n - 1)) == 0)\n    let zeros\
    \ = countTrailingZeroBits(n)\n    self.ensureBase(zeros)\n    let shift = self.base\
    \ - zeros\n    for i in 0..<n:\n      if i < (self.rev[i] shr shift):\n      \
    \  a.swap(i, self.rev[i] shr shift)\n    var k = 1\n    while k < n:\n      var\
    \ i = 0\n      while i < n:\n        for j in 0..<k:\n          let z = a[i +\
    \ j + k] * self.rts[j + k]\n          a[i + j + k] = a[i + j] - z\n          a[i\
    \ + j] = a[i + j] + z\n        i += 2 * k\n      k = k shl 1\n  \n  proc ifft(self:\
    \ var FastFourierTransform; a: var SeqComplex, n:int) =\n    for i in 0..<n: a[i]\
    \ = a[i].conj()\n    let rN = Real(1) / Real(n)\n    self.fft(a, n)\n    for i\
    \ in 0..<n:\n      let t = a[i]\n      a[i] = (t.x * rN, t.y * rN)\n  \n  var\
    \ fft_t* = initFastFourierTransform()\n  \n  proc fft*[T:SomeFloat or Real](a:seq[T]):SeqComplex\
    \ =\n    result = initSeqComplex(a.len)\n    for i in 0..<a.len:\n      result[i]\
    \ = initComplex(a[i], T(0))\n    fft_t.fft(result, a.len)\n  proc ifft*(a:SeqComplex,\
    \ T:typedesc[SomeFloat or Real]):auto =\n    var a = a\n    let n = a.real.len\n\
    \    fft_t.ifft(a, n)\n    var r  = newSeq[T](n)\n    for i in 0..<n:\n      r[i]\
    \ = T(a.real[i])\n    return r\n  proc inplace_partial_dot*(a:var SeqComplex,\
    \ b:SeqComplex, p:Slice[int], T:typedesc[SomeFloat or Real]):auto =\n    for i\
    \ in p:\n      a[i] = a[i] * b[i]\n\n  proc dot*(a, b:SeqComplex, T:typedesc[SomeFloat\
    \ or Real]):auto =\n    let n = a.real.len\n    result = a\n    result.inplace_partial_dot(b,\
    \ 0..<n, T)\n  proc multiply*[T:SomeFloat or Real](a, b:seq[T]):seq[T] =\n   \
    \ let\n      (n, m) = (a.len, b.len)\n      z = 1 shl ceil_pow2(n + m - 1)\n \
    \   var (a, b) = (a, b)\n    a.setLen(z)\n    b.setLen(z)\n    var r = newSeq[T]()\n\
    \    r = ifft(dot(a.fft(), b.fft(), T), T)\n    r.setLen(n + m - 1)\n    return\
    \ r.mapIt(it.T)\n#}}}\n"
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  isVerificationFile: false
  path: atcoder/extra/math/fft.nim
  requiredBy:
  - tests/test_extra_formal_power_series_float.nim
  - tests/test_extra_formal_power_series_float.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/fft.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/fft.nim
- /library/atcoder/extra/math/fft.nim.html
title: atcoder/extra/math/fft.nim
---
