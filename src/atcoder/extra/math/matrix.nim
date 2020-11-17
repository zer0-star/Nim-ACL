when not declared ATCODER_MATRIX_HPP:
  const ATCODER_MATRIX_HPP* = 1
  import std/sequtils, std/sugar
  import atcoder/element_concepts

  type Matrix*[T; p:static[tuple]] = seq[seq[T]]
  type Vector*[T] = seq[T]
  
  proc height*(self: Matrix):int = self.len
  proc width*(self: Matrix):int = self[0].len
  template zero*(M:typedesc[Matrix]):auto = M.p[0]()
  template unit*(M:typedesc[Matrix]):auto = M.p[1]()
  template isZero*[M:Matrix](self:typedesc[M], a:M.T):bool = M.p[2](a)


  proc init*[M:Matrix](self:typedesc[M] or M, n, m:int):M =
    result = newSeqWith(n, newSeqWith(m, M.zero()))
  proc init*[M:Matrix](self:typedesc[M] or M, n:int):M = M.init(n, n)
  proc initMatrix*[T:RingElem](n, m:int, Zero:static[()->T], Unit:static[()->T]):auto = Matrix[T, (Zero, Unit)].init(n, m)
  proc initMatrix*[T:RingElem](n:int, Zero:static[()->T], Unit:static[()->T]):auto = Matrix[T, (Zero, Unit)].init(n, n)

  proc initMatrix*[T:RingElem](n, m:int):T = initMatrix(n, m, T, ()=>T(0), ()=>T(1))
  proc initMatrix*[T:RingElem](n:int):T = initMatrix(n, n, T)

  template getMatrixType*(T:typedesc):auto = Matrix[T, (()=>T(0), ()=>T(1), (a:T)=>(a == T(0)))]
  template getMatrixType*(T:typedesc, Zero:static[()->T], Unit:static[()->T]):auto = Matrix[T, (Zero, Unit, (a:T)=>(a == Zero()))]
  template getMatrixType*(T:typedesc, Zero:static[()->T], Unit:static[()->T], isZero:static[(T)->bool]):auto = Matrix[T, (Zero, Unit, isZero)]

  proc init*[M:Matrix](self:M or typedesc[M], a:seq or array):M =
    when a is seq[seq[M.T]]:
      return M(a)
    else:
      let (h, w) = (a.len, a[0].len)
      result = M.init(h, w)
      for i in 0..<result.height:
        for j in 0..<result.width:
          result[i][j] = M.T(a[i][j])

  proc initVector*[M:Matrix](self:M or typedesc[M], n:int):Vector[M.T] = Vector[M.T](newSeqWith(n, M.zero()))
  proc initVector*[M:Matrix](self:M or typedesc[M], a:seq or array):Vector[M.T] =
    when a is seq[M.T]:
      return a
    else:
      result = M.initVector(a.len)
      for i in 0..<a.len: result[i] = M.T(a[i])

  proc unit*[M:Matrix](self: typedesc[M], n:int):M =
    result = M.init(n)
    for i in 0..<n:
      result[i][i] = M.unit()
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
      for j in 0..<m:
        for k in 0..<p:
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

  proc `==`*[M:Matrix](A, B:M):bool =
    let (h, w) = (A.height, A.width)
    if B.height != h or B.width != w: return false
    for i in 0..<h:
      for j in 0..<w:
        if A[i][j] != B[i][j]: return false
    return true
  proc `!=`*[M:Matrix](A, B:M):bool = not (A == B)

  proc `$`*[M:Matrix](self: M):string =
    result = ""
    let (n,m) = (self.height, self.width)
    for i in 0..<n:
      result &= "["
      for j in 0..<m:
        result &= $(self[i][j])
        result &= (if j + 1 == m: "]\n" else: ",")
  
  proc determinant*[M:Matrix](self: M):auto =
    var B = self
    assert(self.width() == self.height())
    result = M.unit()
    for i in 0..<self.width:
      var idx = -1
      for j in i..<self.width:
        if not M.isZero(B[j][i]):
          idx = j;break
      if idx == -1:
        return M.zero()
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
