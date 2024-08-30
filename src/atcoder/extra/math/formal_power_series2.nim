when not declared ATCODER_FORMAL_POWER_SERIES:
  const ATCODER_FORMAL_POWER_SERIES* = 1
  
  import std/sequtils, std/strformat, std/options, std/macros, std/tables, std/algorithm, std/strutils, std/typetraits
  import atcoder/element_concepts

  type FormalPowerSeries*[T:FieldElem] = object
    data*:seq[T]

  proc `[]`*[T:FieldElem](self:FormalPowerSeries[T], i:int or BackwardsIndex):T =
    when i is BackwardsIndex: (let i = self.len - int(i))
    self.data[i]
  proc `[]`*[T:FieldElem](self:var FormalPowerSeries[T], i:int or BackwardsIndex):var T =
    when i is BackwardsIndex: (let i = self.len - int(i))
    self.data[i]
  proc `[]=`*[T:FieldElem](self:var FormalPowerSeries[T], i:int or BackwardsIndex, a:T) =
    when i is BackwardsIndex: (let i = self.len - int(i))
    self.data[i] = a

  proc len*[T:FieldElem](self: FormalPowerSeries[T]):int = len(self.data)

  type Poly*[T:FieldElem] = FormalPowerSeries[T]
  type FPS*[T:FieldElem] = FormalPowerSeries[T]

  template hasFFT*(T:typedesc):bool =
    mixin fft
    type hasFFTC = concept x
      @[x].fft()
    T is hasFFTC

  template initFormalPowerSeries*[T:FieldElem](n:int):FormalPowerSeries[T] =
    block:
      FormalPowerSeries[T](data:newSeq[T](n))
  proc initFormalPowerSeries*[T:FieldElem](data:seq or array):FormalPowerSeries[T] {.inline.} =
    type U = data.elementType
    block:
      var a = newSeq[T](data.len)
      for i, it in data:
        a[i] = when U is T: it else: T(it)
      FormalPowerSeries[T](data:a)


  template init*[T:FieldElem](self:typedesc[FormalPowerSeries[T]], data:typed):auto =
    initFormalPowerSeries[T](data)

  # {{{ sparseFormalPowerSeries

  type SparseFormalPowerSeries*[T:FieldElem] = object
    data*:seq[tuple[d:int, c:T]] # sorted ascending order

  proc len*[T:FieldElem](self: SparseFormalPowerSeries[T]):int = len(self.data)

  proc `$`*(f:SparseFormalPowerSeries): string {.inline.} =
    type T = f.T
    if f.len == 0:
      return $(T(0))
    else:
      var s:seq[string]
      for (d, c) in f.data:
        if d == 0:
          s.add $(c)
        else:
          s.add $(c) & " x^" & $(d)
      return s.join(" + ")

  proc initVar*[T](c = 1, d = 1):SparseFormalPowerSeries[T] =
    result.data = @[(d:d, c:T(c))]
  
  proc `^`*[T](f:SparseFormalPowerSeries[T], n:int):SparseFormalPowerSeries[T] =
    assert f.len == 1
    result.data.add(f.data[0])
    result.data[0].d *= n
    if f.data[0].c != T(1): result.data[0].c = result.data[0].c ^ n

  proc toSparseFormalPowerSeries*[T](f:Table[int, T]):SparseFormalPowerSeries[T] =
    for d, c in f.pairs:
      result.data.add((d, c))
    result.data.sort do (x, y:(int, T)) -> int:
      cmp(x[0], y[0])

  proc deg*[T](a:SparseFormalPowerSeries[T]):int =
    if a.len == 0: return int.low
    else: return a.data[^1].d
  proc `+=`*[T](a:var SparseFormalPowerSeries[T], b:SparseFormalPowerSeries[T]) =
    var r:SparseFormalPowerSeries[T]
    var i, j = 0
    while i < a.len or j < b.len:
      if i < a.len and j < b.len and a.data[i].d == b.data[j].d:
        r.data.add((a.data[i].d, a.data[i].c + b.data[j].c))
        i.inc;j.inc
      else:
        if j == b.len or (i < a.len and a.data[i].d < b.data[j].d):
          r.data.add(a.data[i]);i.inc
        else:
          r.data.add(b.data[j]);j.inc
    swap(r, a)
  proc `+=`*[T](a:var SparseFormalPowerSeries[T], b:T) = a += SparseFormalPowerSeries[T](data: @[(0, b)])
  proc `+=`*[T](a:var FormalPowerSeries[T], b:SparseFormalPowerSeries[T]) =
    for p in b.data:
      while a.len <= p.d: a.data.add(T(0))
      a.data[p.d] += p.c
  proc `-=`*[T](a:var SparseFormalPowerSeries[T], b:SparseFormalPowerSeries[T]) =
    var r:SparseFormalPowerSeries[T]
    var i, j = 0
    while i < a.len or j < b.len:
      if i < a.len and j < b.len and a.data[i].d == b.data[j].d:
        r.add((a.data[i].d, a.data[i].c - b.data[j].c))
        i.inc;j.inc
      else:
        if j == b.len or (i < a.len and a.data[i].d < b.data[j].d):
          r.add(a.data[i]);i.inc
        else:
          r.add((b.data[j].d, -b.data[j].c));j.inc
    swap(r, a)
  proc `-=`*[T](a:var SparseFormalPowerSeries[T], b:T) = a -= SparseFormalPowerSeries[T](data: @[(0, b)])
  proc `-=`*[T](a:var FormalPowerSeries[T], b:SparseFormalPowerSeries[T]) =
    for p in b.data:
      while a.len <= p.d: a.data.add(T.init(0))
      a[p.d] -= p.c

  proc `*`*[T](a:FormalPowerSeries[T], b:SparseFormalPowerSeries[T], deg = -1):FormalPowerSeries[T] =
    var deg = deg
    if deg == -1:
      let bdeg = b.data[^1][0]
      deg = a.len + bdeg
    result = initFormalPowerSeries[T](deg)
    for i in 0..<a.len:
      for (j, c) in b.data:
        let k = i + j
        if k < deg: result[k] += a[i] * c
  proc `*=`*[T](a:var SparseFormalPowerSeries[T], b:SparseFormalPowerSeries[T], deg = -1) =
    var r = initTable[int,T]()
    for (i, c0) in a.data:
      for (j, c1) in b.data:
        let k = i + j
        if deg != -1 and k >= deg: continue
        if k notin r: r[k] = T(0)
        r[k] += c0 * c1
    var rs = toSparseFormalPowerSeries[T](r)
    swap(rs, a)
  proc `*=`*[T](a:var SparseFormalPowerSeries[T], b:T) =
    for (i, c) in a.data.mitems:
      c = c * b
  proc `*`*[T](a:SparseFormalPowerSeries[T], b:T):SparseFormalPowerSeries[T] =
    result = a
    result *= b
  proc `*`*[T](b:T, a:var SparseFormalPowerSeries[T]):SparseFormalPowerSeries[T] =
    result = a
    for (i, c) in result.data.mitems:
      c = b * c

  macro declareSparseFormalPowerSeriesOperators(op, op_eq) =
    result = quote do:
      proc `op`*[T](self:SparseFormalPowerSeries[T];r:SparseFormalPowerSeries[T] or T):SparseFormalPowerSeries[T] = result = self;`op_eq`(result, r)
      proc `op`*[T; U: not SparseFormalPowerSeries](self: U, r:SparseFormalPowerSeries[T]):SparseFormalPowerSeries[T] =
        result = SparseFormalPowerSeries[T](data: @[(0, T(self))]);`op_eq`(result, r)

  declareSparseFormalPowerSeriesOperators(`+`, `+=`)
  declareSparseFormalPowerSeriesOperators(`-`, `-=`)
  declareSparseFormalPowerSeriesOperators(`*`, `*=`)

  proc divMod*[T](a: FormalPowerSeries[T], b:SparseFormalPowerSeries[T]):(FormalPowerSeries[T], FormalPowerSeries[T]) =
    mixin inv
    var a = a
    let
      max_deg = b.data[^1][0]
      inv_max_coef = b.data[^1][1].inv
    var q = initFormalPowerSeries[T](a.len - max_deg)
    for i in countdown(q.len - 1, 0):
      q[i] = a[i + max_deg] * inv_max_coef
      for (d, v) in b.data:
        a[i + d] -= q[i] * v
    return (q, initFormalPowerSeries[T](a.data[0..<max_deg]))
  proc `div`*[T:FieldElem](a: FormalPowerSeries[T], b:SparseFormalPowerSeries[T]):auto = a.divMod(b)[0]
  proc `mod`*[T:FieldElem](a: FormalPowerSeries[T], b:SparseFormalPowerSeries[T]):auto = a.divMod(b)[1]

  proc EQUAL*[T](a, b:T):bool =
    when T is hasInf:
      return (abs(a - b) < T(0.0000001))
    else:
      return a == b

  proc `$`*(f:FormalPowerSeries): string {.inline.} =
    type T = f.T
    if f.len == 0:
      return $(T(0))
    else:
      var s:seq[string]
      for i in 0 ..< len(f):
        if i != len(f) - 1 and EQUAL(f[i], T(0)): continue
        if i == 0:
          s.add $(f[i])
        else:
          s.add $(f[i]) & " x^" & $(i)
      return s.join(" + ")

  macro revise*(a, b) =
    parseStmt(fmt"""let {a.repr} = if {a.repr} == -1: {b.repr} else: {a.repr}""")
  proc shrink*[T](self: var FormalPowerSeries[T]) =
    while self.len > 0 and EQUAL(self.data[^1], T(0)): discard self.data.pop()
  proc resize*[T](self: var FormalPowerSeries[T], n:int) =
    mixin setLen
    let l = self.len
    self.data.setLen(n)
    if l < n:
      self.data.fill(l, n - 1, T(0))

  #converter toFPS*[T](a:seq[T]):FormalPowerSeries[T] =
  #  FormalPowerSeries[T](data:a)

  proc `^`*[T](f:typedesc[FormalPowerSeries[T]], n:int):FormalPowerSeries[T] = initFormalPowerSeries[T](n + 1)

  converter toFPS*[T](f:SparseFormalPowerSeries[T]):FormalPowerSeries[T] =
    let deg = f.deg
    if deg < 0: return
    result.resize(deg + 1)
    for (d, c) in f.data:
      result[d] = c

  # operators +=, -=, *=, mod=, -, /= {{{
  proc `+=`*[T](self: var FormalPowerSeries[T], r:FormalPowerSeries[T]) =
    if r.len > self.len: self.resize(r.len)
    for i in 0..<r.len: self[i] += r[i]
  proc `+=`*[T](self: var FormalPowerSeries[T], r:T) =
    if self.len == 0: self.resize(1)
    self[0] += r
  
  proc `-=`*[T](self: var FormalPowerSeries[T], r:FormalPowerSeries[T]) =
    if r.len > self.len: self.resize(r.len)
    for i in 0..<r.len: self[i] -= r[i]
