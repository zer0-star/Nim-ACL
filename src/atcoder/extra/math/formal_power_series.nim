when not declared ATCODER_FORMAL_POWER_SERIES:
  const ATCODER_FORMAL_POWER_SERIES* = 1
  const FastMod = true
  const UseFFT = true
  
  # FormalPowerSeries {{{
  import sugar, sequtils, strformat, options, macros
  
  import atcoder/extra/math/element_concepts

  type FormalPowerSeries*[T:FieldElem] = seq[T]
  type SparseFormalPowerSeries*[T:FieldElem] = seq[(int, T)]
  
  when not declared(FastMult):
    const FastMult* = true
  when not declared(UseFFT):
    const UseFFT* = true
  when not declared(ArbitraryMod):
    const ArbitraryMod* = false
  when UseFFT or FastMult:
    when ArbitraryMod:
      when declared(ArbitraryModNTT):
        type BaseFFT*[T] = ArbitraryModNTT[T]
      elif declared(ArbitraryModFFT):
        type BaseFFT*[T] = ArbitraryModFFT[T]
      else:
        assert(false)
    else:
      when declared(NumberTheoreticTransform):
        type BaseFFT*[T] = NumberTheoreticTransform[T]
      else:
        assert(false)
    proc getFFT[T](self:FormalPowerSeries[T]):ptr BaseFFT[T] =
      var fft {.global.} = BaseFFT[T].init()
      return fft.addr
  
  template initFormalPowerSeries*[T:FieldElem](data: typed):FormalPowerSeries[T] =
    when data is int: FormalPowerSeries[T](newSeq[T](data))
    else: data.mapIt(T(it))
  
  proc `$`*[T](self:FormalPowerSeries[T]):string = return self.mapIt($it).join(" ")
  
  macro revise(a, b) =
    parseStmt(fmt"""let {a.repr} = if {a.repr} == -1: {b.repr} else: {a.repr}""")
  # sqrt {{{
  type
    SQRT[T] = proc(t:T):Option[T]
  
  proc sqrtSub[T](self:FormalPowerSeries[T], update: bool, f:SQRT[T]):(bool, SQRT[T]){.discardable.} =
    var is_set{.global.} = false
    var sqr{.global.}:SQRT[T] = nil
    if update:
      is_set = true
      sqr = f
    return (is_set, sqr)
  proc isSetSqrt[T](self:FormalPowerSeries[T]):bool = return self.sqrtSub(false, nil)[0]
  proc setSqrt[T](self:FormalPowerSeries[T], f: SQRT[T]):SQRT[T]{.discardable.} = return self.sqrtSub(true, f)[1]
  proc getSqrt[T](self:FormalPowerSeries[T]):SQRT[T]{.discardable.} = return self.sqrtSub(false, nil)[1]
  #}}}
  
  proc shrink*[T](self: var FormalPowerSeries[T]) =
    while self.len > 0 and self[^1] == 0: discard self.pop()
  
  # operators +=, -=, *=, mod=, -, /= {{{
  proc `+=`*(self: var FormalPowerSeries, r:FormalPowerSeries) =
    if r.len > self.len: self.setlen(r.len)
    for i in 0..<r.len: self[i] += r[i]
  proc `+=`*[T](self: var FormalPowerSeries[T], r:T) =
    if self.len == 0: self.setlen(1)
    self[0] += r
  
  proc `-=`*[T](self: var FormalPowerSeries[T], r:FormalPowerSeries[T]) =
    if r.len > self.len: self.setlen(r.len)
    for i in 0..<r.len: self[i] -= r[i]
    self.shrink()
  proc `-=`*[T](self: var FormalPowerSeries[T], r:T) =
    if self.len == 0: self.setlen(1)
    self[0] -= r
    self.shrink()
  
  proc `*=`*[T](self: var FormalPowerSeries[T], v:T) = self.applyIt(it * v)
  
  proc multRaw*[T](a:FormalPowerSeries[T], b:SparseFormalPowerSeries[T], deg = -1):FormalPowerSeries[T] =
    var deg = deg
    if deg == -1:
      var bdeg = 0
      for p in b: bdeg = max(bdeg, p[0])
      deg = a.len + bdeg
    result = initFormalPowerSeries[T](deg)
    for i in 0..<a.len:
      for (j, c) in b:
        let k = i + j
        if k < deg: result[k] += a[i] * c
  proc multRaw*[T](a, b:SparseFormalPowerSeries[T], deg = -1):SparseFormalPowerSeries[T] =
    var r = initTable[int,T]()
    for (i, c0) in a:
      for (j, c1) in b:
        let k = i + j
        if deg != -1 and k >= deg: continue
        if k notin r: r[k] = T(0)
        r[k] += c0 * c1
    return toSeq(r.pairs)
  
  proc `*=`*[T](self: var FormalPowerSeries[T],  r: FormalPowerSeries[T]) =
    if self.len == 0 or r.len == 0:
      self.setlen(0)
    else:
      when FastMult:
        var fft = self.getFFT()
        self = fft[].multiply(self, r)
      else:
        assert(false)
  
  proc `mod=`*[T](self: var FormalPowerSeries[T], r:FormalPowerSeries[T]) = self -= self div r * r
  
  proc `-`*[T](self: FormalPowerSeries[T]):FormalPowerSeries[T] =
    var ret = self
    ret.applyIt(-it)
    return ret
  proc `/=`*[T](self: var FormalPowerSeries[T], v:T) = self.applyIt(it / v)
  #}}}
  
  
  proc rev*[T](self: FormalPowerSeries[T], deg = -1):auto =
    result = self
    if deg != -1: result.setlen(deg)
    result.reverse
  
  proc pre*[T](self: FormalPowerSeries[T], sz:int):auto =
    result = self
    result.setlen(min(self.len, sz))
  
  proc dot*[T](self:FormalPowerSeries[T], r: FormalPowerSeries[T]):auto =
    result = initFormalPowerSeries[T](min(self.len, r.len))
    for i in 0..<result.len: result[i] = self[i] * r[i]
  
  proc `shr`*[T](self: FormalPowerSeries[T], sz:int):auto =
    if self.len <= sz: return initFormalPowerSeries[T](0)
    result = self
    if sz >= 1: result.delete(0, sz - 1)
  proc `shl`*[T](self: FormalPowerSeries[T], sz:int):auto =
    result = initFormalPowerSeries[T](sz)
    result = result & self
  
  proc diff*[T](self: FormalPowerSeries[T]):auto =
    let n = self.len
    result = initFormalPowerSeries[T](max(0, n - 1))
    for i in 1..<n:
      result[i - 1] = self[i] * T(i)
  
  proc integral*[T](self: FormalPowerSeries[T]):auto =
    let n = self.len
    result = initFormalPowerSeries[T](n + 1)
    result[0] = T(0)
    for i in 0..<n: result[i + 1] = self[i] / T(i + 1)
  
  # F(0) must not be 0
  proc inv*[T](self: FormalPowerSeries[T], deg = -1):auto =
    doAssert(self[0] != 0)
    deg.revise(self.len)
    when UseFFT:
      proc invFast[T](self: FormalPowerSeries[T]):auto =
        doAssert(self[0] != 0)
        let n = self.len
        var res = initFormalPowerSeries[T](1)
        res[0] = T(1) / self[0]
        var fft = self.getFFT()
        var d = 1
        while d < n:
          var f, g = initFormalPowerSeries[T](2 * d)
          for j in 0..<min(n, 2 * d): f[j] = self[j]
          for j in 0..<d: g[j] = res[j]
          let g1 = fft[].fft(g)
          f = fft[].ifft(fft[].dot(fft[].fft(f), g1))
          for j in 0..<d:
            f[j] = T(0)
            f[j + d] = -f[j + d]
          f = fft[].ifft(fft[].dot(fft[].fft(f), g1))
          f[0..<d] = res[0..<d]
          res = f
          d = d shl 1
        return res.pre(n)
      var ret = self
      ret.setlen(deg)
      return ret.invFast()
    else:
      var ret = initFormalPowerSeries[T](1)
      ret[0] = T(1) / self[0]
      var i = 1
      while i < deg:
        ret = (ret + ret - ret * ret * self.pre(i shl 1)).pre(i shl 1)
        i = i shl 1
      return ret.pre(deg)
  
  proc `div=`*[T](self: var FormalPowerSeries[T], r: FormalPowerSeries[T]) =
    if self.len < r.len:
      self.setlen(0)
    else:
      let n = self.len - r.len + 1
      self = (self.rev().pre(n) * r.rev().inv(n)).pre(n).rev(n)
  
  # operators +, -, *, div, mod {{{
  macro declareOp(op) =
    fmt"""proc `{op}`*[T](self:FormalPowerSeries[T];r:FormalPowerSeries[T] or T):FormalPowerSeries[T] = result = self;result {op}= r
  proc `{op}`*[T](self: not FormalPowerSeries, r:FormalPowerSeries[T]):FormalPowerSeries[T] = result = initFormalPowerSeries[T](@[self]);result {op}= r""".parseStmt
  
  declareOp(`+`)
  declareOp(`-`)
  declareOp(`*`)
  declareOp(`/`)
  
  proc `div`*[T](self, r:FormalPowerSeries[T]):FormalPowerSeries[T] = result = self;result.`div=` (r)
  proc `mod`*[T](self, r:FormalPowerSeries[T]):FormalPowerSeries[T] = result = self;result.`mod=` (r)
  # }}}
  
  # F(0) must be 1
  proc log*[T](self:FormalPowerSeries[T], deg = -1):auto =
    doAssert self[0] == T(1)
    deg.revise(self.len)
    return (self.diff() * self.inv(deg)).pre(deg - 1).integral()
  
  proc sqrt*[T](self: FormalPowerSeries[T], deg = -1):auto =
    let n = self.len
    deg.revise(n)
    if self[0] == 0:
      for i in 1..<n:
        if self[i] != 0:
          if (i and 1) > 0: return FormalPowerSeries[T].none
          if deg - i div 2 <= 0: break
          var opt = (self shr i).sqrt(deg - i div 2)
          if not opt.isSome: return FormalPowerSeries[T].none
          var ret = opt.get shl (i div 2)
          if ret.len < deg: ret.setlen(deg)
          return ret.some
      return initFormalPowerSeries[T](deg).some
  
    var ret:FormalPowerSeries[T]
    if self.isSetSqrt:
      let opt = self.getSqrt()(self[0])
      if not opt.isSome: return FormalPowerSeries[T].none
      ret = initFormalPowerSeries[T](@[T(opt.get)])
    else:
      doAssert(self[0] == 1)
      ret = initFormalPowerSeries[T](@[T(1)])
  
    let inv2 = T(1) / T(2);
    var i = 1
    while i < deg:
      ret = (ret + self.pre(i shl 1) * ret.inv(i shl 1)) * inv2
      i = i shl 1
    return ret.pre(deg).some
  
  import typetraits
  
  # F(0) must be 0
  proc exp*[T](self: FormalPowerSeries[T], deg = -1):auto =
    doAssert self[0] == 0
    deg.revise(self.len)
    when UseFFT:
      proc onlineConvolutionExp[T](self, conv_coeff:FormalPowerSeries[T]):auto =
        var fft = self.getFFT()
        let n = conv_coeff.len
        doAssert((n and (n - 1)) == 0)
        type FFTType = fft[].fft(initFormalPowerSeries[T](0)).type
        var
          conv_ntt_coeff = newSeq[FFTType]()
          i = n
        while (i shr 1) > 0:
          var g = conv_coeff.pre(i)
          conv_ntt_coeff.add(fft[].fft(g))
          i = i shr 1
        var conv_arg, conv_ret = initFormalPowerSeries[T](n)
        proc rec(l,r,d:int) =
          if r - l <= 16:
            for i in l..<r:
              var sum = T(0)
              for j in l..<i: sum += conv_arg[j] * conv_coeff[i - j]
              conv_ret[i] += sum
              conv_arg[i] = if i == 0: T(1) else: conv_ret[i] / i
          else:
            var m = (l + r) div 2
            rec(l, m, d + 1)
            var pre = initFormalPowerSeries[T](r - l)
            pre[0..<m-l] = conv_arg[l..<m]
            pre = fft[].ifft(fft[].dot(fft[].fft(pre), conv_ntt_coeff[d]))
            for i in 0..<r - m: conv_ret[m + i] += pre[m + i - l]
            rec(m, r, d + 1)
        rec(0, n, 0)
        return conv_arg
      proc expRec[T](self: FormalPowerSeries[T]):auto =
        doAssert self[0] == 0
        let n = self.len
        var m = 1
        while m < n: m *= 2
        var conv_coeff = initFormalPowerSeries[T](m)
        for i in 1..<n: conv_coeff[i] = self[i] * i
        return self.onlineConvolutionExp(conv_coeff).pre(n)
      var ret = self
      ret.setlen(deg)
      return ret.expRec()
    else:
      var
        ret = initFormalPowerSeries[T](@[T(1)])
        i = 1
      while i < deg:
        ret = (ret * (self.pre(i shl 1) + T(1) - ret.log(i shl 1))).pre(i shl 1);
        i = i shl 1
      return ret.pre(deg)
  
  proc exponent*[T](a:FormalPowerSeries[T]):FormalPowerSeries[T] =
    assert(a.len == 0 or a[0] == 0);
    var
      a = a
      b = initFormalPowerSeries[T]([1])
    while b.len < a.len:
      var x = a[0..<min(a.len, 2 * b.len)]
      x[0] += 1
      b.setLen(2 * b.len)
      x -= log(b)
      let l = b.len div 2
      x *= b[0..<l]
      for i in l..<min(x.len, b.len):
        b[i] = x[i]
    return b[0..<a.len]
  
  proc pow*[T](self: FormalPowerSeries[T], k:int, deg = -1):auto =
    var self = self
    let n = self.len
    deg.revise(n)
    self.setLen(deg)
    for i in 0..<n:
      if self[i] != T(0):
        let rev = T(1) / self[i]
        result = (((self * rev) shr i).log(deg) * T(k)).exp() * (self[i]^k)
        if i * k > deg: return initFormalPowerSeries[T](deg)
        result = (result shl (i * k)).pre(deg)
        if result.len < deg: result.setlen(deg)
        return
    return self
  
  proc eval*[T](self: FormalPowerSeries[T], x:T):T =
    var
      r = T(0)
      w = T(1)
    for v in self:
      r += w * v
      w *= x
    return r
  
  proc powMod*[T](self: FormalPowerSeries[T], n:int, M:FormalPowerSeries[T]):auto =
    let modinv = M.rev().inv()
    proc getDiv(base:FormalPowerSeries[T]):FormalPowerSeries[T] =
      var base = base
      if base.len < M.len:
        base.setlen(0)
        return base
      let n = base.len - M.len + 1
      return (base.rev().pre(n) * modinv.pre(n)).pre(n).rev(n)
    var
      n = n
      x = self
      ret = initFormalPowerSeries[T](@[T(1)])
    while n > 0:
      if (n and 1) > 0:
        ret *= x
        ret -= getDiv(ret) * M
      x *= x
      x -= getDiv(x) * M
      n = n shr 1
    return ret
  # }}}

