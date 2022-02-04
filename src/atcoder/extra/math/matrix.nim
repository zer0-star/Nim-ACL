when not declared ATCODER_MATRIX_HPP:
  const ATCODER_MATRIX_HPP* = 1
  import std/sequtils
  import atcoder/generate_definitions

  type Matrix*[T; p:static[tuple]] = seq[seq[T]]
  type Vector*[T] = seq[T]

  proc height*(self: Matrix):int = self.len
  proc width*(self: Matrix):int = self[0].len
  template getZero*[M:Matrix](self:typedesc[M] or M):auto =
    block:
      let zero = M.p[0]
      zero()
  template getUnit*[M:Matrix](self:typedesc[M] or M):auto =
    block:
      let unit = M.p[1]
      unit()
  template isZero*[M:Matrix](self:typedesc[M] or M, a:M.T):bool =
    block:
      let isZero = M.p[2]
      isZero(a)

  proc init*[M:Matrix](self:typedesc[M] or M, n, m:int):M =
    result = newSeqWith(n, newSeqWith(m, M.getZero()))
  proc init*[M:Matrix](self:typedesc[M] or M, n:int):M = M.init(n, n)

  template MatrixType*(T:typedesc, zero, unit, isZero:untyped):auto =
    Matrix[T, ((proc():T)zero, (proc():T)unit, (proc (a:T):bool)isZero)]
  template MatrixType*(T:typedesc):auto =
    MatrixType(T, zero = proc():T = T(0), unit = proc():T = T(1), isZero = proc(a:T):bool = (a == T(0)))
  template MatrixType*(T:typedesc, zero, unit:untyped):auto =
    MatrixType(T, zero, unit, proc(a:T):bool = (a == zero()))

  proc initVector*[M:Matrix](self:M or typedesc[M], n:int):Vector[M.T] = Vector[M.T](newSeqWith(n, M.getZero()))
  proc initVector*[M:Matrix](self:M or typedesc[M], a:seq or array):Vector[M.T] =
    when a is seq[M.T]:
      return a
    else:
      result = M.initVector(a.len)
      for i in 0..<a.len: result[i] = M.T(a[i])

  proc init*[M:Matrix](self:M or typedesc[M], a:seq or array):auto =
    when a is seq[seq[M.T]]:
      return M(a)
    else:
      when a[0] is seq or a[0] is array:
        let (h, w) = (a.len, a[0].len)
        result = M.init(h, w)
        for i in 0..<result.height:
          for j in 0..<result.width:
            result[i][j] = M.T(a[i][j])
      else:
        return M.initVector(a)

  proc unit*[M:Matrix](self: typedesc[M], n:int):M =
    result = M.init(n)
    for i in 0..<n:
      result[i][i] = M.getUnit()
  proc unit*[M:Matrix](self: M, n = -1):M =
    let n = if n == -1: self.height else: n
    return M.unit(n)

  proc `+=`*[M:Matrix](self: var M, B: M) =
    let (n, m) = (self.height, self.width)
    assert n == B.height() and m == B.width()
    for i in 0..<n:
      for j in 0..<m:
        self[i][j] = self[i][j] + B[i][j]
  proc `+=`*[T](self: var Vector[T], B:Vector[T]) =
    let n = self.len
    for i in 0..<n:
      self[i] = self[i] + B[i]

  proc `-=`*[M:Matrix](self: var M, B: M) =
    let (n, m) = (self.height, self.width)
    assert n == B.height() and m == B.width()
    for i in 0..<n:
      for j in 0..<m:
        self[i][j] = self[i][j] - B[i][j]
  
  proc `*=`*[M:Matrix](self: var M, B: M) =
    let (n,m,p) = (self.height, B.width, self.width)
    assert p == B.height
    var C = M.init(n, m)
    for i in 0..<n:
      for k in 0..<p:
        for j in 0..<m:
          C[i][j] = C[i][j] + self[i][k] * B[k][j]
    swap(self, C)
  proc `*`*[M:Matrix](self: M, v: Vector[M.T]): Vector[M.T] =
    let (n, m) = (self.height, self.width)
    result = M.initVector(n)
    assert(v.len == m)
    for i in 0..<n:
      for j in 0..<m:
          result[i] = result[i] + self[i][j] * v[j]
  
  proc `+`*[M:Matrix](self: M, B:M):auto =
    result = self; result += B
  proc `-`*[M:Matrix](self: M, B:M):auto =
    result = self; result -= B
  proc `*`*[M:Matrix](self: M, B:M):auto =
    result = self; result *= B
  proc `+`*[T](self, B:Vector[T]):auto =
    result = self; result += B


  proc equals*[M:Matrix](A, B:M):bool =
    let (h, w) = (A.height, A.width)
    if B.height != h or B.width != w: return false
    for i in 0..<h:
      for j in 0..<w:
        if not A.isZero(A[i][j] - B[i][j]): return false
    return true

  proc toString*[M:Matrix](self: M):string =
    result = ""
    let (n,m) = (self.height, self.width)
    result &= "[\n"
    for i in 0..<n:
      result &= "  "
      for j in 0..<m:
        result &= $(self[i][j])
        result &= (if j + 1 == m: "\n" else: ", ")
    result &= "]"

  proc determinant*[M:Matrix](self: M):auto =
    var B = self
    assert self.width == self.height
    result = M.getUnit()
    for i in 0..<self.width:
      var idx = -1
      for j in i..<self.width:
        if not M.isZero(B[j][i]):
          idx = j;break
      if idx == -1:
        return M.getZero()
      if i != idx:
        result = -result
        swap(B[i], B[idx])
      result *= B[i][i]
      let vv = B[i][i]
      for j in 0..<self.width:
        B[i][j] /= vv
      for j in i+1..<self.width:
        let a = B[j][i]
        for k in 0..<self.width:
          B[j][k] -= B[i][k] * a

  proc gaussianElimination*[M:Matrix](A:M):(M, seq[int]) =
    let
      (n, m) = (A.height, A.width)
    var
      A = A
      ids = newSeq[int]()
      j = 0
    for i in 0..<n:
      while j < m:
        var pivot = -1
        for ii in i..<n:
          if not M.isZero(A[ii][j]):
            pivot = ii
            break
        if pivot != -1:
          swap(A[i], A[pivot])
          break
        j.inc
      if j == m: break
      let d = M.T(1) / A[i][j]
      for jj in j..<m: A[i][jj] *= d
      for ii in 0..<n:
        if ii == i: continue
        let d = A[ii][j]
        for jj in j..<m: A[ii][jj] -= A[i][jj] * d
      ids.add(j)
      j.inc
    return (A, ids)
  
  import std/options

  proc linearEquations*[M:Matrix](A:M, b:Vector[M.T]):Option[(Vector[M.T], seq[Vector[M.T]])] =
    let (n, m) = (A.height, A.width)
    assert n == b.len
    var A = A
    for i in 0..<n: A[i].add(b[i])
    let (B, ids) = A.gaussianElimination()
    if ids.len > 0 and ids[^1] == m:
      return none[(Vector[M.T], seq[Vector[M.T]])]()
    var
      s = ids.toHashSet()
      id = newSeq[int](m)
      ct = 0
      v = newSeq[Vector[M.T]]()
      x = M.initVector(m)
    for j in 0..<m:
      if j notin s:
        id[j] = ct
        ct.inc
        var v0 = M.initVector(m)
        v0[j] = M.T(1)
        v.add(v0)
    for i,ip in ids:
      x[ip] = B[i][^1]
      for j in 0..<m:
        if j in s: continue
        v[id[j]][ip] -= B[i][j]
    return (x, v).some
  
  proc inv*[M:Matrix](A:M):M =
    assert A.height == A.width
    let n = A.height
    var A2 = M.init(n, n * 2)
    for i in 0..<n:
      for j in 0..<n:
        A2[i][j] = A[i][j]
      A2[i][i + n] = M.getUnit()
    let (G, ids) = A2.gaussianElimination()
    result = M.init(n)
    assert ids == (0..<n).toSeq
    for i in 0..<n:
      for j in 0..<n:
        result[i][j] = G[i][j + n]

  generatePow(Matrix)
