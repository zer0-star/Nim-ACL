include atcoder/header
import atcoder/maxflow

let n, m = nextInt()
var grid = newSeqWith(n, nextString())

# generate (s -> even grid -> odd grid -> t) graph
# grid(i, j) correspond to vertex (i * m + j)
var g = initMFGraph[int](n * m + 2)
let
  s = n * m
  t = n * m + 1;

# s -> even / odd -> t
for i in 0..<n:
  for j in 0..<m:
    if grid[i][j] == '#': continue
    let v = i * m + j
    if (i + j) mod 2 == 0:
      g.add_edge(s, v, 1)
    else:
      g.add_edge(v, t, 1)

# even -> odd
for i in 0..<n:
  for j in 0..<m:
    if (i + j) mod 2 == 1 or grid[i][j] == '#': continue
    let v0 = i * m + j
    if i != 0 and grid[i - 1][j] == '.':
      let v1 = (i - 1) * m + j
      g.add_edge(v0, v1, 1)
    if j != 0 and grid[i][j - 1] == '.':
      let v1 = i * m + (j - 1)
      g.add_edge(v0, v1, 1)
    if i + 1 < n and grid[i + 1][j] == '.':
      let v1 = (i + 1) * m + j
      g.add_edge(v0, v1, 1)
    if j + 1 < m and grid[i][j + 1] == '.':
      let v1 = i * m + (j + 1)
      g.add_edge(v0, v1, 1)

echo g.flow(s, t)

let edges = g.edges()
for e in edges:
  if e.src == s or e.dst == t or e.flow == 0: continue
  let
    i0 = e.src div m
    j0 = e.src mod m
    i1 = e.dst div m
    j1 = e.dst mod m

  if i0 == i1 + 1:
    grid[i1][j1] = 'v'; grid[i0][j0] = '^'
  elif j0 == j1 + 1:
    grid[i1][j1] = '>'; grid[i0][j0] = '<'
  elif i0 == i1 - 1:
    grid[i0][j0] = 'v'; grid[i1][j1] = '^'
  else:
    grid[i0][j0] = '>'; grid[i1][j1] = '<'

echo grid.join("\n")
