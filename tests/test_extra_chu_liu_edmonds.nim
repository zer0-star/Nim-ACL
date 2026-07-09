when not declared ATCODER_TEST_EXTRA_CHU_LIU_EDMONDS:
  const ATCODER_TEST_EXTRA_CHU_LIU_EDMONDS* = 1

  import std/unittest
  import std/options
  import atcoder/extra/graph/graph_template
  import atcoder/extra/graph/chu_liu_edmonds

  proc edge(src, dst, weight: int): Edge[int, int] =
    initEdge[int, int](src, dst, weight)

  suite "extra graph chu_liu_edmonds":
    test "minimum arborescence on simple directed graph":
      let es: Edges[int, int] = @[
        edge(0, 1, 1),
        edge(0, 2, 5),
        edge(1, 2, 1),
        edge(1, 3, 4),
        edge(2, 3, 1),
      ]

      let ans = minimumSpanningTreeArborescence(es, 4, 0)

      check ans.isSome
      let (cost, parent) = ans.get
      check cost == 3
      check parent == @[0, 0, 1, 2]

    test "minimum arborescence resolves directed cycle":
      let es: Edges[int, int] = @[
        edge(0, 1, 10),
        edge(0, 2, 5),
        edge(1, 2, 1),
        edge(2, 1, 1),
      ]

      let ans = minimumSpanningTreeArborescence(es, 3, 0)

      check ans.isSome
      let (cost, parent) = ans.get
      check cost == 6
      check parent[0] == 0
      check parent[1] == 2
      check parent[2] == 0

    test "minimum arborescence returns none when unreachable":
      let es: Edges[int, int] = @[
        edge(1, 2, 1),
      ]

      let ans = minimumSpanningTreeArborescence(es, 3, 0)

      check ans.isNone
