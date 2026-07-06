
discard """
  cmd: "nim cpp -r $file"
"""

import atcoder/extra/structure/wavelet_matrix

block:
  let v = @[3, 1, 4, 1, 5, 9, 2, 6]
  let wm = initWaveletMatrix[int](v, 4)

  for i in 0..<v.len:
    doAssert wm[i] == v[i]

  doAssert wm.rank(1, 4) == 2
  doAssert wm.rank(3, 8) == 1

  doAssert wm.kth_smallest(0..<8, 0) == 1
  doAssert wm.kth_smallest(0..<8, 3) == 3
  doAssert wm.kth_largest(0..<8, 0) == 9
  doAssert wm.kth_largest(0..<8, 2) == 5

  doAssert wm.range_freq(0..<8, 5) == 5
  doAssert wm.range_freq(0..<8, 2, 6) == 4
  doAssert wm.prev_value(0..<8, 5) == 4
  doAssert wm.next_value(0..<8, 5) == 5

block:
  let v = @[100, -10, 100, 7, 7, 30]
  let wm = initCompressedWaveletMatrix[int](v, 3)

  for i in 0..<v.len:
    doAssert wm[i] == v[i]

  doAssert wm.rank(100, 6) == 2
  doAssert wm.rank(7, 4) == 1
  doAssert wm.kth_smallest(0..<6, 0) == -10
  doAssert wm.kth_largest(0..<6, 0) == 100
  doAssert wm.range_freq(0..<6, 0, 101) == 5
  doAssert wm.prev_value(0..<6, 100) == 30
  doAssert wm.next_value(0..<6, 8) == 30
