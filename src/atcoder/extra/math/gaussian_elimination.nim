when not declared ATCODER_GAUSSIAN_ELIMINATION_HPP:
  const ATCODER_GAUSSIAN_ELIMINATION_HPP* = 1
  import std/sets, std/sequtils
  import atcoder/extra/math/matrix

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
      A2[i][i + n] = M.p[1]() # unit
    let (G, ids) = A2.gaussianElimination()
    result = M.init(n)
    assert ids == (0..<n).toSeq
    for i in 0..<n:
      for j in 0..<n:
        result[i][j] = G[i][j + n]
