# verify-helper: PROBLEM https://yukicoder.me/problems/no/1490

import atcoder/header
import atcoder/extra/dp/dual_cumulative_sum_2d
import atcoder/extra/dp/cumulative_sum_2d

let H, W, N, M = nextInt()
var T, U, L, R, A = newSeq[int](N)
for i in 0..<N:
  T[i] = nextInt() - 1
  U[i] = nextInt() - 1
  L[i] = nextInt() - 1
  R[i] = nextInt() - 1
  A[i] = nextInt()

var cs = initDualCumulativeSum2D[int](H, W)

for i in 0..<M:
  var X, Y, B, C = nextInt()
  X.dec;Y.dec
  var xl = max(X - B, 0)
  var yl = max(Y - B, 0)
  var xr = min(X + B, H - 1)
  var yr = min(Y + B, W - 1)
  cs.add(xl..xr, yl..yr, C)

cs.build()

var cs2 = initCumulativeSum2D[int](H, W)

for i in 0..<H:
  for j in 0..<W:
    var d = cs[i, j]
    cs2.add(i, j, d)

cs2.build()

var ans = 0

for i in 0..<N:
  var d = cs2[T[i]..U[i], L[i]..R[i]]
  if d < A[i]: ans.inc

echo ans
