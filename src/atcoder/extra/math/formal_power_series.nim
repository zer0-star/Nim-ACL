# FormalPowerSeries {{{
when not declared ATCODER_FORMAL_POWER_SERIES:
  const ATCODER_FORMAL_POWER_SERIES* = 1
  
  import std/sequtils, std/strformat, std/options, std/macros, std/tables
  
  import atcoder/element_concepts

  type FormalPowerSeries*[T:FieldElem] = seq[T]
  type SparseFormalPowerSeries*[T:FieldElem] = seq[(int, T)]

  proc initFormalPowerSeries*[T:FieldElem](n:int):FormalPowerSeries[T] =
    FormalPowerSeries[T](newSeq[T](n))
  proc initFormalPowerSeries*[T:FieldElem](v:seq or array):FormalPowerSeries[T] =
    when v is FormalPowerSeries[T]: return v
    else:
      result = newSeq[T](data.len)
      for i, it in data:
        result[i] = T.init(it)
  template init*[T:FieldElem](self:typedesc[FormalPowerSeries[T]], data:typed):auto =
    initFormalPowerSeries[T](data)

  macro revise*(a, b) =
    parseStmt(fmt"""let {a.repr} = if {a.repr} == -1: {b.repr} else: {a.repr}""")
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
#    self.shrink()
  proc `-=`*[T](self: var FormalPowerSeries[T], r:T) =
    if self.len == 0: self.setlen(1)
    self[0] -= r
#    self.shrink()

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
      mixin multiply
#      when T is ModInt:
      self = multiply(self, r)
#        when T is StaticModInt and T.isGoodMod:
#          self = convolution.convolution(self, r)
#        else:
#          self = arbitrary_mod_convolution.convolution(self, r)
#      else:
#        var res = initFormalPowerSeries[T](self.len + r.len - 1)
#        for i in 0..<self.len:
#          for j in 0..<r.len:
#            res += self[i] * r[j]
#        swap(self, res)
 
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
    assert(self[0] != 0)
    deg.revise(self.len)
#    type F = T.get_fft_type()
#    when T is ModInt:
    when true:
      proc invFast[T](self: FormalPowerSeries[T]):auto =
        assert(self[0] != 0)
        let n = self.len
        var res = initFormalPowerSeries[T](1)
        res[0] = T(1) / self[0]
        var d = 1
        while d < n:
          var f, g = initFormalPowerSeries[T](2 * d)
          for j in 0..<min(n, 2 * d): f[j] = self[j]
          for j in 0..<d: g[j] = res[j]
          let g1 = fft(g)
          f = ifft(dot(fft(f), g1, T), T)
          for j in 0..<d:
            f[j] = T(0)
            f[j + d] = -f[j + d]
          f = ifft(dot(fft(f), g1, T), T)
          f[0..<d] = res[0..<d]
          res = f
          d = d shl 1
        return res.pre(n)
      var ret = self
      ret.setlen(deg)
      return ret.invFast()
#    else:
#      var ret = initFormalPowerSeries[T](1)
#      ret[0] = T(1) / self[0]
#      var i = 1
#      while i < deg:
#        ret = (ret + ret - ret * ret * self.pre(i shl 1)).pre(i shl 1)
#        i = i shl 1
#      return ret.pre(deg)
  proc `/=`*[T](self: var FormalPowerSeries[T], r: FormalPowerSeries[T]) =
    self *= r.inv()

  proc `div=`*[T](self: var FormalPowerSeries[T], r: FormalPowerSeries[T]) =
    if self.len < r.len:
      self.setlen(0)
    else:
      let n = self.len - r.len + 1
      self = (self.rev().pre(n) * r.rev().inv(n)).pre(n).rev(n)
  
