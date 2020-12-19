# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_2_A

include atcoder/header
import atcoder/extra/graph/boruvka

proc main() =
  let V, E = nextInt()
  var X, Y, Z = newSeq[int](E)
  for i in 0..<E:
    X[i] = nextint()
    Y[i] = nextint()
    Z[i] = nextint()

  var mst = initBoruvka[int](V)
  proc f(ret:var seq[(int,int)]) =
    for i in 0..<E:
      X[i] = mst.find(X[i])
      Y[i] = mst.find(Y[i])
      if X[i] == Y[i]: continue
      ret[X[i]] = min(ret[X[i]], (Z[i], Y[i]))
      ret[Y[i]] = min(ret[Y[i]], (Z[i], X[i]))
  echo mst.build(f)

main()
