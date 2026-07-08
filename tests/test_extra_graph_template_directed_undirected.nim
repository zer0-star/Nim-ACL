when not declared ATCODER_TEST_EXTRA_GRAPH_TEMPLATE_DIRECTED_UNDIRECTED:
  const ATCODER_TEST_EXTRA_GRAPH_TEMPLATE_DIRECTED_UNDIRECTED* = 1

  import std/unittest
  import atcoder/extra/graph/graph_template_directed_undirected

  suite "extra graph template directed/undirected":
    test "directed graph addEdge stores one direction":
      var g = initDirectedGraph[int](3)
      g.addEdge(0, 1, 5)

      check g[0].len == 1
      check g[1].len == 0
      check g[2].len == 0
      check g[0][0].src == 0
      check g[0][0].dst == 1
      check g[0][0].weight == 5

    test "undirected graph addEdge stores both directions":
      var g = initUndirectedGraph[int](3)
      g.addEdge(0, 1, 7)

      check g[0].len == 1
      check g[1].len == 1
      check g[2].len == 0
      check g[0][0].src == 0
      check g[0][0].dst == 1
      check g[0][0].weight == 7
      check g[1][0].src == 1
      check g[1][0].dst == 0
      check g[1][0].weight == 7

    test "multiple directed edges keep insertion order":
      var g = initDirectedGraph[int](4)
      g.addEdge(0, 1, 10)
      g.addEdge(0, 2, 20)
      g.addEdge(0, 3, 30)

      check g[0].len == 3
      check g[0][0].dst == 1
      check g[0][1].dst == 2
      check g[0][2].dst == 3
      check g[0][0].weight == 10
      check g[0][1].weight == 20
      check g[0][2].weight == 30