#    self.shrink()
  proc `-=`*[T](self: var FormalPowerSeries[T], r:T) =
    if self.len == 0: self.resize(1)
    self[0] -= r
#    self.shrink()

  proc `*=`*[T](self: var FormalPowerSeries[T], v:T) = self.data.applyIt(it * v)

  proc mult_naive*[T](a, b:FormalPowerSeries[T]):FormalPowerSeries[T] =
    result = initFormalPowerSeries[T](a.len + b.len - 1)
    for i in 0..<a.len:
      for j in 0..<b.len:
        result.data[i + j] += a[i] * b[j]
  proc div_naive*[T](a, b:FormalPowerSeries[T], deg = -1):FormalPowerSeries[T] =
    mixin inv
    var deg = if deg == -1: a.len else: deg
    result = newSeq[T](deg)
    # a = b * result
    var b0inv = b[0].inv
    for i in 0 ..< deg:
      var u = a[i]
      for j in 1 ..< min(i + 1, b.len):
        u -= b[j] * result[i - j]
      u *= b0inv
      result[i] = u

  proc `*=`*[T](self: var FormalPowerSeries[T],  r: FormalPowerSeries[T]) =
    if self.len == 0 or r.len == 0:
      self.resize(0)
    else:
      when T.hasFFT:
        mixin multiply
        block:
          var x = multiply(r.data, r.data)
        self.data = multiply(self.data, r.data)
      else:
        static:
          echo("Warning: multiply is slow, please write import atcoder/extra/math/ntt")
        self = mult_naive(self, r)

  proc `mod=`*[T](self: var FormalPowerSeries[T], r:FormalPowerSeries[T]) =
    self -= (self div r) * r
    self.resize(r.len - 1)
    self.shrink()
  #proc `divMod`*[T](self, r: FormalPowerSeries[T]):(FPS[T], FPS[T]) =
  #  var self = self
  #  let q = self div r
  #  self -= q * r
  #  self.resize(r.len - 1)
  #  self.shrink()
  #  return (q, self)

  proc `-`*[T](self: FormalPowerSeries[T]):FormalPowerSeries[T] =
    var ret = self
    ret.applyIt(-it)
    return ret
  proc `/=`*[T](self: var FormalPowerSeries[T], v:T) = self.applyIt(it / v)
  #}}}

  proc rev*[T](self: FormalPowerSeries[T], deg = -1):auto =
    result = self
    if deg != -1: result.resize(deg)
    result.data.reverse
  
  proc pre*[T](self: FormalPowerSeries[T], sz:int):auto =
    result = self
    result.resize(min(self.len, sz))
  
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
    assert(not EQUAL(self[0], T(0)))
    deg.revise(self.len)
