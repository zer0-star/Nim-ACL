---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/internal_fft.nim
    title: atcoder/extra/math/internal_fft.nim
  - icon: ':x:'
    path: atcoder/extra/math/particular_mod_convolution.nim
    title: atcoder/extra/math/particular_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':x:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':x:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':x:'
    path: atcoder/extra/math/internal_fft.nim
    title: atcoder/extra/math/internal_fft.nim
  - icon: ':x:'
    path: atcoder/extra/math/arbitrary_mod_convolution.nim
    title: atcoder/extra/math/arbitrary_mod_convolution.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  _extendedRequiredBy:
  - icon: ':warning:'
    path: verify/extra/composition_of_formal_power_series_test_backup.nim
    title: verify/extra/composition_of_formal_power_series_test_backup.nim
  - icon: ':warning:'
    path: verify/extra/composition_of_formal_power_series_test_backup.nim
    title: verify/extra/composition_of_formal_power_series_test_backup.nim
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/inv_of_formal_power_series_test.nim
    title: verify/extra/inv_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/inv_of_formal_power_series_test.nim
    title: verify/extra/inv_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/arbitrary_mod_convolution_test.nim
    title: verify/extra/arbitrary_mod_convolution_test.nim
  - icon: ':x:'
    path: verify/extra/arbitrary_mod_convolution_test.nim
    title: verify/extra/arbitrary_mod_convolution_test.nim
  - icon: ':x:'
    path: verify/extra/arbitrary_mod_exp_modsqrt_test.nim
    title: verify/extra/arbitrary_mod_exp_modsqrt_test.nim
  - icon: ':x:'
    path: verify/extra/arbitrary_mod_exp_modsqrt_test.nim
    title: verify/extra/arbitrary_mod_exp_modsqrt_test.nim
  - icon: ':x:'
    path: verify/extra/exp_of_formal_power_series_test.nim
    title: verify/extra/exp_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/exp_of_formal_power_series_test.nim
    title: verify/extra/exp_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/pow_of_formal_power_series_test.nim
    title: verify/extra/pow_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/pow_of_formal_power_series_test.nim
    title: verify/extra/pow_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/log_of_formal_power_series_test.nim
    title: verify/extra/log_of_formal_power_series_test.nim
  - icon: ':x:'
    path: verify/extra/log_of_formal_power_series_test.nim
    title: verify/extra/log_of_formal_power_series_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# FormalPowerSeries {{{\nwhen not declared ATCODER_FORMAL_POWER_SERIES:\n\
    \  const ATCODER_FORMAL_POWER_SERIES* = 1\n  \n  import std/sequtils, std/strformat,\
    \ std/options, std/macros, std/tables\n  \n  import atcoder/modint\n  import atcoder/convolution\n\
    #  import atcoder/extra/math/element_concepts\n  import atcoder/extra/math/internal_fft\n\
    \  import atcoder/extra/math/arbitrary_mod_convolution\n  import atcoder/extra/math/particular_mod_convolution\n\
    #  import atcoder/extra/math/combination\n\n  type FormalPowerSeries*[T:ModInt]\
    \ = seq[T]\n  type SparseFormalPowerSeries*[T:ModInt] = seq[(int, T)]\n\n  proc\
    \ initFormalPowerSeries*[T](n:int):FormalPowerSeries[T] =\n    FormalPowerSeries[T](newSeq[T](n))\n\
    \  proc initFormalPowerSeries*[T](v:seq or array):FormalPowerSeries[T] =\n   \
    \ when v is FormalPowerSeries[T]: return v\n    else:\n      result = newSeq[T](data.len)\n\
    \      for i, it in data:\n        result[i] = T.init(it)\n  template init*[T](self:typedesc[FormalPowerSeries[T]],\
    \ data:typed):auto =\n    initFormalPowerSeries[T](data)\n\n  macro revise(a,\
    \ b) =\n    parseStmt(fmt\"\"\"let {a.repr} = if {a.repr} == -1: {b.repr} else:\
    \ {a.repr}\"\"\")\n  # sqrt {{{\n  type\n    SQRT[T] = proc(t:T):Option[T]\n \
    \ \n  proc sqrtSub[T](self:FormalPowerSeries[T], update: bool, f:SQRT[T]):(bool,\
    \ SQRT[T]){.discardable.} =\n    var is_set{.global.} = false\n    var sqr{.global.}:SQRT[T]\
    \ = nil\n    if update:\n      is_set = true\n      sqr = f\n    return (is_set,\
    \ sqr)\n  proc isSetSqrt[T](self:FormalPowerSeries[T]):bool = return self.sqrtSub(false,\
    \ nil)[0]\n  proc setSqrt[T](self:FormalPowerSeries[T], f: SQRT[T]):SQRT[T]{.discardable.}\
    \ = return self.sqrtSub(true, f)[1]\n  proc getSqrt[T](self:FormalPowerSeries[T]):SQRT[T]{.discardable.}\
    \ = return self.sqrtSub(false, nil)[1]\n  #}}}\n  \n  proc shrink*[T](self: var\
    \ FormalPowerSeries[T]) =\n    while self.len > 0 and self[^1] == 0: discard self.pop()\n\
    \ \n  # operators +=, -=, *=, mod=, -, /= {{{\n  proc `+=`*(self: var FormalPowerSeries,\
    \ r:FormalPowerSeries) =\n    if r.len > self.len: self.setlen(r.len)\n    for\
    \ i in 0..<r.len: self[i] += r[i]\n  proc `+=`*[T](self: var FormalPowerSeries[T],\
    \ r:T) =\n    if self.len == 0: self.setlen(1)\n    self[0] += r\n  \n  proc `-=`*[T](self:\
    \ var FormalPowerSeries[T], r:FormalPowerSeries[T]) =\n    if r.len > self.len:\
    \ self.setlen(r.len)\n    for i in 0..<r.len: self[i] -= r[i]\n#    self.shrink()\n\
    \  proc `-=`*[T](self: var FormalPowerSeries[T], r:T) =\n    if self.len == 0:\
    \ self.setlen(1)\n    self[0] -= r\n#    self.shrink()\n\n  proc `*=`*[T](self:\
    \ var FormalPowerSeries[T], v:T) = self.applyIt(it * v)\n\n  proc multRaw*[T](a:FormalPowerSeries[T],\
    \ b:SparseFormalPowerSeries[T], deg = -1):FormalPowerSeries[T] =\n    var deg\
    \ = deg\n    if deg == -1:\n      var bdeg = 0\n      for p in b: bdeg = max(bdeg,\
    \ p[0])\n      deg = a.len + bdeg\n    result = initFormalPowerSeries[T](deg)\n\
    \    for i in 0..<a.len:\n      for (j, c) in b:\n        let k = i + j\n    \
    \    if k < deg: result[k] += a[i] * c\n  proc multRaw*[T](a, b:SparseFormalPowerSeries[T],\
    \ deg = -1):SparseFormalPowerSeries[T] =\n    var r = initTable[int,T]()\n   \
    \ for (i, c0) in a:\n      for (j, c1) in b:\n        let k = i + j\n        if\
    \ deg != -1 and k >= deg: continue\n        if k notin r: r[k] = T(0)\n      \
    \  r[k] += c0 * c1\n    return toSeq(r.pairs)\n\n  proc `*=`*[T](self: var FormalPowerSeries[T],\
    \  r: FormalPowerSeries[T]) =\n    if self.len == 0 or r.len == 0:\n      self.setlen(0)\n\
    \    else:\n      when T is ModInt:\n        type F = T.get_fft_type()\n     \
    \   self = F.convolution(self, r)\n#        when T is StaticModInt and T.isGoodMod:\n\
    #          self = convolution.convolution(self, r)\n#        else:\n#        \
    \  self = arbitrary_mod_convolution.convolution(self, r)\n      else:\n      \
    \  var res = initFormalPowerSeries[T](self.len + r.len - 1)\n        for i in\
    \ 0..<self.len:\n          for j in 0..<r.len:\n            res += self[i] * r[j]\n\
    \        swap(self, res)\n \n  proc `mod=`*[T](self: var FormalPowerSeries[T],\
    \ r:FormalPowerSeries[T]) = self -= self div r * r\n  \n  proc `-`*[T](self: FormalPowerSeries[T]):FormalPowerSeries[T]\
    \ =\n    var ret = self\n    ret.applyIt(-it)\n    return ret\n  proc `/=`*[T](self:\
    \ var FormalPowerSeries[T], v:T) = self.applyIt(it / v)\n  #}}}\n\n  proc rev*[T](self:\
    \ FormalPowerSeries[T], deg = -1):auto =\n    result = self\n    if deg != -1:\
    \ result.setlen(deg)\n    result.reverse\n  \n  proc pre*[T](self: FormalPowerSeries[T],\
    \ sz:int):auto =\n    result = self\n    result.setlen(min(self.len, sz))\n  \n\
    \  proc `shr`*[T](self: FormalPowerSeries[T], sz:int):auto =\n    if self.len\
    \ <= sz: return initFormalPowerSeries[T](0)\n    result = self\n    if sz >= 1:\
    \ result.delete(0, sz - 1)\n  proc `shl`*[T](self: FormalPowerSeries[T], sz:int):auto\
    \ =\n    result = initFormalPowerSeries[T](sz)\n    result = result & self\n \
    \ \n  proc diff*[T](self: FormalPowerSeries[T]):auto =\n    let n = self.len\n\
    \    result = initFormalPowerSeries[T](max(0, n - 1))\n    for i in 1..<n:\n \
    \     result[i - 1] = self[i] * T(i)\n  \n  proc integral*[T](self: FormalPowerSeries[T]):auto\
    \ =\n    let n = self.len\n    result = initFormalPowerSeries[T](n + 1)\n    result[0]\
    \ = T(0)\n    for i in 0..<n: result[i + 1] = self[i] / T(i + 1)\n  \n  # F(0)\
    \ must not be 0\n  proc inv*[T](self: FormalPowerSeries[T], deg = -1):auto =\n\
    \    assert(self[0] != 0)\n    deg.revise(self.len)\n    type F = T.get_fft_type()\n\
    \    when T is ModInt:\n      proc invFast[T](self: FormalPowerSeries[T]):auto\
    \ =\n        assert(self[0] != 0)\n        let n = self.len\n        var res =\
    \ initFormalPowerSeries[T](1)\n        res[0] = T(1) / self[0]\n        var d\
    \ = 1\n        while d < n:\n          var f, g = initFormalPowerSeries[T](2 *\
    \ d)\n          for j in 0..<min(n, 2 * d): f[j] = self[j]\n          for j in\
    \ 0..<d: g[j] = res[j]\n          let g1 = F.fft(g)\n          f = ifft[T](F,\
    \ dot(F.fft(f), g1))\n          for j in 0..<d:\n            f[j] = T(0)\n   \
    \         f[j + d] = -f[j + d]\n          f = ifft[T](F, dot(F.fft(f), g1))\n\
    \          f[0..<d] = res[0..<d]\n          res = f\n          d = d shl 1\n \
    \       return res.pre(n)\n      var ret = self\n      ret.setlen(deg)\n     \
    \ return ret.invFast()\n    else:\n      var ret = initFormalPowerSeries[T](1)\n\
    \      ret[0] = T(1) / self[0]\n      var i = 1\n      while i < deg:\n      \
    \  ret = (ret + ret - ret * ret * self.pre(i shl 1)).pre(i shl 1)\n        i =\
    \ i shl 1\n      return ret.pre(deg)\n  proc `/=`*[T](self: var FormalPowerSeries[T],\
    \ r: FormalPowerSeries[T]) =\n    self *= r.inv()\n\n  proc `div=`*[T](self: var\
    \ FormalPowerSeries[T], r: FormalPowerSeries[T]) =\n    if self.len < r.len:\n\
    \      self.setlen(0)\n    else:\n      let n = self.len - r.len + 1\n      self\
    \ = (self.rev().pre(n) * r.rev().inv(n)).pre(n).rev(n)\n  \n  template toFormalPowerSeries[T](f:FormalPowerSeries[T]\
    \ or T or SomeNumber):auto =\n    when f is SomeNumber or f is T: initFormalPowerSeries[T](@[T(f)])\n\
    \    else: initFormalPowerSeries[T](f)\n\n  # operators +, -, *, div, mod {{{\n\
    \  macro declareOp(op) =\n    fmt\"\"\"proc `{op}`*[T](self:FormalPowerSeries[T];r:FormalPowerSeries[T]\
    \ or T):FormalPowerSeries[T] = result = self;result {op}= r\nproc `{op}`*[T](self:\
    \ not FormalPowerSeries, r:FormalPowerSeries[T]):FormalPowerSeries[T] = result\
    \ = initFormalPowerSeries[T](@[T(self)]);result {op}= r\"\"\".parseStmt\n  \n\
    \  declareOp(`+`)\n  declareOp(`-`)\n  declareOp(`*`)\n  declareOp(`/`)\n  \n\
    \  proc `div`*[T](self, r:FormalPowerSeries[T]):FormalPowerSeries[T] = result\
    \ = self;result.`div=` (r)\n  proc `mod`*[T](self, r:FormalPowerSeries[T]):FormalPowerSeries[T]\
    \ = result = self;result.`mod=` (r)\n  # }}}\n  \n  # F(0) must be 1\n  proc log*[T](self:FormalPowerSeries[T],\
    \ deg = -1):auto =\n    assert self[0] == T(1)\n    deg.revise(self.len)\n   \
    \ return (self.diff() * self.inv(deg)).pre(deg - 1).integral()\n  \n  proc sqrt*[T](self:\
    \ FormalPowerSeries[T], deg = -1):auto =\n    let n = self.len\n    deg.revise(n)\n\
    \    if self[0] == 0:\n      for i in 1..<n:\n        if self[i] != 0:\n     \
    \     if (i and 1) > 0: return FormalPowerSeries[T].none\n          if deg - i\
    \ div 2 <= 0: break\n          var opt = (self shr i).sqrt(deg - i div 2)\n  \
    \        if not opt.isSome: return FormalPowerSeries[T].none\n          var ret\
    \ = opt.get shl (i div 2)\n          if ret.len < deg: ret.setlen(deg)\n     \
    \     return ret.some\n      return initFormalPowerSeries[T](deg).some\n  \n \
    \   var ret:FormalPowerSeries[T]\n    if self.isSetSqrt:\n      let opt = self.getSqrt()(self[0])\n\
    \      if not opt.isSome: return FormalPowerSeries[T].none\n      ret = initFormalPowerSeries[T](@[T(opt.get)])\n\
    \    else:\n      assert(self[0] == 1)\n      ret = initFormalPowerSeries[T](@[T(1)])\n\
    \  \n    let inv2 = T(1) / T(2)\n    var i = 1\n    while i < deg:\n      ret\
    \ = (ret + self.pre(i shl 1) * ret.inv(i shl 1)) * inv2\n      i = i shl 1\n \
    \   return ret.pre(deg).some\n  \n#  import typetraits\n  \n  # F(0) must be 0\n\
    \  proc exp*[T](self: FormalPowerSeries[T], deg = -1):auto =\n    assert self[0]\
    \ == 0\n    deg.revise(self.len)\n    when T is ModInt:\n      proc onlineConvolutionExp[T](self,\
    \ conv_coeff:FormalPowerSeries[T]):auto =\n        let n = conv_coeff.len\n  \
    \      assert((n and (n - 1)) == 0)\n        type F = T.get_fft_type()\n     \
    \   type FFTType = F.fft(initFormalPowerSeries[T](0)).type\n        var\n    \
    \      conv_ntt_coeff = newSeq[FFTType]()\n          i = n\n        while (i shr\
    \ 1) > 0:\n          var g = conv_coeff.pre(i)\n          conv_ntt_coeff.add(F.fft(g))\n\
    \          i = i shr 1\n        var conv_arg, conv_ret = initFormalPowerSeries[T](n)\n\
    \        proc rec(l,r,d:int) =\n          if r - l <= 16:\n            for i in\
    \ l..<r:\n              var sum = T(0)\n              for j in l..<i: sum += conv_arg[j]\
    \ * conv_coeff[i - j]\n              conv_ret[i] += sum\n              conv_arg[i]\
    \ = if i == 0: T(1) else: conv_ret[i] / i\n          else:\n            var m\
    \ = (l + r) div 2\n            rec(l, m, d + 1)\n            var pre = initFormalPowerSeries[T](r\
    \ - l)\n            pre[0..<m-l] = conv_arg[l..<m]\n            pre = ifft[T](F,\
    \ dot(F.fft(pre), conv_ntt_coeff[d]))\n            for i in 0..<r - m: conv_ret[m\
    \ + i] += pre[m + i - l]\n            rec(m, r, d + 1)\n        rec(0, n, 0)\n\
    \        return conv_arg\n      proc expRec[T](self: FormalPowerSeries[T]):auto\
    \ =\n        assert self[0] == 0\n        let n = self.len\n        var m = 1\n\
    \        while m < n: m *= 2\n        var conv_coeff = initFormalPowerSeries[T](m)\n\
    \        for i in 1..<n: conv_coeff[i] = self[i] * i\n        return self.onlineConvolutionExp(conv_coeff).pre(n)\n\
    \      var ret = self\n      ret.setlen(deg)\n      return ret.expRec()\n    else:\n\
    \      var\n        ret = initFormalPowerSeries[T](@[T(1)])\n        i = 1\n \
    \     while i < deg:\n        ret = (ret * (self.pre(i shl 1) + T(1) - ret.log(i\
    \ shl 1))).pre(i shl 1);\n        i = i shl 1\n      return ret.pre(deg)\n  \n\
    #  proc exponent*[T](a:FormalPowerSeries[T]):FormalPowerSeries[T] =\n#    assert(a.len\
    \ == 0 or a[0] == 0);\n#    var\n#      a = a\n#      b = initFormalPowerSeries[T]([1])\n\
    #    while b.len < a.len:\n#      var x = a[0..<min(a.len, 2 * b.len)]\n#    \
    \  x[0] += 1\n#      b.setLen(2 * b.len)\n#      x -= log(b)\n#      let l = b.len\
    \ div 2\n#      x *= b[0..<l]\n#      for i in l..<min(x.len, b.len):\n#     \
    \   b[i] = x[i]\n#    return b[0..<a.len]\n  \n  proc pow*[T](self: FormalPowerSeries[T],\
    \ k:int, deg = -1):auto =\n    var self = self\n    let n = self.len\n    deg.revise(n)\n\
    \    self.setLen(deg)\n    for i in 0..<n:\n      if self[i] != T(0):\n      \
    \  let rev = T(1) / self[i]\n        result = (((self * rev) shr i).log(deg) *\
    \ T.init(k)).exp() * (self[i].pow(k))\n        if i * k > deg: return initFormalPowerSeries[T](deg)\n\
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
    \ x -= getDiv(x) * M\n      n = n shr 1\n    return ret\n# }}}\n"
  dependsOn:
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/extra/math/internal_fft.nim
  - atcoder/extra/math/particular_mod_convolution.nim
  - atcoder/internal_math.nim
  - atcoder/convolution.nim
  - atcoder/internal_math.nim
  - atcoder/convolution.nim
  - atcoder/extra/math/internal_fft.nim
  - atcoder/extra/math/arbitrary_mod_convolution.nim
  - atcoder/modint.nim
  - atcoder/modint.nim
  isVerificationFile: false
  path: atcoder/extra/math/formal_power_series.nim
  requiredBy:
  - verify/extra/composition_of_formal_power_series_test_backup.nim
  - verify/extra/composition_of_formal_power_series_test_backup.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/inv_of_formal_power_series_test.nim
  - verify/extra/inv_of_formal_power_series_test.nim
  - verify/extra/arbitrary_mod_convolution_test.nim
  - verify/extra/arbitrary_mod_convolution_test.nim
  - verify/extra/arbitrary_mod_exp_modsqrt_test.nim
  - verify/extra/arbitrary_mod_exp_modsqrt_test.nim
  - verify/extra/exp_of_formal_power_series_test.nim
  - verify/extra/exp_of_formal_power_series_test.nim
  - verify/extra/pow_of_formal_power_series_test.nim
  - verify/extra/pow_of_formal_power_series_test.nim
  - verify/extra/log_of_formal_power_series_test.nim
  - verify/extra/log_of_formal_power_series_test.nim
documentation_of: atcoder/extra/math/formal_power_series.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/formal_power_series.nim
- /library/atcoder/extra/math/formal_power_series.nim.html
title: atcoder/extra/math/formal_power_series.nim
---
