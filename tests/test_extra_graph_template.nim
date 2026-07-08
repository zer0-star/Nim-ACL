when not declared ATCODER_TEST_EXTRA_GRAPH_TEMPLATE:
  const ATCODER_TEST_EXTRA_GRAPH_TEMPLATE* = 1

  import std/unittest
  import atcoder/extra/graph/graph_template
  import atcoder/extra/graph/static_graph

  suite "extra graph template":
    test "graph_template directed addEdge":
      var g = initGraph(3)
      g.addEdge(0, 1)
      g.addEdge(1, 2, 5)

      check g[0].len == 1
      check g[1].len == 1
      check g[2].len == 0
      check g[0][0].src == 0
      check g[0][0].dst == 1
      check g[0][0].weight == 1
      check g[1][0].src == 1
      check g[1][0].dst == 2
      check g[1][0].weight == 5

    test "graph_template undirected addBiEdge":
      var g = initGraph(3)
      g.addBiEdge(0, 1, 7)

      check g[0].len == 1
      check g[1].len == 1
      check g[0][0].dst == 1
      check g[1][0].dst == 0
      check g[0][0].weight == 7
      check g[1][0].weight == 7

    test "graph_template initDirectedGraph from edge arrays":
      let a = @[0, 1]
      let b = @[1, 2]
      let c = @[3, 4]
      let g = initDirectedGraph(3, a, b, c)

      check g[0].len == 1
      check g[1].len == 1
      check g[0][0].dst == 1
      check g[0][0].weight == 3
      check g[1][0].dst == 2
      check g[1][0].weight == 4

    test "static_graph build degree and iteration":
      var g = initStaticGraph[int](3)
      discard g.addBiEdge(0, 1, 10)
      discard g.addBiEdge(1, 2, 20)
      g.build()

      check g.len == 3
      check g.degree(0) == 1
      check g.degree(1) == 2
      check g.degree(2) == 1

      var count = 0
      for e in g[1]:
        discard e
        inc count
      check count == 2
