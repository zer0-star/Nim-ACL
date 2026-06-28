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
  let dist = warshall_floyd(mat)
  for i in 0..<V:
    if dist[i][i] < 0:
      echo "NEGATIVE CYCLE"
      return
  for i in 0..<V:
    for j in 0..<V:
      if j > 0: stdout.write " "
      if dist[i][j] == int.inf: stdout.write "INF"
      else:
        let p = dist.path(i, j)
        var s = 0
        for k in 0..<p.len - 1: s += mat[p[k]][p[k + 1]]
        assert s == dist[i][j]
        stdout.write dist[i][j]
    echo ""

main()