#    type F = T.get_fft_type()
#    when T is ModInt:
    when true:
      proc invFast[T](self: FormalPowerSeries[T]):auto =
#        assert(self[0] != T(0))
        let n = self.len
        #var res = initFormalPowerSeries[T](1)
        var res = @[T(1) / self[0]]
        var d = 1
        while d < n:
          var f, g = newSeq[T](2 * d)
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
        var r = initFormalPowerSeries[T](res)
        return r.pre(n)
      var ret = self
      ret.resize(deg)
      return ret.invFast()
    else:
      var ret = initFormalPowerSeries[T](1)
      ret[0] = T(1) / self[0]
      var i = 1
      while i < deg:
        ret = (ret + ret - ret * ret * self.pre(i shl 1)).pre(i shl 1)
        i = i shl 1
      return ret.pre(deg)
  proc `/=`*[T](self: var FormalPowerSeries[T], r: FormalPowerSeries[T]) =
    when T.hasFFT():
      self *= r.inv()
    else:
      static:
        echo("Warning: div is slow, please write import atcoder/extra/math/ntt")
      self = self.divNaive(r)

  proc `div=`*[T](self: var FormalPowerSeries[T], r: FormalPowerSeries[T]) =
    if self.len < r.len:
      self.resize(0)
    else:
      let n = self.len - r.len + 1
      self = (self.rev().pre(n) * r.rev().inv(n)).pre(n).rev(n)

