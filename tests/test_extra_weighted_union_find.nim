discard """
  cmd: "nim cpp -r $file"
"""

import atcoder/extra/structure/weighted_union_find

block basic_weighted_union_find:
  var uf = initWeightedUnionFind[int](5)

  doAssert uf.unionSet(0, 1, 2)
  doAssert uf.diff(0, 1) == 2
  doAssert uf.diff(1, 0) == -2

  doAssert uf.unionSet(1, 2, 3)
  doAssert uf.same(0, 2)
  doAssert uf.diff(0, 2) == 5
  doAssert uf.diff(2, 0) == -5

  doAssert uf.size(0) == 3
  doAssert not uf.same(0, 3)

  doAssert uf.unionSet(3, 4, -10)
  doAssert uf.diff(3, 4) == -10
  doAssert uf.size(3) == 2

  let gs = uf.groups()
  doAssert gs.len == 2

block generic_type:
  var uf = initWeightedUnionFind[float](3)

  doAssert uf.unionSet(0, 1, 1.5)
  doAssert uf.unionSet(1, 2, 2.25)
  doAssert abs(uf.diff(0, 2) - 3.75) < 1e-9
