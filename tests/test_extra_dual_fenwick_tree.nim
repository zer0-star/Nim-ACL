import std/unittest
import atcoder/fenwicktree
import atcoder/extra/structure/dual_fenwicktree

test "DualFenwickTree coexists with FenwickTree and supports negative values":
  var ft = initFenwickTree[int](10)
  ft.add(0, 10)
  check ft[0..<1] == 10

  var dft = initDualFenwickTree[int](10)
  dft.add(1..<4, -3)

  check dft[0] == 0
  check dft[1] == -3
  check dft[3] == -3
  check dft[4] == 0
