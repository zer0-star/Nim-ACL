discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import std/algorithm
import atcoder/extra/graph/euler_tour

proc addEdge(
  graph: var seq[seq[int]],
  u, v: int
) =
  graph[u].add v
  graph[v].add u

proc sortedValues(a: seq[int]): seq[int] =
  result = a
  result.sort()

test "EulerTour subtree intervals":
  var graph = newSeq[seq[int]](7)

  addEdge(graph, 0, 1)
  addEdge(graph, 0, 2)
  addEdge(graph, 1, 3)
  addEdge(graph, 1, 4)
  addEdge(graph, 2, 5)
  addEdge(graph, 2, 6)

  let tour = initEulerTour(graph)

  check tour.len == 7
  check tour.parent[0] == 0
  check tour.depth[0] == 0
  check tour.depth[3] == 2
  check tour.depth[6] == 2

  check tour.subtreeRange(0) == (l: 0, r: 7)
  check tour.subtreeSize(0) == 7
  check tour.subtreeSize(1) == 3
  check tour.subtreeSize(2) == 3

  check sortedValues(tour.subtreeVertices(1)) == @[1, 3, 4]
  check sortedValues(tour.subtreeVertices(2)) == @[2, 5, 6]

  check tour.isAncestor(0, 6)
  check tour.isAncestor(2, 6)
  check not tour.isAncestor(1, 6)

  for i in 0 ..< tour.len:
    check tour.vertexAt(i) == tour.order[i]

test "EulerTour full walk":
  var graph = newSeq[seq[int]](4)

  addEdge(graph, 0, 1)
  addEdge(graph, 1, 2)
  addEdge(graph, 1, 3)

  let tour = initEulerTour(graph)

  check tour.walk.len == 7
  check tour.walk[0] == 0
  check tour.walk[^1] == 0

  for v in 0 ..< 4:
    check tour.walk[tour.first[v]] == v

test "EulerTour nonzero root":
  var graph = newSeq[seq[int]](5)

  addEdge(graph, 2, 0)
  addEdge(graph, 2, 1)
  addEdge(graph, 1, 3)
  addEdge(graph, 1, 4)

  let tour = initEulerTour(graph, root = 2)

  check tour.root == 2
  check tour.parent[2] == 2
  check tour.depth[4] == 2

  check sortedValues(tour.subtreeVertices(1)) == @[1, 3, 4]
  check sortedValues(tour.subtreeVertices(2)) == @[0, 1, 2, 3, 4]

test "EulerTour one vertex":
  let tour = initEulerTour(@[newSeq[int]()])

  check tour.order == @[0]
  check tour.walk == @[0]
  check tour.subtreeRange(0) == (l: 0, r: 1)
