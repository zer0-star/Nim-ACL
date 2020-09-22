include atcoder/header
import atcoder/mincostflow

let n, k = nextInt()
var g = initMCFGraph[int,int](n * 2 + 2)
let (s, t) = (n * 2, n * 2 + 1)
let BIG = 1000000000

g.add_edge(s, t, n * k, BIG)

for i in 0..<n:
  g.add_edge(s, i, k, 0)
  g.add_edge(n + i, t, k, 0)

for i in 0..<n:
  for j in 0..<n:
    let a = nextInt()
    g.add_edge(i, n + j, 1, BIG - a)

var result = g.flow(s, t, n * k)
echo n * k * BIG - result[1]

var grid = newSeqWith(n, '.'.repeat(n))
let es = g.edges()
for e in es:
  if e.src == s or e.dst == t or e.flow == 0: continue
  grid[e.src][e.dst - n] = 'X'

for i in 0..<n:
  echo grid[i]
