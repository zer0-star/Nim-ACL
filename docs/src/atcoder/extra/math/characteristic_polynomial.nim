when not declared ATCODER_CHARACTERISTIC_POLYNOMIAL_HPP:
  const ATCODER_CHARACTERISTIC_POLYNOMIAL_HPP* = 1
  import atcoder/extra/math/matrix
  import std/random, std/options, std/sequtils
  

  # 特性多項式を計算する
  proc characteristicPolynomial*[M:SomeMatrix](A:M):seq[M.T] =
    mixin inv
    type Elem = M.T
    type LocalMat = object
      data:seq[seq[Elem]]
      rows, cols:seq[int]
    proc initLocalMat(n:int):LocalMat =
      result.data = newSeqWith(n, newSeq[Elem](n))
      result.rows = (0 ..< n).toSeq
      result.cols = (0 ..< n).toSeq
    proc `[]`(self: var LocalMat, i, j:int):var Elem = self.data[self.rows[i]][self.cols[j]]
    proc `[]=`(self: var LocalMat, i, j:int, a:Elem) = self.data[self.rows[i]][self.cols[j]] = a
    assert A.height == A.width
    let n = A.height
    var mat = initLocalMat(n)
    for i in 0 ..< n:
      for j in 0 ..< n:
        mat[i, j] = A[i, j]
    if n == 0: return @[Elem(1)]
    var T = newSeq[Elem](n)
    for y in 1 ..< n:
      var y1 = y
      while y1<n and mat[y1, y-1] == Elem(0): y1.inc
      if y1 == n: continue
      if y != y1:
        swap mat.rows[y], mat.rows[y1]
        swap mat.cols[y], mat.cols[y1]
      T[y] = mat[y, y-1].inv()
      for y2 in y + 1 ..< n: T[y2] = T[y] * mat[y2, y-1]
      for y2 in y + 1 ..< n:
        for x in y - 1 ..< n:
          mat[y2, x] -= mat[y, x] * T[y2]
      for y2 in 0 ..< n:
        for x in y+1 ..< n:
          mat[y2, y] += mat[y2, x] * T[x]
    for y in 0 ..< n:
      var tmp = Elem(1)
      for x in y + 1 ..< n:
        tmp *= -mat[x, x-1]
        mat[y, x] *= tmp
    var dp = newSeqWith(n + 1, newSeq[Elem](n + 1))
    dp[0][0] = 1
    for y in 0 ..< n:
      for x in 0 .. y: dp[y+1][x+1] -= dp[y][x]
      for x in 0 .. y: dp[y+1][x] += dp[y][x] * mat[y, y]
      for y2 in 0 ..< y:
        for x in 0 .. y2: dp[y+1][x] += dp[y2][x] * mat[y2, y]
    result = newSeq[Elem](n + 1)
    for i in 0 .. n: result[i] = if n mod 2 == 1: -dp[n][i] else: dp[n][i]
