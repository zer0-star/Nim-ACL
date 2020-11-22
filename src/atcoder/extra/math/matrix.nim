when not declared ATCODER_MATRIX_HPP:
  const ATCODER_MATRIX_HPP* = 1
  import std/sequtils, std/sugar
  import atcoder/element_concepts, atcoder/generate_definitions

  type Matrix*[T; p:static[tuple]] = seq[seq[T]]
  type Vector*[T] = seq[T]

  proc height*(self: Matrix):int = self.len
  proc width*(self: Matrix):int = self[0].len
  template getZero*[M:Matrix](self:typedesc[M] or M):auto =
    block:
      let zero = M.p.zero
      zero()
  template getUnit*[M:Matrix](self:typedesc[M] or M):auto =
    block:
      let unit = M.p.unit
      unit()
  template isZero*[M:Matrix](self:typedesc[M] or M, a:M.T):bool =
    block:
      let isZero = M.p.isZero
      isZero(a)

  proc init*[M:Matrix](self:typedesc[M] or M, n, m:int):M =
    result = newSeqWith(n, newSeqWith(m, M.getZero()))
  proc init*[M:Matrix](self:typedesc[M] or M, n:int):M = M.init(n, n)

  template getMatrixType*(T:typedesc):auto = Matrix[T, (zero:()=>T(0), unit:()=>T(1), isZero:(a:T)=>(a == T(0)))]
  template getMatrixType*(T:typedesc, z0:static[()->T], u0:static[()->T]):auto = Matrix[T, (zero:z0, unit:u0, isZero:(a:T)=>(a == z0()))]
  template getMatrixType*(T:typedesc, z0:static[()->T], u0:static[()->T], iz0:static[(T)->bool]):auto = Matrix[T, (zero:z0, unit:u0, isZero:iz0)]

  proc initMatrix*[T:RingElem](n, m:int, z:static[()->T], u:static[()->T]):auto =
    type M = getMatrixType(T, z, u)
    return M.init(n, m)
  proc initMatrix*[T:RingElem](n:int, z:static[()->T], u:static[()->T]):auto = 
    type M = getMatrixType(T, z, u)
    return M.init(n, n)

  proc initMatrix*[T:RingElem](n, m:int):T =
    type M = getMatrixType(T)
    return M.init(n, m)
  proc initMatrix*[T:RingElem](n:int):T =
    type M = getMatrixType(T)
    return M.init(n, n)

  proc init*[M:Matrix](self:M or typedesc[M], a:seq or array):M =
    when a is seq[seq[M.T]]:
      return M(a)
    else:
      let (h, w) = (a.len, a[0].len)
      result = M.init(h, w)
      for i in 0..<result.height:
        for j in 0..<result.width:
          result[i][j] = M.T(a[i][j])

  proc initVector*[M:Matrix](self:M or typedesc[M], n:int):Vector[M.T] = Vector[M.T](newSeqWith(n, M.getZero()))
  proc initVector*[M:Matrix](self:M or typedesc[M], a:seq or array):Vector[M.T] =
    when a is seq[M.T]:
      return a
    else:
      result = M.initVector(a.len)
      for i in 0..<a.len: result[i] = M.T(a[i])

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
        self[i][j] += B[i][j]
  
  proc `-=`*[M:Matrix](self: var M, B: M) =
    let (n, m) = (self.height, self.width)
    assert n == B.height() and m == B.width()
    for i in 0..<n:
      for j in 0..<m:
        self[i][j] -= B[i][j]
  
  proc `*=`*[M:Matrix](self: var M, B: M) =
    let (n,m,p) = (self.height, B.width, self.width)
    assert p == B.height
    var C = M.init(n, m)
    for i in 0..<n:
      for k in 0..<p:
        for j in 0..<m:
          C[i][j] += self[i][k] * B[k][j]
    swap(self, C)
  proc `*`*[M:Matrix](self: M, v: Vector[M.T]): Vector[M.T] =
    let (n, m) = (self.height, self.width)
    result = M.initVector(n)
    assert(v.len == m)
    for i in 0..<n:
      for j in 0..<m:
          result[i] += self[i][j] * v[j]
  
  proc `+`*[M:Matrix](self: M, B:M):auto =
    result = self; result += B
  proc `-`*[M:Matrix](self: M, B:M):auto =
    result = self; result -= B
  proc `*`*[M:Matrix](self: M, B:M):auto =
    result = self; result *= B

  generatePow(Matrix)

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