# operators +, -, *, div, mod {{{
  macro declareFormalPowerSeriesOperators(op, op_eq) =
    result = quote do:
      proc `op`*[T](self:FormalPowerSeries[T];r:FormalPowerSeries[T] or T):FormalPowerSeries[T] = result = self;`op_eq`(result, r)
      proc `op`*[T](self: not FormalPowerSeries, r:FormalPowerSeries[T]):FormalPowerSeries[T] = result = initFormalPowerSeries[T](@[T(self)]);`op_eq`(result, r)

  declareFormalPowerSeriesOperators(`+`, `+=`)
  declareFormalPowerSeriesOperators(`-`, `-=`)
  declareFormalPowerSeriesOperators(`*`, `*=`)
  declareFormalPowerSeriesOperators(`/`, `/=`)
  
  proc `div`*[T](self, r:FormalPowerSeries[T]):FormalPowerSeries[T] = result = self;result.`div=` (r)
  proc `mod`*[T](self, r:FormalPowerSeries[T]):FormalPowerSeries[T] = result = self;result.`mod=` (r)
  # }}}
  
  # F(0) must be 1
  proc log*[T](self:FormalPowerSeries[T], deg = -1):auto =
    assert EQUAL(self[0], T(1))
    deg.revise(self.len)
    return (self.diff() * self.inv(deg)).pre(deg - 1).integral()

  proc expFast[T:FieldElem](self: FormalPowerSeries[T], deg:int):FormalPowerSeries[T] =
    deg.revise(self.len)
    assert EQUAL(self[0], T(0))

    var inv = newSeqOfCap[T](deg + 1)
    inv.add(T(0))
    inv.add(T(1))

    proc inplace_integral(F:var seq[T]) =
      let
        n = F.len
      when T is FiniteFieldElem:
        let
          M = T.mod
      while inv.len <= n:
        let i = inv.len
        when T is FiniteFieldElem:
          inv.add((-inv[M mod i]) * (M div i))
        else:
          inv.add(T(1)/T(i))
      F = @[T(0)] & F
      for i in 1..n: F[i] *= inv[i]

    proc inplace_diff(F:var seq[T]):auto =
      if F.len == 0: return
      F = F[1..<F.len]
      var coeff = T(1)
      let one = T(1)
      for i in 0..<F.len:
        F[i] *= coeff
        coeff += one
    mixin fft, ifft, dot
    type FFTType = fft(@[T(0)]).type
    mixin inplace_partial_dot
    var
      b = @[T(1), if 1 < self.len: self[1] else: T(0)]
      c = @[T(1)]
      z1f:FFTType
      z2 = @[T(1), T(0)]
      z2f = z2.fft
    var m = 2
    while m < deg:
      var y = b
      y.setLen(2 * m)
      var yf = y.fft
      z1f = z2f
      var zf = yf
      zf.setLen(m)
      inplace_partial_dot(zf, z1f, 0..<m, T)
      var z = zf.ifft(T)
      for i in 0..<m div 2: z[i] = T(0)
      zf = z.fft
      z = ifft(dot(zf, z1f, T), T)
      for i in 0..<m:z[i] *= -1
      c = c & z[m div 2..^1]
      z2 = c
      z2.setLen(2 * m)
      z2f = z2.fft
      var x = initFormalPowerSeries[T](self.data[0..<min(self.len, m)]) # xだけFPS
      inplace_diff(x.data)
      x.data.add(T(0))
      var xf = x.data.fft
      inplace_partial_dot(xf, yf, 0..<m, T)
      x = initFormalPowerSeries[T](xf.ifft(T))
      x -= initFormalPowerSeries[T](b).diff()
      x.resize(2 * m)
      for i in 0..<m - 1: x[m + i] = x[i]; x[i] = T(0)
      xf = x.data.fft
      inplace_partial_dot(xf, z2f, 0..<2*m, T)
      x.data = xf.ifft(T)
      discard x.data.pop()
      inplace_integral(x.data)
      for i in m..<min(self.len, 2 * m): x[i] += self[i]
      for i in 0..<m: x[i] = T(0)
      xf = x.data.fft
      inplace_partial_dot(xf, yf, 0..<2*m, T)
      x.data = xf.ifft(T)
      b = b & x.data[m..^1]
      m *= 2
    return initFormalPowerSeries[T](b[0..<deg])

