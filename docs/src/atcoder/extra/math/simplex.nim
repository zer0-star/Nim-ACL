when not declared ATCODER_SIMPLEX_HPP:
  const ATCODER_SIMPLEX_HPP* = 1
  type TwoStageSimplexResult* = enum
    OPTIMAL, UNBOUNDED, NOSOLUTION, UNKNOWN
  import std/sequtils, std/math
  
  proc twoStageSimplex*[T](A: seq[seq[T]], b, c:seq[T]):tuple[status:TwoStageSimplexResult, v:T ,x:seq[T]] =
    var EPS = T.getEps()
    #if sizeof(T) == 16:
    #  EPS = T(1) / T(10^11)
    #elif sizeof(T) == 8:
    #  EPS = T(1) / T(10^9)


    var
      (A, b, c) = (A, b, c)
      (N, M) = (A.len, A[0].len)
      a = newSeqWith(N + 2, newSeqWith(M + N + 1, T(0)))
      s = newSeq[int](N + 2)

    for i in 0 ..< N:
      let u = b[i] < -EPS
      if u:
        b[i] = -b[i]
        for j in 0 ..< M:
          A[i][j] = -A[i][j]
    for j in 0 ..< M: a[N + 1][j] = c[j].clone()
    for i in 0 ..< N:
      for j in 0 ..< M:
        a[i+1][j] = A[i][j].clone()
    for i in 0 ..< N: a[i+1][M+N] = b[i].clone() # add helper table
    for i in 0 ..< N: a[ 0 ][i+M] = T(1)
    for i in 0 ..< N: a[i+1][i+M] = T(1)
    for i in 0 ..< N: s[i+1]      = i+M
    for i in 1 .. N:
      for j in 0 .. N + M:
        a[0][j] -= a[i][j]
    proc print() =
      echo "s = ", s
      echo "a = "
      for i in 0 ..< a.len:
        echo a[i].join("\t")

    proc solve():TwoStageSimplexResult =
      proc solve_sub():TwoStageSimplexResult =
        proc pivot(p, q:int) =
          for j in 0 .. N:
            for k in countdown(M, 0):
              if j != p and k != q:
                a[j][k] -= a[p][k] * a[j][q] / a[p][q]
          for j in 0 .. N:
            if j != p: a[j][q] = T(0)
          for k in 0 .. M:
            if k != q:
              a[p][k] = a[p][k] / a[p][q]
          a[p][q] = T(1)
          s[p] = q

        var p, q: int
        while true:
          q = 0
          while q < M and a[0][q] >= -EPS: q.inc
          if q >= M: break
          p = 0
          while p <= N and a[p][q] <= EPS: p.inc
          if p > N:
            break
          for i in p + 1 ..< N: # bland's care for cyclation
            if a[i][q] > EPS:
              let
                l = a[i][M] / a[i][q]
                r = a[p][M] / a[p][q]
              if l + EPS < r or (l < r + EPS and s[i] < s[q]): p = i
          pivot(p, q)
        if q >= M: return OPTIMAL
        else:   return UNBOUNDED

      M += N
      N += 1
      discard solve_sub() # solve stage one
      if -a[0][M] > EPS: return NOSOLUTION
      N -= 1; M -= N
      swap a[0], a[^1]
      discard a.pop() # modify table
      for i in 0 .. N:
        #swap a[i][M], a[i][^1]
        block:
          var tmp = a[i][M].clone()
          a[i][M] = a[i][^1].clone()
          a[i][^1] = tmp
        a[i].setLen(M + 1)
  
      return solve_sub() # solve stage two
  
    result.status = solve()
    if result.status == OPTIMAL:
      var x: seq[T] 
      proc solution():T =
        x = newSeqWith(M, T(0))
        for i in 0 ..< N:
          if s[i + 1] in 0 ..< x.len:
            x[s[i+1]] = a[i+1][^1]
          else:
            discard
        return -a[0][M]
      result.v = solution()
      result.x = x
