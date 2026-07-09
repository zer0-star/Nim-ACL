when not declared ATCODER_TEST_EXTRA_STATIC_GRAPH:
  const ATCODER_TEST_EXTRA_STATIC_GRAPH* = 1

  import std/unittest
  import std/algorithm
  import atcoder/extra/graph/static_graph

  suite "extra graph static_graph":
    test "static graph stores undirected weighted edges":
      var g = initStaticGraph[int](4)

      discard g.addBiEdge(0, 1, 5)
      discard g.addBiEdge(1, 2, 7)
      discard g.addBiEdge(1, 3, 11)

      g.build()

      check g.len == 4
      check g.degree(0) == 1
      check g.degree(1) == 3
      check g.degree(2) == 1
      check g.degree(3) == 1

      var adj1: seq[(int, int)] = @[]
      for e in g[1]:
        adj1.add((e.dst, e.weight))

      adj1.sort()
      check adj1 == @[(0, 5), (2, 7), (3, 11)]

    test "static graph edge fields are available after build":
      var g = initStaticGraph[int](2)

      discard g.addBiEdge(0, 1, 42)
      g.build()

      var seenForward = false
      var seenBackward = false

      for e in g[0]:
        if e.dst == 1 and e.weight == 42 and e.src == 0:
          seenForward = true

      for e in g[1]:
        if e.dst == 0 and e.weight == 42 and e.src == 1:
          seenBackward = true

      check seenForward
      check seenBackward
