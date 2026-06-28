when not declared ATCODER_HUNGARIAN_HPP:
  const ATCODER_HUNGARIAN_HPP* = 1
  import std/sequtils
  proc hungarian*[T](A:seq[seq[T]]):(T, seq[int]) =
    let
      N = A.len + 1
      M = A[0].len + 1
    var
      P = newSeq[int](M)
      way = newSeq[int](M)
      U = newSeqWith(N, 0)
      V = newSeqWith(M, 0)
      minV:seq[int]
      used:seq[bool]
    for i in 1..<N:
      P[0] = i
      minV = newSeqWith(M, T.inf)
      used = newSeqWith(M, false)
      var j0 = 0
      while P[j0] != 0:
        var (i0, j1) = (P[j0], 0)
        used[j0] = true
        var delta = T.inf
        for j in 1..<M:
          if used[j]: continue
          let curr = A[i0-1][j-1] - U[i0] - V[j]
          if curr < minV[j]: minV[j] = curr; way[j] = j0
          if minV[j] < delta: delta = minV[j]; j1 = j
        for j in 0..<M:
          if used[j]: U[P[j]] += delta; V[j] -= delta
          else: minV[j] -= delta
        j0 = j1
      while true:
        P[j0] = P[way[j0]];
        j0 = way[j0];
        if j0 == 0: break
    var Q = newSeq[int](N - 1)
    for j in 1..<M:
      Q[P[j] - 1] = j - 1
    return (-V[0], Q)
