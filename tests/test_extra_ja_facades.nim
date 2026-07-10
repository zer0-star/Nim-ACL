discard """
  cmd: "nim cpp -r $file"
"""

import std/[options, unittest]

import atcoder/dsu
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/kruskal
import atcoder/extra/graph/chu_liu_edmonds
import atcoder/extra/graph/minimum_arborescence

import "atcoder/extra/ja/graph/最小全域木"
import "atcoder/extra/ja/graph/最小全域有向木"
import "atcoder/extra/ja/structure/素集合データ構造"

proc directedEdge(
    src,
    dst,
    weight: int,
): Edge[int, int] =
  initEdge[int, int](
    src,
    dst,
    weight,
  )

test "Japanese minimum spanning tree facade matches kruskal":
  var g = initGraph(4)

  g.addBiEdge(0, 1, 1)
  g.addBiEdge(1, 2, 2)
  g.addBiEdge(0, 2, 5)
  g.addBiEdge(2, 3, 1)
  g.addBiEdge(1, 3, 4)

  let canonical = kruskal(g)
  let japanese = 最小全域木(g)

  check japanese[0] == canonical[0]
  check japanese[1] == canonical[1]
  check japanese[0] == 4
  check japanese[1].len == 3

test "English and Japanese arborescence aliases match historical API":
  let es: Edges[int, int] = @[
    directedEdge(0, 1, 1),
    directedEdge(0, 2, 5),
    directedEdge(1, 2, 1),
    directedEdge(1, 3, 4),
    directedEdge(2, 3, 1),
  ]

  let historical =
    minimumSpanningTreeArborescence(
      es,
      4,
      0,
    )

  let english =
    minimumArborescence(
      es,
      4,
      0,
    )

  let japanese =
    最小全域有向木(
      es,
      4,
      0,
    )

  check historical.isSome
  check english.isSome
  check japanese.isSome

  check english.get == historical.get
  check japanese.get == historical.get

  let (cost, parent) = japanese.get

  check cost == 3
  check parent == @[0, 0, 1, 2]

test "Japanese arborescence facade preserves none":
  let es: Edges[int, int] = @[
    directedEdge(1, 2, 1),
  ]

  check 最小全域有向木(
    es,
    3,
    0,
  ).isNone

test "Japanese DSU facade matches canonical operations":
  var japanese:
    素集合データ構造 =
      素集合データ構造を初期化(6)

  check not japanese.同じ集合か(0, 1)

  let firstRoot = japanese.併合(0, 1)

  check japanese.同じ集合か(0, 1)
  check japanese.代表元(0) == firstRoot
  check japanese.代表元(1) == firstRoot
  check japanese.集合の大きさ(0) == 2

  discard japanese.併合(1, 2)

  check japanese.同じ集合か(0, 2)
  check japanese.集合の大きさ(2) == 3
  check japanese.集合一覧.len == 4

  var canonical = initDSU(6)

  discard canonical.merge(0, 1)
  discard canonical.merge(1, 2)

  for a in 0 ..< 6:
    check japanese.集合の大きさ(a) ==
      canonical.size(a)

    for b in 0 ..< 6:
      check japanese.同じ集合か(a, b) ==
        canonical.same(a, b)
