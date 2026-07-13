import atcoder/extra/other/algorithmutils


block:
  var actual: seq[seq[int]] = @[]

  for value in permutation(@[1, 2, 3]):
    actual.add(value)

  doAssert actual.len == 6
  doAssert actual[0] == @[1, 2, 3]
  doAssert actual[^1] == @[3, 2, 1]


block:
  var actual: seq[seq[char]] = @[]

  for value in combination(
    @['a', 'b', 'c'],
    2,
  ):
    actual.add(value)

  doAssert actual == @[
    @['a', 'b'],
    @['a', 'c'],
    @['b', 'c'],
  ]


block:
  var invalidCount = 0

  for value in combination(
    @[1, 2],
    -1,
  ):
    discard value
    invalidCount.inc

  doAssert invalidCount == 0


block:
  var values = @[5, 1, 4, 2, 3]

  values.nth_element(2)

  doAssert values[2] == 3


echo "LEGACY_ALGORITHMUTILS_COMPATIBILITY_OK"
