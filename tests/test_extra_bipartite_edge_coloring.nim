import std/unittest

import atcoder/extra/graph/bipartite_edge_coloring


proc maximumDegree(
    leftCount,
    rightCount: int,
    edges: openArray[(int, int)],
): int =
  var
    leftDegree =
      newSeq[int](leftCount)

    rightDegree =
      newSeq[int](rightCount)

  for edge in edges:
    inc leftDegree[edge[0]]
    inc rightDegree[edge[1]]

  for degree in leftDegree:
    result =
      max(
        result,
        degree,
      )

  for degree in rightDegree:
    result =
      max(
        result,
        degree,
      )


proc validateColoring(
    leftCount,
    rightCount: int,
    edges: openArray[(int, int)],
    colors: openArray[int],
) =
  doAssert colors.len ==
    edges.len

  let colorCount =
    maximumDegree(
      leftCount,
      rightCount,
      edges,
    )

  if edges.len == 0:
    doAssert colorCount == 0
    doAssert colors.len == 0
    return

  doAssert colorCount > 0

  var
    leftUsed =
      newSeq[seq[bool]](leftCount)

    rightUsed =
      newSeq[seq[bool]](rightCount)

    colorUsed =
      newSeq[bool](colorCount)

  for left in 0 ..< leftCount:
    leftUsed[left] =
      newSeq[bool](colorCount)

  for right in 0 ..< rightCount:
    rightUsed[right] =
      newSeq[bool](colorCount)

  for edgeId, edge in edges:
    let color =
      colors[edgeId]

    doAssert color >= 0
    doAssert color < colorCount

    doAssert not leftUsed[
      edge[0]
    ][color]

    doAssert not rightUsed[
      edge[1]
    ][color]

    leftUsed[edge[0]][color] =
      true

    rightUsed[edge[1]][color] =
      true

    colorUsed[color] =
      true

  for used in colorUsed:
    doAssert used


proc nextRandom(
    state: var uint64,
): uint64 {.inline.} =
  state =
    state xor (state shl 7)

  state =
    state xor (state shr 9)

  state =
    state xor (state shl 8)

  state


suite "bipartite edge coloring":
  test "empty graph":
    check bipartiteEdgeColoring(
      0,
      0,
      newSeq[(int, int)](),
    ).len == 0

    check bipartiteEdgeColoring(
      3,
      5,
      newSeq[(int, int)](),
    ).len == 0

    check bipartiteEdgeColoring(
      0,
      7,
      newSeq[(int, int)](),
    ).len == 0

  test "simple graph":
    let edges =
      @[
        (0, 0),
        (0, 1),
        (1, 0),
      ]

    let colors =
      bipartiteEdgeColoring(
        2,
        2,
        edges,
      )

    validateColoring(
      2,
      2,
      edges,
      colors,
    )

    check maximumDegree(
      2,
      2,
      edges,
    ) == 2

  test "parallel edges":
    let edges =
      @[
        (0, 0),
        (0, 0),
        (0, 0),
        (0, 0),
      ]

    let colors =
      bipartiteEdgeColoring(
        1,
        1,
        edges,
      )

    validateColoring(
      1,
      1,
      edges,
      colors,
    )

    check maximumDegree(
      1,
      1,
      edges,
    ) == 4

  test "rectangular multigraph":
    let edges =
      @[
        (0, 0),
        (0, 1),
        (0, 2),
        (1, 0),
        (1, 2),
        (2, 1),
        (3, 2),
        (3, 2),
      ]

    let colors =
      bipartiteEdgeColoring(
        4,
        3,
        edges,
      )

    validateColoring(
      4,
      3,
      edges,
      colors,
    )

    check maximumDegree(
      4,
      3,
      edges,
    ) == 4

  test "large padding uses compressed dummy multiplicities":
    let edges =
      @[
        (0, 0),
        (0, 1),
        (1, 0),
      ]

    let colors =
      bipartiteEdgeColoring(
        128,
        97,
        edges,
      )

    validateColoring(
      128,
      97,
      edges,
      colors,
    )

  test "invalid counts and endpoints":
    expect ValueError:
      discard bipartiteEdgeColoring(
        -1,
        0,
        newSeq[(int, int)](),
      )

    expect ValueError:
      discard bipartiteEdgeColoring(
        0,
        -1,
        newSeq[(int, int)](),
      )

    expect ValueError:
      discard bipartiteEdgeColoring(
        2,
        2,
        @[(2, 0)],
      )

    expect ValueError:
      discard bipartiteEdgeColoring(
        2,
        2,
        @[(0, 2)],
      )

    expect ValueError:
      discard bipartiteEdgeColoring(
        0,
        1,
        @[(0, 0)],
      )

  test "randomized bipartite multigraphs":
    var state =
      0x8042_d1bf_3a69_e75c'u64

    for leftCount in 0 .. 8:
      for rightCount in 0 .. 8:
        for _ in 0 ..< 16:
          var edges:
            seq[(int, int)]

          if leftCount > 0 and
              rightCount > 0:
            let edgeCount =
              int(
                nextRandom(state) mod 25'u64
              )

            for _ in 0 ..< edgeCount:
              edges.add(
                (
                  int(
                    nextRandom(state) mod
                      uint64(leftCount)
                  ),
                  int(
                    nextRandom(state) mod
                      uint64(rightCount)
                  ),
                )
              )

          let original =
            edges

          let colors =
            bipartiteEdgeColoring(
              leftCount,
              rightCount,
              edges,
            )

          check edges == original

          validateColoring(
            leftCount,
            rightCount,
            edges,
            colors,
          )
