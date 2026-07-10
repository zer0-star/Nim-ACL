discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import std/sequtils
import atcoder/extra/graph/rerooting_dp

test "RerootingGraph basic":
  var g = initRerootingGraph(4)

  check g.len == 4
  check g.edgeCount == 0

  check g.addEdge(0, 1) == 0
  check g.addEdge(1, 2) == 1
  check g.addEdge(1, 3) == 2

  check g.edgeCount == 3
  check g.graph[1].len == 3

test "RerootingDP subtree size becomes n for every root":
  var g = initRerootingGraph(5)

  discard g.addEdge(0, 1)
  discard g.addEdge(0, 2)
  discard g.addEdge(1, 3)
  discard g.addEdge(1, 4)

  proc merge(a, b: int): int = a + b
  proc addRoot(x: int, v: int): int = x + 1

  let ans = g.rerooting(identity = 0, merge, addRoot)

  check ans == @[5, 5, 5, 5, 5]

test "RerootingDP sum of distances":
  type DP = tuple[size, dist: int]

  var g = initRerootingGraph(4)

  discard g.addEdge(0, 1)
  discard g.addEdge(1, 2)
  discard g.addEdge(2, 3)

  proc merge(a, b: DP): DP =
    (size: a.size + b.size, dist: a.dist + b.dist)

  proc addRoot(x: DP, v: int): DP =
    (size: x.size + 1, dist: x.dist)

  proc addEdge(x: DP, edgeId: int, fromVertex: int, toVertex: int): DP =
    (size: x.size, dist: x.dist + x.size)

  let ans = g.rerooting((size: 0, dist: 0), merge, addRoot, addEdge)

  check ans.mapIt(it.dist) == @[6, 4, 4, 6]
  check ans.mapIt(it.size) == @[4, 4, 4, 4]

test "RerootingDP maximum distance to any vertex":
  var g = initRerootingGraph(6)

  discard g.addEdge(0, 1)
  discard g.addEdge(0, 2)
  discard g.addEdge(1, 3)
  discard g.addEdge(1, 4)
  discard g.addEdge(4, 5)

  proc merge(a, b: int): int = max(a, b)
  proc addRoot(x: int, v: int): int = x
  proc addEdge(x: int, edgeId: int, fromVertex: int, toVertex: int): int = x + 1

  let ans = g.rerootingDP(0, merge, addRoot, addEdge)

  check ans == @[3, 2, 4, 3, 3, 4]

test "RerootingDP single vertex":
  var g = initRerootingGraph(1)

  proc merge(a, b: int): int = a + b
  proc addRoot(x: int, v: int): int = x + 10

  let ans = g.rerootingDP(0, merge, addRoot)

  check ans == @[10]
