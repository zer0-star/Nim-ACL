when not declared ATCODER_TEST_EXTRA_BORUVKA:
  const ATCODER_TEST_EXTRA_BORUVKA* = 1

  import std/unittest
  import atcoder/extra/graph/boruvka

  proc mstCostByBoruvka(n: int, edges: seq[(int, int, int)], inf: int = int.high div 4): int =
    var b = initBoruvka[int](n, inf)

    result = b.build(proc(best: var seq[(int, int)]) =
      for (u, v, w) in edges:
        let ru = b.find(u)
        let rv = b.find(v)

        if ru == rv:
          continue

        if w < best[ru][0]:
          best[ru] = (w, rv)

        if w < best[rv][0]:
          best[rv] = (w, ru)
    )

  suite "extra graph boruvka":
    test "boruvka computes minimum spanning tree cost":
      let edges = @[
        (0, 1, 1),
        (1, 2, 2),
        (0, 2, 5),
        (2, 3, 1),
        (1, 3, 4),
      ]

      check mstCostByBoruvka(4, edges) == 4

    test "boruvka handles already minimal parallel choices":
      let edges = @[
        (0, 1, 10),
        (0, 1, 3),
        (1, 2, 4),
        (0, 2, 100),
      ]

      check mstCostByBoruvka(3, edges) == 7

    test "boruvka returns inf for disconnected graph":
      let inf = 1_000_000_000
      let edges = @[
        (0, 1, 5),
      ]

      check mstCostByBoruvka(3, edges, inf) == inf
