
discard """
  cmd: "nim cpp -r $file"
"""

import atcoder/extra/structure/partially_persistent_dsu

block:
  var uf = initPartiallyPersistentDSU(5)

  doAssert uf.size(-100, 0) == 1
  doAssert not uf.same(-100, 0, 1)

  doAssert uf.merge(10, 0, 1)
  doAssert uf.same(10, 0, 1)
  doAssert uf.size(9, 0) == 1
  doAssert uf.size(10, 0) == 2

  doAssert uf.merge(20, 1, 2)
  doAssert uf.merge(20, 3, 4)

  doAssert uf.same(20, 0, 2)
  doAssert uf.size(20, 2) == 3
  doAssert uf.same(20, 3, 4)
  doAssert uf.size(20, 3) == 2
  doAssert not uf.same(20, 0, 4)

  doAssert uf.merge(100, 2, 4)
  doAssert not uf.same(99, 0, 4)
  doAssert uf.same(100, 0, 4)
  doAssert uf.size(100, 0) == 5

block:
  var uf = initPartiallyPersistentDSU(3)

  doAssert uf.merge(-10, 0, 1)
  doAssert not uf.same(-11, 0, 1)
  doAssert uf.same(-10, 0, 1)
  doAssert uf.size(-10, 0) == 2

  doAssert not uf.merge(-5, 0, 1)
  doAssert uf.merge(0, 1, 2)
  doAssert uf.size(0, 2) == 3
