# verify-helper: PROBLEM https://judge.yosupo.jp/problem/maximum_independent_set

include atcoder/header

include atcoder/extra/graph/maximum_independent_set

proc main() =
  var
    N = nextInt()
    M = nextInt()
    g = newSeqWith(N, newSeqWith(N, 0))
  for i in 0..<M:
    let u, v = nextInt()
    g[u][v] = 1
    g[v][u] = 1
  
  let p = g.maximum_independent_set()
  echo p.len
  for i in 0..<p.len:
    stdout.write p[i]
    if i < p.len - 1: stdout.write " "
  echo ""

main()