#  template toFormalPowerSeries[T](f:FormalPowerSeries[T] or T or SomeNumber):auto =
#    when f is SomeNumber or f is T: initFormalPowerSeries[T](@[T(f)])
#    else: initFormalPowerSeries[T](f)

  # operators +, -, *, div, mod {{{
  macro declareOp(op) =
    fmt"""proc `{op}`*[T](self:FormalPowerSeries[T];r:FormalPowerSeries[T] or T):FormalPowerSeries[T] = result = self;result {op}= r
proc `{op}`*[T](self: not FormalPowerSeries, r:FormalPowerSeries[T]):FormalPowerSeries[T] = result = initFormalPowerSeries[T](@[T(self)]);result {op}= r""".parseStmt
  
  declareOp(`+`)
  declareOp(`-`)
  declareOp(`*`)
  declareOp(`/`)
  
  proc `div`*[T](self, r:FormalPowerSeries[T]):FormalPowerSeries[T] = result = self;result.`div=` (r)
  proc `mod`*[T](self, r:FormalPowerSeries[T]):FormalPowerSeries[T] = result = self;result.`mod=` (r)
  # }}}
  
  # F(0) must be 1
  proc log*[T](self:FormalPowerSeries[T], deg = -1):auto =
    assert self[0] == T(1)
    deg.revise(self.len)
    return (self.diff() * self.inv(deg)).pre(deg - 1).integral()

  # F(0) must be 0
  proc exp*[T](self: FormalPowerSeries[T], deg = -1):auto =
    assert self[0] == 0
    deg.revise(self.len)
#    when T is ModInt:
    when true:
      proc onlineConvolutionExp[T](self, conv_coeff:FormalPowerSeries[T]):auto =
        let n = conv_coeff.len
        assert((n and (n - 1)) == 0)
        type FFTType = fft(initFormalPowerSeries[T](0)).type
        var
          conv_ntt_coeff = newSeq[FFTType]()
          i = n
        while (i shr 1) > 0:
          var g = conv_coeff.pre(i)
          conv_ntt_coeff.add(fft(g))
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
            pre = ifft(dot(fft(pre), conv_ntt_coeff[d], T), T)
            for i in 0..<r - m: conv_ret[m + i] += pre[m + i - l]
            rec(m, r, d + 1)
        rec(0, n, 0)
        return conv_arg
      proc expRec[T](self: FormalPowerSeries[T]):auto =
        assert self[0] == 0
        let n = self.len
        var m = 1
        while m < n: m *= 2
        var conv_coeff = initFormalPowerSeries[T](m)
        for i in 1..<n: conv_coeff[i] = self[i] * i
        return self.onlineConvolutionExp(conv_coeff).pre(n)
      var ret = self
      ret.setlen(deg)
      return ret.expRec()
#    else:
#      var
#        ret = initFormalPowerSeries[T](@[T(1)])
#        i = 1
#      while i < deg:
#        ret = (ret * (self.pre(i shl 1) + T(1) - ret.log(i shl 1))).pre(i shl 1);
#        i = i shl 1
#      return ret.pre(deg)
  
#  proc exponent*[T](a:FormalPowerSeries[T]):FormalPowerSeries[T] =
#    assert(a.len == 0 or a[0] == 0);
#    var
#      a = a
#      b = initFormalPowerSeries[T]([1])
#    while b.len < a.len:
#      var x = a[0..<min(a.len, 2 * b.len)]
#      x[0] += 1
#      b.setLen(2 * b.len)
#      x -= log(b)
#      let l = b.len div 2
#      x *= b[0..<l]
#      for i in l..<min(x.len, b.len):
#        b[i] = x[i]
#    return b[0..<a.len]
  proc pow*[T:FieldElem](self: FormalPowerSeries[T], k:int, deg = -1):FormalPowerSeries[T] =
    mixin pow, init
    var self = self
    let n = self.len
    deg.revise(n)
    self.setLen(deg)
    for i in 0..<n:
      if self[i] != T(0):
        let rev = T(1) / self[i]
        result = (((self * rev) shr i).log(deg) * T.init(k)).exp() * (self[i].pow(k))
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