#   F(0) must be 0
  proc exp*[T](self: FormalPowerSeries[T], deg = -1):FormalPowerSeries[T] =
    assert EQUAL(self[0], T(0))
    deg.revise(self.len)

    when T is FiniteFieldElem:
      var self = self
      self.resize(deg)
      return self.expFast(deg)
    else:
      var
        ret = initFormalPowerSeries[T](@[T(1)])
        i = 1
      while i < deg:
        ret = (ret * (self.pre(i shl 1) + T(1) - ret.log(i shl 1))).pre(i shl 1)
        i = i shl 1
      return ret.pre(deg)

  proc pow*[T:FieldElem](self: FormalPowerSeries[T], k:int, deg = -1):FormalPowerSeries[T] =
    mixin pow, init
    var self = self
    deg.revise(self.len)
    if k == 0:
      result = initFormalPowerSeries[T](deg)
      result[0] = T(1)
      return
    self.resize(deg)
    for i in 0..<deg:
      if not EQUAL(self[i], T(0)):
        let rev = T(1) / self[i]
        result = (((self * rev) shr i).log(deg) * T.init(k)).exp() * (self[i].pow(k))
        #if i * k > deg:
        var p:int
        if i == 0: p = 0
        elif k > deg: p = deg + 1
        else: p = i * k
        if p > deg:
          return initFormalPowerSeries[T](deg)
        result = (result shl (i * k)).pre(deg)
        if result.len < deg: result.resize(deg)
        return
    return self

  proc eval*[T](self: FormalPowerSeries[T], x:T):T =
    var
      (r, w) = (T(0), T(1))
    for v in self.data:
      r += w * v
      w *= x
    return r

  {.push experimental: "callOperator".}
  template `()`*[T](self: FormalPowerSeries[T], x:T):T = self.eval(x)
  {.pop.}

  proc powMod*[T](self: FormalPowerSeries[T], n:int, M:FormalPowerSeries[T]):auto =
    assert not EQUAL(M[^1], T(0))
    let modinv = M.rev().inv()
    proc getDiv(base:FormalPowerSeries[T]):FormalPowerSeries[T] =
      var base = base
      if base.len < M.len:
        base.resize(0)
        return base
      let n = base.len - M.len + 1
      return (base.rev().pre(n) * modinv.pre(n)).pre(n).rev(n)
    var
      n = n
      x = self
    result = initFormalPowerSeries[T](M.len - 1)
    result[0] = T(1)
    while n > 0:
      if (n and 1) > 0:
        result *= x
        result -= getDiv(result) * M
        result = result.pre(M.len - 1)
      x *= x
      x -= getDiv(x) * M
      x = x.pre(M.len - 1)
      n = n shr 1
  proc gcdImpl*[T](a, b:FormalPowerSeries[T]):FormalPowerSeries[T] =
    if a.len < b.len: return gcdImpl(b, a)
    if b.len == 0: return a
    let r = a mod b
    #echo a.len, " ", b.len, " ", r.len
    return gcdImpl(b, r)
  proc gcd*[T](a, b:FormalPowerSeries[T]):FormalPowerSeries[T] =
    var (a, b) = (a, b)
    a.shrink
    b.shrink
    return gcdImpl(a, b)

when isMainModule:
  import atcoder/modint
  type mint = modint998244353
  var a, b = initFormalPowerSeries[mint](3)
  echo a * b
