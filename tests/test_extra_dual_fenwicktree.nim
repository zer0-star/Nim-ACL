
discard """
  cmd: "nim cpp -r $file"
"""

import atcoder/extra/structure/dual_fenwicktree

block:
  var fw = initDualFenwickTree[int](6)

  fw.add(1..<4, 10)
  fw.add(2..5, -3)
  fw.add(0..0, 7)
  fw.add(3..<6, 2)

  doAssert fw[0] == 7
  doAssert fw[1] == 10
  doAssert fw[2] == 7
  doAssert fw[3] == 9
  doAssert fw[4] == -1
  doAssert fw[5] == -1

block:
  var fw = initDualFenwickTree[int](5)

  fw.add(0..<5, 1)
  fw.add(1..3, 2)
  fw.add(2..<2, 100)

  doAssert fw[0] == 1
  doAssert fw[1] == 3
  doAssert fw[2] == 3
  doAssert fw[3] == 3
  doAssert fw[4] == 1
