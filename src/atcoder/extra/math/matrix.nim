when not declared ATCODER_MATRIX_HPP:
  const ATCODER_MATRIX_HPP* = 1
  import std/sequtils, std/algorithm
  import atcoder/generate_definitions

  type StaticMatrix*[T; N, M:static[int];Vector;p:static[tuple]] = object
    data*:array[N, array[M, T]]
  type DynamicMatrix*[T;Vector;p:static[tuple]] = object
    N*, M*:int
    data*:seq[T]
  type DynamicVector*[T] = seq[T]
  type StaticMatrixObj*[T; p:static[tuple]] =
    object
  type StaticVector*[T; N:static[int]] = array[N, T]

  type SomeMatrix* = StaticMatrix | DynamicMatrix
  type SomeVector* = StaticVector | DynamicVector

  template height*(self: DynamicMatrix):int = self.N
  template height*[M:StaticMatrix](self: M):int = M.N
  template width*(self: DynamicMatrix):int = self.M
  template width*[M:StaticMatrix](self: M):int = M.M
  template getZero*[M:SomeMatrix | StaticMatrixObj](self:typedesc[M] or M):auto =
    block:
      M.p.zero()
  template getUnit*[M:SomeMatrix | StaticMatrixObj](self:typedesc[M] or M):auto =
    block:
      M.p.unit()
  template isZero*[M:SomeMatrix | StaticMatrixObj](self:typedesc[M] or M, a:M.T):bool =
    block:
      M.p.isZero(a)
  proc getSeq[M:DynamicMatrix](A:M):seq[seq[M.T]] =
    result = newSeq[seq[M.T]](A.N)
    for i in 0..<A.N:
      result[i] = A.data[i * A.M ..< (i + 1) * A.M]

  proc `[]`*[M:StaticMatrix](self:M, i, j:int):M.T = self.data[i][j]
  proc `[]=`*[M:StaticMatrix](self:var M, i, j:int, a:M.T) = self.data[i][j] = a
  proc `[]`*[M:DynamicMatrix](self:M, i, j:int):M.T =
    self.data[i * self.M + j]
  proc `[]=`*[M:DynamicMatrix](self:var M, i, j:int, a:M.T) =
    self.data[i * self.M + j] = a

  proc init*[M:DynamicMatrix](self:typedesc[M] or M, n, m:int):M =
    result.N = n;result.M = m
    result.data.setLen(n * m)
    for i in 0..<result.data.len:
      result.data[i] = M.getZero()
  proc init*[M:DynamicMatrix](self:typedesc[M] or M, n:int):M = M.init(n, n)
  proc init*[M:StaticMatrixObj | StaticMatrix](self:typedesc[M] or M, n, m:static[int]):auto =
    const
      zero = M.p.zero
      unit = M.p.unit
      isZero = M.p.isZero
    var A: StaticMatrix[M.T, n, m, StaticVector[M.T, m], (zero:zero, unit:unit, isZero:isZero)]
    for i in 0 ..< n:
      for j in 0 ..< m:
        A[i, j] = M.getZero()
    return A
  proc init*[M:StaticMatrixObj | StaticMatrix](self:typedesc[M] or M, n:static[int]):auto = M.init(n, n)

  template DynamicMatrixType*(T:typedesc, zero0, unit0, isZero0:untyped):auto =
    DynamicMatrix[T, DynamicVector[T], (zero:(proc():T)(zero0), unit:(proc():T)(unit0), isZero:(proc (a:T):bool)(isZero0))]
  template DynamicMatrixType*(T:typedesc):auto =
    DynamicMatrixType(T, proc():T = T(0), proc():T = T(1), proc(a:T):bool = (a == T(0)))
  template DynamicMatrixType*(T:typedesc, zero, unit:untyped):auto =
    DynamicMatrixType(T, zero, unit, proc(a:T):bool = (a == zero()))
  
  template StaticMatrixType*(T:typedesc, zero0, unit0, isZero0:untyped):auto =
    StaticMatrixObj[T, (zero:(proc():T)(zero0), unit:(proc():T)(unit0), isZero:(proc (a:T):bool)(isZero0))]
  template StaticMatrixType*(T:typedesc):auto =
    StaticMatrixType(T, proc():T = T(0), proc():T = T(1), proc(a:T):bool = (a == T(0)))
  template StaticMatrixType*(T:typedesc, zero, unit:untyped):auto =
    StaticMatrixType(T, zero, unit, proc(a:T):bool = (a == zero()))

  proc initVector*[M:DynamicMatrix](self:M or typedesc[M], n:int):DynamicVector[M.T] = DynamicVector[M.T](newSeqWith(n, M.getZero()))
  proc initVector*[M:DynamicMatrix, T](self:M or typedesc[M], a:openArray[T]):DynamicVector[M.T] =
    result = M.initVector(a.len)
    for i in 0..<a.len: result[i] = M.T(a[i])
  proc initVector*[M:StaticMatrix | StaticMatrixObj](self:M or typedesc[M], n:static[int]):StaticVector[M.T, n] =
    var a:array[n.int, M.T]
    return a
  proc initVector*[M:StaticMatrix | StaticMatrixObj, n:static[int], S](self:M or typedesc[M], a:array[n, S]):StaticVector[M.T, n] =
    result = M.initVector(a.len)
    for i in 0..<a.len: result[i] = M.T(a[i])

  proc init*[M:DynamicMatrix](self:M or typedesc[M], a:seq or array):auto =
    when a is seq[seq[M.T]]:
      return M(a)
    else:
      when a[0] is seq or a[0] is array:
        let (h, w) = (a.len, a[0].len)
        result = M.init(h, w)
        for i in 0..<result.height:
          for j in 0..<result.width:
            result[i, j] = M.T(a[i][j])
      else:
        return M.initVector(a)

  proc init*[M:StaticMatrixObj | StaticMatrix; n:static[int], S](self:M or typedesc[M], a:array[n, S]):auto =
    return M.initVector(a)
  proc init*[M:StaticMatrixObj | StaticMatrix; n, m:static[int], S](self:M or typedesc[M], a:array[n, array[m, S]]):auto =
    const h = a.len
    const w = a[0].len
    result = M.init(h, w)
    for i in 0..<result.height:
      for j in 0..<result.width:
        result[i, j] = M.T(a[i][j])

  proc unit*[M:DynamicMatrix](self: typedesc[M], n:int):M =
    result = M.init(n)
    for i in 0..<n:
      result[i, i] = M.getUnit()
  proc unit*[M:DynamicMatrix](self: M, n = -1):M =
    let n = if n == -1: self.height else: n
    return M.unit(n)
  proc unit*[M:StaticMatrix](self: typedesc[M], n:static[int]):M =
    result = M.init(n)
    for i in 0..<n:
      result[i, i] = M.getUnit()
  proc unit*[M:StaticMatrix](self: M, n:static[int] = -1):M =
    when n == -1:
      M.unit(self.height)
    else:
      M.unit(n)

  proc `+=`*[M:SomeMatrix](self: var M, B: M) =
    let (n, m) = (self.height, self.width)
    assert n == B.height() and m == B.width()
    for i in 0..<n:
      for j in 0..<m:
        self[i, j] = self[i, j] + B[i, j]
  proc `+=`*[V:SomeVector](self: var V, B:V) =
    let n = self.len
    for i in 0..<n:
      self[i] = self[i] + B[i]

  proc `-=`*[M:SomeMatrix](self: var M, B: M) =
    let (n, m) = (self.height, self.width)
    assert n == B.height() and m == B.width()
    for i in 0..<n:
      for j in 0..<m:
        self[i, j] = self[i, j] - B[i, j]
  
  proc `*=`*[M:SomeMatrix](self: var M, B: M) =
    #let (n,m,p) = (self.height, B.width, self.width)
    #assert p == B.height
    var C = M.init(self.height, B.width)
    for i in 0..<self.height:
      for k in 0..<self.width:
        for j in 0..<B.width:
          C[i, j] = C[i, j] + self[i, k] * B[k, j]
    self = C.move
  proc `*`*[M:SomeMatrix](self: M, v: M.Vector): auto =
    result = M.initVector(self.height)
    assert(v.len == self.width)
    for i in 0..<self.height:
      for j in 0..<self.width:
          result[i] = result[i] + self[i, j] * v[j]
  
  proc `+`*[M:SomeMatrix](self: M, B:M):auto =
    result = self; result += B
  proc `-`*[M:SomeMatrix](self: M, B:M):auto =
    result = self; result -= B
  proc `*`*[M:SomeMatrix](self: M, B:M):auto =
    result = self; result *= B
  proc `+`*[T](self, B:DynamicVector[T]):auto =
    result = self; result += B


  proc equals*[M:SomeMatrix](A, B:M):bool =
    let (h, w) = (A.height, A.width)
    if B.height != h or B.width != w: return false
    for i in 0..<h:
      for j in 0..<w:
        if not A.isZero(A[i, j] - B[i, j]): return false
    return true

  proc toString*[M:SomeMatrix](self: M):string =
    result = ""
    let (n,m) = (self.height, self.width)
    result &= "[\n"
    for i in 0..<n:
      result &= "  "
      for j in 0..<m:
        result &= $(self[i, j])
        result &= (if j + 1 == m: "\n" else: ", ")
    result &= "]"

  proc determinant*[M:SomeMatrix](self: M):auto =
    var B = self.getSeq
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

  proc gaussianElimination*[M:SomeMatrix](A:M):(seq[seq[M.T]], seq[int]) =
    let
      (n, m) = (A.height, A.width)
    var
      A = A.getSeq
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

  proc linearEquations*[M:SomeMatrix](A:M, b:SomeVector):auto =
    let (n, m) = (A.height, A.width)
    assert n == b.len
    var A = A
    for i in 0..<n: A[i].add(b[i])
    let (B, ids) = A.gaussianElimination()
    if ids.len > 0 and ids[^1] == m:
      return none[(M.vector, seq[M.Vector])]()
    var
      s = ids.toHashSet()
      id = newSeq[int](m)
      ct = 0
      v = newSeq[M.Vector]()
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
  
  proc inv*[M:SomeMatrix](A:M):M =
    assert A.height == A.width
    let n = A.height
    var A2 = M.init(n, n * 2)
    for i in 0..<n:
      for j in 0..<n:
        A2[i, j] = A[i, j]
      A2[i, i + n] = M.getUnit()
    let (G, ids) = A2.gaussianElimination()
    result = M.init(n)
    assert ids == (0..<n).toSeq
    for i in 0..<n:
      for j in 0..<n:
        result[i, j] = G[i][j + n]

  generatePow(StaticMatrix)
  generatePow(DynamicMatrix)
