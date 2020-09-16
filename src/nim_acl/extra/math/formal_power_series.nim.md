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
  code: "when not declared ATCODER_FORMAL_POWER_SERIES:\n  const ATCODER_FORMAL_POWER_SERIES*\
    \ = 1\n  const FastMod = true\n  const UseFFT = true\n  \n  # FormalPowerSeries\
    \ {{{\n  import sugar, sequtils, strformat, options, macros\n  \n  import /src/nim_acl/extra/math/element_concepts\n\
    \n  type FormalPowerSeries*[T:FieldElem] = seq[T]\n  type SparseFormalPowerSeries*[T:FieldElem]\
    \ = seq[(int, T)]\n  \n  when not declared(FastMult):\n    const FastMult* = true\n\
    \  when not declared(UseFFT):\n    const UseFFT* = true\n  when not declared(ArbitraryMod):\n\
    \    const ArbitraryMod* = false\n  when UseFFT or FastMult:\n    when ArbitraryMod:\n\
    \      when declared(ArbitraryModNTT):\n        type BaseFFT*[T] = ArbitraryModNTT[T]\n\
    \      elif declared(ArbitraryModFFT):\n        type BaseFFT*[T] = ArbitraryModFFT[T]\n\
    \      else:\n        assert(false)\n    else:\n      when declared(NumberTheoreticTransform):\n\
    \        type BaseFFT*[T] = NumberTheoreticTransform[T]\n      else:\n       \
    \ assert(false)\n    proc getFFT[T](self:FormalPowerSeries[T]):ptr BaseFFT[T]\
    \ =\n      var fft {.global.} = BaseFFT[T].init()\n      return fft.addr\n  \n\
    \  template initFormalPowerSeries*[T:FieldElem](data: typed):FormalPowerSeries[T]\
    \ =\n    when data is int: FormalPowerSeries[T](newSeq[T](data))\n    else: data.mapIt(T(it))\n\
    \  \n  proc `$`*[T](self:FormalPowerSeries[T]):string = return self.mapIt($it).join(\"\
    \ \")\n  \n  macro revise(a, b) =\n    parseStmt(fmt\"\"\"let {a.repr} = if {a.repr}\
    \ == -1: {b.repr} else: {a.repr}\"\"\")\n  # sqrt {{{\n  type\n    SQRT[T] = proc(t:T):Option[T]\n\
    \  \n  proc sqrtSub[T](self:FormalPowerSeries[T], update: bool, f:SQRT[T]):(bool,\
    \ SQRT[T]){.discardable.} =\n    var is_set{.global.} = false\n    var sqr{.global.}:SQRT[T]\
    \ = nil\n    if update:\n      is_set = true\n      sqr = f\n    return (is_set,\
    \ sqr)\n  proc isSetSqrt[T](self:FormalPowerSeries[T]):bool = return self.sqrtSub(false,\
    \ nil)[0]\n  proc setSqrt[T](self:FormalPowerSeries[T], f: SQRT[T]):SQRT[T]{.discardable.}\
    \ = return self.sqrtSub(true, f)[1]\n  proc getSqrt[T](self:FormalPowerSeries[T]):SQRT[T]{.discardable.}\
    \ = return self.sqrtSub(false, nil)[1]\n  #}}}\n  \n  proc shrink*[T](self: var\
    \ FormalPowerSeries[T]) =\n    while self.len > 0 and self[^1] == 0: discard self.pop()\n\
    \  \n  # operators +=, -=, *=, mod=, -, /= {{{\n  proc `+=`*(self: var FormalPowerSeries,\
    \ r:FormalPowerSeries) =\n    if r.len > self.len: self.setlen(r.len)\n    for\
    \ i in 0..<r.len: self[i] += r[i]\n  proc `+=`*[T](self: var FormalPowerSeries[T],\
    \ r:T) =\n    if self.len == 0: self.setlen(1)\n    self[0] += r\n  \n  proc `-=`*[T](self:\
    \ var FormalPowerSeries[T], r:FormalPowerSeries[T]) =\n    if r.len > self.len:\
    \ self.setlen(r.len)\n    for i in 0..<r.len: self[i] -= r[i]\n    self.shrink()\n\
    \  proc `-=`*[T](self: var FormalPowerSeries[T], r:T) =\n    if self.len == 0:\
    \ self.setlen(1)\n    self[0] -= r\n    self.shrink()\n  \n  proc `*=`*[T](self:\
    \ var FormalPowerSeries[T], v:T) = self.applyIt(it * v)\n  \n  proc multRaw*[T](a:FormalPowerSeries[T],\
    \ b:SparseFormalPowerSeries[T], deg = -1):FormalPowerSeries[T] =\n    var deg\
    \ = deg\n    if deg == -1:\n      var bdeg = 0\n      for p in b: bdeg = max(bdeg,\
    \ p[0])\n      deg = a.len + bdeg\n    result = initFormalPowerSeries[T](deg)\n\
    \    for i in 0..<a.len:\n      for (j, c) in b:\n        let k = i + j\n    \
    \    if k < deg: result[k] += a[i] * c\n  proc multRaw*[T](a, b:SparseFormalPowerSeries[T],\
    \ deg = -1):SparseFormalPowerSeries[T] =\n    var r = initTable[int,T]()\n   \
    \ for (i, c0) in a:\n      for (j, c1) in b:\n        let k = i + j\n        if\
    \ deg != -1 and k >= deg: continue\n        if k notin r: r[k] = T(0)\n      \
    \  r[k] += c0 * c1\n    return toSeq(r.pairs)\n  \n  proc `*=`*[T](self: var FormalPowerSeries[T],\
    \  r: FormalPowerSeries[T]) =\n    if self.len == 0 or r.len == 0:\n      self.setlen(0)\n\
    \    else:\n      when FastMult:\n        var fft = self.getFFT()\n        self\
    \ = fft[].multiply(self, r)\n      else:\n        assert(false)\n  \n  proc `mod=`*[T](self:\
    \ var FormalPowerSeries[T], r:FormalPowerSeries[T]) = self -= self div r * r\n\
    \  \n  proc `-`*[T](self: FormalPowerSeries[T]):FormalPowerSeries[T] =\n    var\
    \ ret = self\n    ret.applyIt(-it)\n    return ret\n  proc `/=`*[T](self: var\
    \ FormalPowerSeries[T], v:T) = self.applyIt(it / v)\n  #}}}\n  \n  \n  proc rev*[T](self:\
    \ FormalPowerSeries[T], deg = -1):auto =\n    result = self\n    if deg != -1:\
    \ result.setlen(deg)\n    result.reverse\n  \n  proc pre*[T](self: FormalPowerSeries[T],\
    \ sz:int):auto =\n    result = self\n    result.setlen(min(self.len, sz))\n  \n\
    \  proc dot*[T](self:FormalPowerSeries[T], r: FormalPowerSeries[T]):auto =\n \
    \   result = initFormalPowerSeries[T](min(self.len, r.len))\n    for i in 0..<result.len:\
    \ result[i] = self[i] * r[i]\n  \n  proc `shr`*[T](self: FormalPowerSeries[T],\
    \ sz:int):auto =\n    if self.len <= sz: return initFormalPowerSeries[T](0)\n\
    \    result = self\n    if sz >= 1: result.delete(0, sz - 1)\n  proc `shl`*[T](self:\
    \ FormalPowerSeries[T], sz:int):auto =\n    result = initFormalPowerSeries[T](sz)\n\
    \    result = result & self\n  \n  proc diff*[T](self: FormalPowerSeries[T]):auto\
    \ =\n    let n = self.len\n    result = initFormalPowerSeries[T](max(0, n - 1))\n\
    \    for i in 1..<n:\n      result[i - 1] = self[i] * T(i)\n  \n  proc integral*[T](self:\
    \ FormalPowerSeries[T]):auto =\n    let n = self.len\n    result = initFormalPowerSeries[T](n\
    \ + 1)\n    result[0] = T(0)\n    for i in 0..<n: result[i + 1] = self[i] / T(i\
    \ + 1)\n  \n  # F(0) must not be 0\n  proc inv*[T](self: FormalPowerSeries[T],\
    \ deg = -1):auto =\n    doAssert(self[0] != 0)\n    deg.revise(self.len)\n   \
    \ when UseFFT:\n      proc invFast[T](self: FormalPowerSeries[T]):auto =\n   \
    \     doAssert(self[0] != 0)\n        let n = self.len\n        var res = initFormalPowerSeries[T](1)\n\
    \        res[0] = T(1) / self[0]\n        var fft = self.getFFT()\n        var\
    \ d = 1\n        while d < n:\n          var f, g = initFormalPowerSeries[T](2\
    \ * d)\n          for j in 0..<min(n, 2 * d): f[j] = self[j]\n          for j\
    \ in 0..<d: g[j] = res[j]\n          let g1 = fft[].fft(g)\n          f = fft[].ifft(fft[].dot(fft[].fft(f),\
    \ g1))\n          for j in 0..<d:\n            f[j] = T(0)\n            f[j +\
    \ d] = -f[j + d]\n          f = fft[].ifft(fft[].dot(fft[].fft(f), g1))\n    \
    \      f[0..<d] = res[0..<d]\n          res = f\n          d = d shl 1\n     \
    \   return res.pre(n)\n      var ret = self\n      ret.setlen(deg)\n      return\
    \ ret.invFast()\n    else:\n      var ret = initFormalPowerSeries[T](1)\n    \
    \  ret[0] = T(1) / self[0]\n      var i = 1\n      while i < deg:\n        ret\
    \ = (ret + ret - ret * ret * self.pre(i shl 1)).pre(i shl 1)\n        i = i shl\
    \ 1\n      return ret.pre(deg)\n  \n  proc `div=`*[T](self: var FormalPowerSeries[T],\
    \ r: FormalPowerSeries[T]) =\n    if self.len < r.len:\n      self.setlen(0)\n\
    \    else:\n      let n = self.len - r.len + 1\n      self = (self.rev().pre(n)\
    \ * r.rev().inv(n)).pre(n).rev(n)\n  \n  # operators +, -, *, div, mod {{{\n \
    \ macro declareOp(op) =\n    fmt\"\"\"proc `{op}`*[T](self:FormalPowerSeries[T];r:FormalPowerSeries[T]\
    \ or T):FormalPowerSeries[T] = result = self;result {op}= r\n  proc `{op}`*[T](self:\
    \ not FormalPowerSeries, r:FormalPowerSeries[T]):FormalPowerSeries[T] = result\
    \ = initFormalPowerSeries[T](@[self]);result {op}= r\"\"\".parseStmt\n  \n  declareOp(`+`)\n\
    \  declareOp(`-`)\n  declareOp(`*`)\n  declareOp(`/`)\n  \n  proc `div`*[T](self,\
    \ r:FormalPowerSeries[T]):FormalPowerSeries[T] = result = self;result.`div=` (r)\n\
    \  proc `mod`*[T](self, r:FormalPowerSeries[T]):FormalPowerSeries[T] = result\
    \ = self;result.`mod=` (r)\n  # }}}\n  \n  # F(0) must be 1\n  proc log*[T](self:FormalPowerSeries[T],\
    \ deg = -1):auto =\n    doAssert self[0] == T(1)\n    deg.revise(self.len)\n \
    \   return (self.diff() * self.inv(deg)).pre(deg - 1).integral()\n  \n  proc sqrt*[T](self:\
    \ FormalPowerSeries[T], deg = -1):auto =\n    let n = self.len\n    deg.revise(n)\n\
    \    if self[0] == 0:\n      for i in 1..<n:\n        if self[i] != 0:\n     \
    \     if (i and 1) > 0: return FormalPowerSeries[T].none\n          if deg - i\
    \ div 2 <= 0: break\n          var opt = (self shr i).sqrt(deg - i div 2)\n  \
    \        if not opt.isSome: return FormalPowerSeries[T].none\n          var ret\
    \ = opt.get shl (i div 2)\n          if ret.len < deg: ret.setlen(deg)\n     \
    \     return ret.some\n      return initFormalPowerSeries[T](deg).some\n  \n \
    \   var ret:FormalPowerSeries[T]\n    if self.isSetSqrt:\n      let opt = self.getSqrt()(self[0])\n\
    \      if not opt.isSome: return FormalPowerSeries[T].none\n      ret = initFormalPowerSeries[T](@[T(opt.get)])\n\
    \    else:\n      doAssert(self[0] == 1)\n      ret = initFormalPowerSeries[T](@[T(1)])\n\
    \  \n    let inv2 = T(1) / T(2);\n    var i = 1\n    while i < deg:\n      ret\
    \ = (ret + self.pre(i shl 1) * ret.inv(i shl 1)) * inv2\n      i = i shl 1\n \
    \   return ret.pre(deg).some\n  \n  import typetraits\n  \n  # F(0) must be 0\n\
    \  proc exp*[T](self: FormalPowerSeries[T], deg = -1):auto =\n    doAssert self[0]\
    \ == 0\n    deg.revise(self.len)\n    when UseFFT:\n      proc onlineConvolutionExp[T](self,\
    \ conv_coeff:FormalPowerSeries[T]):auto =\n        var fft = self.getFFT()\n \
    \       let n = conv_coeff.len\n        doAssert((n and (n - 1)) == 0)\n     \
    \   type FFTType = fft[].fft(initFormalPowerSeries[T](0)).type\n        var\n\
    \          conv_ntt_coeff = newSeq[FFTType]()\n          i = n\n        while\
    \ (i shr 1) > 0:\n          var g = conv_coeff.pre(i)\n          conv_ntt_coeff.add(fft[].fft(g))\n\
    \          i = i shr 1\n        var conv_arg, conv_ret = initFormalPowerSeries[T](n)\n\
    \        proc rec(l,r,d:int) =\n          if r - l <= 16:\n            for i in\
    \ l..<r:\n              var sum = T(0)\n              for j in l..<i: sum += conv_arg[j]\
    \ * conv_coeff[i - j]\n              conv_ret[i] += sum\n              conv_arg[i]\
    \ = if i == 0: T(1) else: conv_ret[i] / i\n          else:\n            var m\
    \ = (l + r) div 2\n            rec(l, m, d + 1)\n            var pre = initFormalPowerSeries[T](r\
    \ - l)\n            pre[0..<m-l] = conv_arg[l..<m]\n            pre = fft[].ifft(fft[].dot(fft[].fft(pre),\
    \ conv_ntt_coeff[d]))\n            for i in 0..<r - m: conv_ret[m + i] += pre[m\
    \ + i - l]\n            rec(m, r, d + 1)\n        rec(0, n, 0)\n        return\
    \ conv_arg\n      proc expRec[T](self: FormalPowerSeries[T]):auto =\n        doAssert\
    \ self[0] == 0\n        let n = self.len\n        var m = 1\n        while m <\
    \ n: m *= 2\n        var conv_coeff = initFormalPowerSeries[T](m)\n        for\
    \ i in 1..<n: conv_coeff[i] = self[i] * i\n        return self.onlineConvolutionExp(conv_coeff).pre(n)\n\
    \      var ret = self\n      ret.setlen(deg)\n      return ret.expRec()\n    else:\n\
    \      var\n        ret = initFormalPowerSeries[T](@[T(1)])\n        i = 1\n \
    \     while i < deg:\n        ret = (ret * (self.pre(i shl 1) + T(1) - ret.log(i\
    \ shl 1))).pre(i shl 1);\n        i = i shl 1\n      return ret.pre(deg)\n  \n\
    \  proc exponent*[T](a:FormalPowerSeries[T]):FormalPowerSeries[T] =\n    assert(a.len\
    \ == 0 or a[0] == 0);\n    var\n      a = a\n      b = initFormalPowerSeries[T]([1])\n\
    \    while b.len < a.len:\n      var x = a[0..<min(a.len, 2 * b.len)]\n      x[0]\
    \ += 1\n      b.setLen(2 * b.len)\n      x -= log(b)\n      let l = b.len div\
    \ 2\n      x *= b[0..<l]\n      for i in l..<min(x.len, b.len):\n        b[i]\
    \ = x[i]\n    return b[0..<a.len]\n  \n  proc pow*[T](self: FormalPowerSeries[T],\
    \ k:int, deg = -1):auto =\n    var self = self\n    let n = self.len\n    deg.revise(n)\n\
    \    self.setLen(deg)\n    for i in 0..<n:\n      if self[i] != T(0):\n      \
    \  let rev = T(1) / self[i]\n        result = (((self * rev) shr i).log(deg) *\
    \ T(k)).exp() * (self[i]^k)\n        if i * k > deg: return initFormalPowerSeries[T](deg)\n\
    \        result = (result shl (i * k)).pre(deg)\n        if result.len < deg:\
    \ result.setlen(deg)\n        return\n    return self\n  \n  proc eval*[T](self:\
    \ FormalPowerSeries[T], x:T):T =\n    var\n      r = T(0)\n      w = T(1)\n  \
    \  for v in self:\n      r += w * v\n      w *= x\n    return r\n  \n  proc powMod*[T](self:\
    \ FormalPowerSeries[T], n:int, M:FormalPowerSeries[T]):auto =\n    let modinv\
    \ = M.rev().inv()\n    proc getDiv(base:FormalPowerSeries[T]):FormalPowerSeries[T]\
    \ =\n      var base = base\n      if base.len < M.len:\n        base.setlen(0)\n\
    \        return base\n      let n = base.len - M.len + 1\n      return (base.rev().pre(n)\
    \ * modinv.pre(n)).pre(n).rev(n)\n    var\n      n = n\n      x = self\n     \
    \ ret = initFormalPowerSeries[T](@[T(1)])\n    while n > 0:\n      if (n and 1)\
    \ > 0:\n        ret *= x\n        ret -= getDiv(ret) * M\n      x *= x\n     \
    \ x -= getDiv(x) * M\n      n = n shr 1\n    return ret\n  # }}}\n\n"
  dependsOn: []
  isVerificationFile: false
  path: src/nim_acl/extra/math/formal_power_series.nim
  requiredBy: []
  timestamp: '2020-09-14 00:37:28+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/nim_acl/extra/math/formal_power_series.nim
layout: document
redirect_from:
- /library/src/nim_acl/extra/math/formal_power_series.nim
- /library/src/nim_acl/extra/math/formal_power_series.nim.html
title: src/nim_acl/extra/math/formal_power_series.nim
---
