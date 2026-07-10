discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import std/algorithm
import std/tables
import atcoder/extra/graph/dsu_on_tree

proc addEdge(g: var seq[seq[int]], u, v: int) =
  g[u].add v
  g[v].add u

proc sortedSeq(a: seq[int]): seq[int] =
  result = a
  result.sort()

test "DSUOnTree metadata":
  var g = newSeq[seq[int]](7)

  addEdge(g, 0, 1)
  addEdge(g, 0, 2)
  addEdge(g, 1, 3)
  addEdge(g, 1, 4)
  addEdge(g, 2, 5)
  addEdge(g, 2, 6)

  let dt = initDSUOnTree(g)

  check dt.len == 7
  check dt.root == 0
  check dt.parent[0] == 0
  check dt.depth[0] == 0
  check dt.depth[3] == 2
  check dt.depth[6] == 2

  check dt.subtreeSize[0] == 7
  check dt.subtreeSize[1] == 3
  check dt.subtreeSize[2] == 3
  check dt.subtreeSize[3] == 1

  check sortedSeq(dt.subtreeVertices(1)) == @[1, 3, 4]
  check sortedSeq(dt.subtreeVertices(2)) == @[2, 5, 6]

test "DSUOnTree subtree distinct color counts":
  var g = newSeq[seq[int]](7)

  addEdge(g, 0, 1)
  addEdge(g, 0, 2)
  addEdge(g, 1, 3)
  addEdge(g, 1, 4)
  addEdge(g, 2, 5)
  addEdge(g, 2, 6)

  let
    dt = initDSUOnTree(g)
    color = @[1, 2, 1, 2, 3, 1, 3]

  var
    freq = initTable[int, int]()
    distinctCount = 0
    ans = newSeq[int](7)

  proc addVertex(v: int) =
    let c = color[v]
    let old = freq.getOrDefault(c, 0)

    if old == 0:
      distinctCount.inc

    freq[c] = old + 1

  proc removeVertex(v: int) =
    let c = color[v]
    let old = freq.getOrDefault(c, 0)

    check old > 0

    if old == 1:
      freq.del(c)
      distinctCount.dec
    else:
      freq[c] = old - 1

  proc answerVertex(v: int) =
    ans[v] = distinctCount

  dt.run(addVertex, removeVertex, answerVertex)

  check ans == @[3, 2, 2, 1, 1, 1, 1]

test "DSUOnTree max color frequency in subtree":
  var g = newSeq[seq[int]](6)

  addEdge(g, 0, 1)
  addEdge(g, 0, 2)
  addEdge(g, 1, 3)
  addEdge(g, 1, 4)
  addEdge(g, 4, 5)

  let
    dt = initDSUOnTree(g)
    color = @[1, 2, 1, 2, 2, 3]

  var
    freq = initTable[int, int]()
    maxFreq = 0
    ans = newSeq[int](6)

  proc recomputeMaxFreq() =
    maxFreq = 0

    for _, v in freq:
      maxFreq = max(maxFreq, v)

  proc addVertex(v: int) =
    let c = color[v]
    let nv = freq.getOrDefault(c, 0) + 1
    freq[c] = nv
    maxFreq = max(maxFreq, nv)

  proc removeVertex(v: int) =
    let c = color[v]
    let old = freq.getOrDefault(c, 0)

    check old > 0

    if old == 1:
      freq.del(c)
    else:
      freq[c] = old - 1

    recomputeMaxFreq()

  proc answerVertex(v: int) =
    ans[v] = maxFreq

  dt.runDSUOnTree(addVertex, removeVertex, answerVertex)

  check ans == @[3, 3, 1, 1, 1, 1]

test "DSUOnTree nonzero root":
  var g = newSeq[seq[int]](5)

  addEdge(g, 2, 0)
  addEdge(g, 2, 1)
  addEdge(g, 1, 3)
  addEdge(g, 1, 4)

  let dt = initDSUOnTree(g, root = 2)

  check dt.root == 2
  check dt.parent[2] == 2
  check sortedSeq(dt.subtreeVertices(1)) == @[1, 3, 4]
  check sortedSeq(dt.subtreeVertices(2)) == @[0, 1, 2, 3, 4]
