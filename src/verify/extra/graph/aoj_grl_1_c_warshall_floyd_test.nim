# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_C

include atcoder/header
import atcoder/extra/graph/warshall_floyd

proc main() =
  var
    V = nextInt()
    E = nextInt()
    mat = newSeqWith(V, newSeqWith(V, int.inf))
  for i in 0..<V: mat[i][i] = 0
  for i in 0..<E:
    var x, y, z = nextInt()
    mat[x][y] = z
  mat = warshall_floyd(mat)
  for i in 0..<V:
    if mat[i][i] < 0:
      echo "NEGATIVE CYCLE"
      return
  for i in 0..<V:
    for j in 0..<V:
      if j > 0: stdout.write " "
      if mat[i][j] == int.inf: stdout.write "INF"
      else: stdout.write mat[i][j]
    echo ""

main()
