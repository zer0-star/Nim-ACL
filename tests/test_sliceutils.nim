discard """
  cmd: "nim cpp -r -d:release $file"
"""

import atcoder/extra/other/sliceutils


block:
  let values = @[10, 20, 30, 40, 50]
  let indices = values.index

  doAssert indices.a == 0
  doAssert indices.b == 4

  doAssert values[1 .. 3] ==
    @[20, 30, 40]


block:
  var actual: seq[int] = @[]

  for i in rev(1 .. 4):
    actual.add(i)

  doAssert actual == @[4, 3, 2, 1]


block:
  var actual: seq[int] = @[]

  for i in (1 .. 4).rev():
    actual.add(i)

  doAssert actual == @[4, 3, 2, 1]


block:
  var forward: seq[int] = @[]
  var backward: seq[int] = @[]

  for i in ((1 .. 7) >> 2):
    forward.add(i)

  for i in ((1 .. 7) << 2):
    backward.add(i)

  doAssert forward == @[1, 3, 5, 7]
  doAssert backward == @[7, 5, 3, 1]


block:
  var indices: seq[int] = @[]

  for i in 5:
    indices.add(i)

  doAssert indices == @[0, 1, 2, 3, 4]


block:
  var values = @[0, 0, 0, 0, 0]

  values[(0 .. 4) >> 2] =
    @[10, 20, 30]

  doAssert values == @[10, 0, 20, 0, 30]


block:
  let empty: seq[int] = @[]
  let indices = empty.index

  doAssert indices.a == 0
  doAssert indices.b == -1


echo "SLICEUTILS_CONTRACT_TEST_OK"
