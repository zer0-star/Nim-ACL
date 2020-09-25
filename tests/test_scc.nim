import std/unittest

import atcoder/scc

test "SCCTest, Empty":
  var graph0:SCCGraph
  check newSeq[seq[int]]() == graph0.scc()
  var graph1 = initSCCGraph(0)
  check newSeq[seq[int]]() == graph1.scc()

test "SCCTest, Assign":
  var graph:SCCGraph
  graph = initSCCGraph(10)

test "SCCTest, Simple":
  var graph = initSCCGraph(2)
  graph.add_edge(0, 1)
  graph.add_edge(1, 0)
  let scc = graph.scc()
  check 1 == scc.len

test "SCCTest, SelfLoop":
  var graph = initSCCGraph(2)
  graph.add_edge(0, 0)
  graph.add_edge(0, 0)
  graph.add_edge(1, 1)
  let scc = graph.scc()
  check 2 == scc.len

test "SCCTest, Invalid":
  var graph = initSCCGraph(2)
  expect AssertionError:
    graph.add_edge(0, 10)
