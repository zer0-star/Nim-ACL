when not declared ATCODER_TEST_EXTRA_GRAPH_SHORTEST_PATHS:
  const ATCODER_TEST_EXTRA_GRAPH_SHORTEST_PATHS* = 1

  import std/unittest
  import atcoder/extra/graph/graph_template
  import atcoder/extra/graph/dijkstra
  import atcoder/extra/graph/bellman_ford
  import atcoder/extra/graph/warshall_floyd

  suite "extra graph shortest paths":
    test "dijkstra shortest distances and path":
      var g = initGraph(4)
      g.addEdge(0, 1, 2)
      g.addEdge(0, 2, 5)
      g.addEdge(1, 2, 1)
      g.addEdge(2, 3, 1)

      var d = dijkstra(g, 0)

      check d.contains(3)
      check d[0] == 0
      check d[1] == 2
      check d[2] == 3
      check d[3] == 4
      check d.path(3) == @[0, 1, 2, 3]

    test "dijkstra01 handles zero one weights":
      var g = initGraph(4)
      g.addEdge(0, 1, 1)
      g.addEdge(0, 2, 0)
      g.addEdge(2, 1, 0)
      g.addEdge(1, 3, 1)

      var d = dijkstra01(g, 0)

      check d[0] == 0
      check d[1] == 0
      check d[2] == 0
      check d[3] == 1

    test "bellman_ford handles negative edges without negative cycle":
      var g = initGraph(4)
      g.addEdge(0, 1, 1)
      g.addEdge(1, 2, -2)
      g.addEdge(0, 2, 5)
      g.addEdge(2, 3, 3)

      let d = bellman_ford(g, 0)

      check d[0] == 0
      check d[1] == 1
      check d[2] == -1
      check d[3] == 2
      check d.path(3) == @[0, 1, 2, 3]

    test "warshall_floyd computes all pairs shortest paths":
      let inf = int.high div 4
      let dist = @[
        @[0,   3,   10],
        @[inf, 0,   4],
        @[inf, inf, 0],
      ]

      let wf = warshallFloyd(dist)

      check wf[0, 0] == 0
      check wf[0, 1] == 3
      check wf[0, 2] == 7
      check wf[1, 2] == 4
      check wf.path(0, 2) == @[0, 1, 2]
