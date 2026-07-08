when not declared ATCODER_TEST_EXTRA_GRAPH_STRUCTURAL:
  const ATCODER_TEST_EXTRA_GRAPH_STRUCTURAL* = 1

  import std/unittest
  import std/options
  import atcoder/extra/graph/graph_template
  import atcoder/extra/graph/kruskal
  import atcoder/extra/graph/prim
  import atcoder/extra/graph/lowlink
  import atcoder/extra/graph/topological_sort
  import atcoder/extra/graph/cycle_detection

  proc position(order: seq[int], n: int): seq[int] =
    result = newSeq[int](n)
    for i, v in order:
      result[v] = i

  suite "extra graph structural algorithms":
    test "kruskal computes minimum spanning tree":
      var g = initGraph(4)
      g.addBiEdge(0, 1, 1)
      g.addBiEdge(1, 2, 2)
      g.addBiEdge(0, 2, 5)
      g.addBiEdge(2, 3, 1)
      g.addBiEdge(1, 3, 4)

      let (cost, es) = kruskal(g)

      check cost == 4
      check es.len == 3

    test "prim computes minimum spanning tree":
      var g = initGraph(4)
      g.addBiEdge(0, 1, 1)
      g.addBiEdge(1, 2, 2)
      g.addBiEdge(0, 2, 5)
      g.addBiEdge(2, 3, 1)
      g.addBiEdge(1, 3, 4)

      let (cost, es) = prim(g, 0)

      check cost == 4
      check es.len == 3

    test "lowlink finds articulation points and bridges":
      var g = initGraph(4)
      g.addBiEdge(0, 1)
      g.addBiEdge(1, 2)
      g.addBiEdge(1, 3)

      let ll = LowLink(g)

      check ll.articulation == @[1]
      check ll.bridge.len == 3
      check (0, 1) in ll.bridge
      check (1, 2) in ll.bridge
      check (1, 3) in ll.bridge

    test "topological sort respects edge order constraints":
      var g = initGraph(4)
      g.addEdge(0, 1)
      g.addEdge(0, 2)
      g.addEdge(1, 3)
      g.addEdge(2, 3)

      let order = topologicalSort(g)
      let pos = position(order, 4)

      check order.len == 4
      check pos[0] < pos[1]
      check pos[0] < pos[2]
      check pos[1] < pos[3]
      check pos[2] < pos[3]

    test "cycle detection distinguishes cyclic and acyclic directed graphs":
      var cyclic = initGraph(3)
      cyclic.addEdge(0, 1)
      cyclic.addEdge(1, 2)
      cyclic.addEdge(2, 0)

      let c = cycleDetection(cyclic)
      check c.isSome
      check c.get.len == 3

      var dag = initGraph(3)
      dag.addEdge(0, 1)
      dag.addEdge(1, 2)

      check cycleDetection(dag).isNone

    test "undirected cycle detection finds simple cycle":
      var g = initGraph(3)
      g.addBiEdge(0, 1)
      g.addBiEdge(1, 2)
      g.addBiEdge(2, 0)

      let c = cycleDetectionUndirected(g)
      check c.isSome
      check c.get.len >= 3
