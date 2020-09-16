# verify-helper: PROBLEM https://judge.yosupo.jp/problem/scc

include src/nim_acl/header
include src/nim_acl/scc

block:
  let N, M = nextInt()
  var
    scc = initSccGraph(N)
  for i in 0..<M:
    let a, b = nextInt()
    scc.add_edge(a, b)
  var a = scc.scc()
  echo a.len
  for a in a:
    echo a.len, " ", a.join(" ")
