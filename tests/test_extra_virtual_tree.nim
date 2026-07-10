discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/graph/virtual_tree

proc addEdge(g: var seq[seq[int]], u, v: int) =
  g[u].add v
  g[v].add u

test "VirtualTree lca and dist":
  var g = newSeq[seq[int]](7)

  addEdge(g, 0, 1)
  addEdge(g, 0, 2)
  addEdge(g, 1, 3)
  addEdge(g, 1, 4)
  addEdge(g, 2, 5)
  addEdge(g, 2, 6)

  let vt = initVirtualTree(g)

  check vt.lca(3, 4) == 1
  check vt.lca(3, 5) == 0
  check vt.lca(5, 6) == 2

  check vt.dist(3, 4) == 2
  check vt.dist(3, 5) == 4
  check vt.dist(0, 6) == 2

  check vt.isAncestor(0, 6)
  check vt.isAncestor(2, 6)
  check not vt.isAncestor(1, 6)

test "VirtualTree build from three keys":
  var g = newSeq[seq[int]](7)

  addEdge(g, 0, 1)
  addEdge(g, 0, 2)
  addEdge(g, 1, 3)
  addEdge(g, 1, 4)
  addEdge(g, 2, 5)
  addEdge(g, 2, 6)

  let vt = initVirtualTree(g)
  let built = vt.buildVirtualTree(@[3, 4, 5])

  check built.root == 0
  check built.vertices == @[0, 1, 3, 4, 5]

  check built.edges == @[
    (parent: 0, child: 1, dist: 1),
    (parent: 1, child: 3, dist: 1),
    (parent: 1, child: 4, dist: 1),
    (parent: 0, child: 5, dist: 2),
  ]

  check built.adj[0] == @[(to: 1, dist: 1), (to: 4, dist: 2)]
  check built.adj[1] == @[(to: 2, dist: 1), (to: 3, dist: 1)]

test "VirtualTree build with duplicate keys":
  var g = newSeq[seq[int]](5)

  addEdge(g, 0, 1)
  addEdge(g, 1, 2)
  addEdge(g, 1, 3)
  addEdge(g, 3, 4)

  let vt = initVirtualTree(g)
  let built = vt.buildVirtualTree(@[2, 2, 4, 4])

  check built.root == 1
  check built.vertices == @[1, 2, 4]
  check built.edges == @[
    (parent: 1, child: 2, dist: 1),
    (parent: 1, child: 4, dist: 2),
  ]

test "VirtualTree single key":
  var g = newSeq[seq[int]](3)

  addEdge(g, 0, 1)
  addEdge(g, 1, 2)

  let vt = initVirtualTree(g)
  let built = vt.buildVirtualTree(@[2])

  check built.root == 2
  check built.vertices == @[2]
  check built.edges.len == 0
  check built.adj.len == 1

test "VirtualTree with nonzero root":
  var g = newSeq[seq[int]](5)

  addEdge(g, 2, 0)
  addEdge(g, 2, 1)
  addEdge(g, 1, 3)
  addEdge(g, 1, 4)

  let vt = initVirtualTree(g, root = 2)

  check vt.lca(3, 4) == 1
  check vt.lca(0, 4) == 2
  check vt.dist(0, 4) == 3

  let built = vt.buildVirtualTree(@[0, 3, 4])

  check built.root == 2
  check built.vertices == @[2, 0, 1, 3, 4]
