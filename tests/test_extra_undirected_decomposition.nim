discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import std/algorithm
import atcoder/extra/graph/undirected_decomposition

proc sequenceCompare(a, b: seq[int]): int =
  for i in 0 ..< min(a.len, b.len):
    let c = cmp(a[i], b[i])

    if c != 0:
      return c

  cmp(a.len, b.len)

proc normalized(components: seq[seq[int]]): seq[seq[int]] =
  result = components

  for component in result.mitems:
    component.sort()

  result.sort(sequenceCompare)

proc undirectedTreeEdgeCount(tree: seq[seq[int]]): int =
  for edges in tree:
    result += edges.len

  result = result div 2

test "biconnected components articulation and bridge":
  var g = initUndirectedGraph(6)

  let e01 = g.addEdge(0, 1)
  let e12 = g.addEdge(1, 2)
  let e20 = g.addEdge(2, 0)
  let bridge = g.addEdge(1, 3)
  let e34 = g.addEdge(3, 4)
  let e45 = g.addEdge(4, 5)
  let e53 = g.addEdge(5, 3)

  let bcc = g.biconnectedComponents()

  check bcc.articulation == @[1, 3]
  check bcc.bridges == @[bridge]

  check normalized(bcc.vertexComponents) == @[
    @[0, 1, 2],
    @[1, 3],
    @[3, 4, 5],
  ]

  check normalized(bcc.edgeComponents) == normalized(@[
    @[e01, e12, e20],
    @[bridge],
    @[e34, e45, e53],
  ])

  for edgeId in 0 ..< g.edgeCount:
    check bcc.componentOfEdge[edgeId] >= 0

test "two-edge-connected components":
  var g = initUndirectedGraph(6)

  discard g.addEdge(0, 1)
  discard g.addEdge(1, 2)
  discard g.addEdge(2, 0)
  let bridge = g.addEdge(1, 3)
  discard g.addEdge(3, 4)
  discard g.addEdge(4, 5)
  discard g.addEdge(5, 3)

  let result = g.twoEdgeConnectedComponents()

  check result.bridgeIds == @[bridge]
  check normalized(result.groups) == @[
    @[0, 1, 2],
    @[3, 4, 5],
  ]

  check result.component[0] == result.component[2]
  check result.component[3] == result.component[5]
  check result.component[0] != result.component[3]

  check undirectedTreeEdgeCount(result.forest) == 1

test "block-cut tree":
  var g = initUndirectedGraph(6)

  discard g.addEdge(0, 1)
  discard g.addEdge(1, 2)
  discard g.addEdge(2, 0)
  discard g.addEdge(1, 3)
  discard g.addEdge(3, 4)
  discard g.addEdge(4, 5)
  discard g.addEdge(5, 3)

  let result = g.blockCutTree()

  check result.blockNodeCount == 3
  check result.articulationVertices == @[1, 3]
  check result.tree.len == 5
  check undirectedTreeEdgeCount(result.tree) == 4

  check result.articulationNode[1] >= result.blockNodeCount
  check result.articulationNode[3] >= result.blockNodeCount
  check result.vertexNode[1] == result.articulationNode[1]
  check result.vertexNode[3] == result.articulationNode[3]

  check normalized(result.blockVertices) == @[
    @[0, 1, 2],
    @[1, 3],
    @[3, 4, 5],
  ]

test "parallel edges are not bridges":
  var g = initUndirectedGraph(2)

  let e0 = g.addEdge(0, 1)
  let e1 = g.addEdge(0, 1)

  let bcc = g.biconnectedComponents()

  check bcc.articulation.len == 0
  check bcc.bridges.len == 0
  check normalized(bcc.edgeComponents) == @[@[e0, e1]]
  check normalized(bcc.vertexComponents) == @[@[0, 1]]

  let tecc = g.twoEdgeConnectedComponents(bcc)

  check normalized(tecc.groups) == @[@[0, 1]]

test "path graph":
  var g = initUndirectedGraph(3)

  let e0 = g.addEdge(0, 1)
  let e1 = g.addEdge(1, 2)

  let bcc = g.biconnectedComponents()

  check bcc.articulation == @[1]
  check bcc.bridges == @[e0, e1]
  check normalized(bcc.vertexComponents) == @[
    @[0, 1],
    @[1, 2],
  ]

  let tecc = g.twoEdgeConnectedComponents(bcc)

  check normalized(tecc.groups) == @[
    @[0],
    @[1],
    @[2],
  ]

test "isolated vertices":
  let g = initUndirectedGraph(3)

  let bcc = g.biconnectedComponents()

  check bcc.articulation.len == 0
  check bcc.bridges.len == 0
  check normalized(bcc.vertexComponents) == @[
    @[0],
    @[1],
    @[2],
  ]

  let blockCut = g.blockCutTree(bcc)

  check blockCut.blockNodeCount == 3
  check blockCut.tree.len == 3
  check undirectedTreeEdgeCount(blockCut.tree) == 0
