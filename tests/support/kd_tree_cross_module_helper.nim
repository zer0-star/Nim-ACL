import std/options

import atcoder/extra/structure/kd_tree


proc buildKDTreeCrossModuleResult*():
    tuple[
      nearestIndex: int,
      squaredDistance: int64,
      rangeIndices: seq[int],
      pointCount: int,
    ] =
  let points:
    seq[KDPoint[3, int64]] =
      @[
        [0'i64, 0, 0],
        [5'i64, 1, 2],
        [2'i64, 2, 2],
        [-3'i64, 4, 1],
      ]

  let tree =
    initKDTree(points)

  let nearest =
    tree.nearest(
      [3'i64, 2, 2]
    ).get

  result.nearestIndex =
    nearest.index

  result.squaredDistance =
    nearest.squaredDistance

  result.rangeIndices =
    tree.rangeSearch(
      [0'i64, 0, 0],
      [6'i64, 3, 3],
    )

  result.pointCount =
    tree.len
