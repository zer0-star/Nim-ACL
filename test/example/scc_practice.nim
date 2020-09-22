include atcoder/header
import atcoder/scc as scc_lib

let n, m = nextInt()

var g = init_scc_graph(n)

for i in 0..<m:
  let u, v = nextInt()
  g.add_edge(u, v)

var scc = g.scc()

echo scc.len
for v in scc:
  echo v.len, " ", v.join(" ")
