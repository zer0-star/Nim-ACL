import atcoder/extra/graph/bipartite_edge_coloring


proc buildCrossModuleEdgeColors*():
    seq[int] =
  let edges =
    @[
      (0, 0),
      (0, 0),
      (0, 1),
      (1, 0),
    ]

  bipartiteEdgeColoring(
    2,
    2,
    edges,
  )
