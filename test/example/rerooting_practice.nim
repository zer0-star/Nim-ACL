include atcoder/header
import atcoder/extra/tree/rerooting

type Data = int
type Weight = tuple[d, w:int]

proc f_merge(a, b:Data):Data = max(a, b)
proc f_up(a:Data, u:int, w:Weight):Data =
  let (d, w) = w
  return max(a, d) + w

proc solve(N:int, A:seq[int], B:seq[int], C:seq[int], D:seq[int]) =
  var g = initReRooting[Data, Weight](N, f_up, f_merge, -int.inf)
  for i in 0 ..< N - 1:
    g.addBiEdge(A[i], B[i], (D[B[i]], C[i]), (D[A[i]], C[i]))
  g.solve()
  for i in 0 ..< N:
    echo g[i]
  return

var N = nextInt()
var A = newSeqWith(N-1, 0)
var B = newSeqWith(N-1, 0)
var C = newSeqWith(N-1, 0)
for i in 0..<N-1:
  A[i] = nextInt() - 1
  B[i] = nextInt() - 1
  C[i] = nextInt()
var D = newSeqWith(N, nextInt())
solve(N, A, B, C, D)
