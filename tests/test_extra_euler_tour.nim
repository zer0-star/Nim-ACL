discard """
  cmd: "nim cpp -r --path:src $file"
"""

import std/algorithm
import std/unittest

import atcoder/extra/graph/graph_template
import atcoder/extra/graph/euler_tour


proc addEdge(
  graph: var seq[seq[int]],
  u, v: int
) =
  graph[u].add v
  graph[v].add u


proc sortedCopy(
  values: seq[int]
): seq[int] =
  result = values
  result.sort()


test "EulerTour accepts Nim-ACL Graph":
  var graph = initGraph(5)

  graph.addBiEdge(0, 1)
  graph.addBiEdge(0, 2)
  graph.addBiEdge(1, 3)
  graph.addBiEdge(1, 4)

  let tour =
    initEulerTour(graph)

  check tour.len == 5
  check tour.parent[0] == 0
  check tour.parent[3] == 1
  check tour.depth[4] == 2

  check tour.subtreeSize(1) == 3

  check sortedCopy(
    tour.subtreeVertices(1)
  ) == @[1, 3, 4]

  check tour.isAncestor(0, 4)
  check tour.isAncestor(1, 4)
  check not tour.isAncestor(2, 4)


test "EulerTour accepts seq adjacency list":
  var graph =
    newSeq[seq[int]](7)

  addEdge(graph, 0, 1)
  addEdge(graph, 0, 2)
  addEdge(graph, 1, 3)
  addEdge(graph, 1, 4)
  addEdge(graph, 2, 5)
  addEdge(graph, 2, 6)

  let tour =
    initEulerTour(graph)

  check tour.len == 7
  check tour.subtreeSize(0) == 7
  check tour.subtreeSize(1) == 3
  check tour.subtreeSize(2) == 3

  check sortedCopy(
    tour.subtreeVertices(1)
  ) == @[1, 3, 4]

  check sortedCopy(
    tour.subtreeVertices(2)
  ) == @[2, 5, 6]


test "EulerTour supports a nonzero root":
  var graph =
    newSeq[seq[int]](5)

  addEdge(graph, 2, 0)
  addEdge(graph, 2, 1)
  addEdge(graph, 1, 3)
  addEdge(graph, 1, 4)

  let tour =
    initEulerTour(
      graph,
      root = 2,
    )

  check tour.parent[2] == 2
  check tour.depth[4] == 2

  check tour.walk.len == 9
  check tour.walk[0] == 2
  check tour.walk[^1] == 2

  for vertex in 0 ..< 5:
    check tour.walk[
      tour.first[vertex]
    ] == vertex


test "EulerTour accepts a one-vertex Nim-ACL Graph":
  let graph = initGraph(1)
  let tour = initEulerTour(graph)

  check tour.len == 1
  check tour.order == @[0]
  check tour.walk == @[0]
