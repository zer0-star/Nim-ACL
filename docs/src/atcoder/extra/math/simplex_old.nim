#when false:
when not declared ATCODER_SIMPLEX_HPP:
  const ATCODER_SIMPLEX_HPP* = 1
  import atcoder/extra/math/matrix

  const EPS = 1e-8
  type Status = enum
    OPTIMAL, UNBOUNDED, NOSOLUTION, UNKNOWN
  type two_stage_simplex*[T] = object
    N, M:int
    st:Status
    a:MatrixType(T)
    s:seq[int]
 
  proc status*[T](self:two_stage_simplex[T]):Status = self.st
  proc solution*[T](self:two_stage_simplex[T]):tuple[val:T, x:seq[T]] = 
    var x = newSeq[T](self.M)
    for i in 0..<self.N:
      x[self.s[i+1]] = self.a[i+1][^1]
    return (-self.a[0][self.M], x)
  proc solve*[T](self:var two_stage_simplex[T]):Status =
    self.M += self.N; self.N += 1
    self.solve_sub() # solve stage one
    if self.solution().val > EPS: return NOSOLUTION
    self.N -= 1; self.M -= self.N
    swap self.a[0], self.a[^1]; discard self.a.pop() # modify table
    for i in 0..self.N:
      swap self.a[i][self.M], self.a[i][^1]
      self.a[i].setlen(self.M+1)
    return self.solve_sub() # solve stage two
  proc solve_sub*[T](self:var two_stage_simplex[T]):Status {.discardable.} =
    var p, q:int
    while true:
      #print();
      q = 0
      while q <= self.M and self.a[0][q] >= -EPS: q.inc
      if q >= self.M: break
      p = 0
      while p <= self.N and self.a[p][q] <= EPS: p.inc
      if p > self.N: break
      for i in p+1..self.N: # bland's care for cyclation
        if self.a[i][q] > EPS:
          let
            l = self.a[i][self.M]/self.a[i][q]
            r = self.a[p][self.M]/self.a[p][q]
          if l < r or (l == r and self.s[i] < self.s[q]):
            p = i
          #if self.a[i][self.M]/self.a[i][q] < self.a[p][self.M]/self.a[p][q] or
          #   (self.a[i][self.M]/self.a[i][q] == self.a[p][self.M]/self.a[p][q] and self.s[i] < self.s[q]):
          #  p = i
      self.pivot(p, q)
    if q >= self.M: return OPTIMAL
    else: return UNBOUNDED
  proc pivot*[T](self: var two_stage_simplex[T], p, q:int) =
    for j in 0..self.N:
      for k in countdown(self.M, 0):
        if j != p and k != q:
          self.a[j][k] -= self.a[p][k]*self.a[j][q]/self.a[p][q]
    for j in 0..self.N:
      if j != p: self.a[j][q] = 0
    for k in 0..self.M:
      if k != q: self.a[p][k] = self.a[p][k]/self.a[p][q]
    self.a[p][q] = T(1)
    self.s[p] = q

  proc init_two_stage_simplex*[T](A:MatrixType(float), b, c:seq[T]):two_stage_simplex[T] =
    let
      N = A.len
      M = A[0].len
    var
      a = MatrixType(T).init(N + 2, M + N + 1)
      s = newSeq[int](N + 2)
    for j in 0..<M: a[N+1][j] = c[j] # make simplex table
    for i in 0..<N:
      for j in 0..<M:
        a[i+1][j] = A[i][j]
    for i in 0..<N: a[i+1][M+N] = b[i] # add helper table
    for i in 0..<N: a[ 0 ][i+M] = 1
    for i in 0..<N: a[i+1][i+M] = 1
    for i in 0..<N: s[i+1]      = i+M
    for i in 1..N:
      for j in 0..N+M:
        a[0][j] += a[i][j];
    result = two_stage_simplex[T](N:N, M:M, st:Status.UNKNOWN, a:a, s:s)
    result.st = result.solve()

#block:
#  type MT = MatrixType(float)
#  var A = MT.init(
#    [
#      [1, 2, 1, 0, 0], 
#      [1, 1, 0, 1, 0], 
#      [3, 1, 0, 0, 1]
#    ]
#  )
#  var b = MT.initVector([14, 8, 18])
#  var c = MT.initVector([-2, -3, 0, 0, 0])
#  echo A, b, c
#  var tss = init_two_stage_simplex(A, b, c)
#  echo tss.solution


