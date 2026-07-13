include atcoder/extra/header/chaemon_header


block:
  var actual: seq[seq[int]] = @[]

  for value in (0 .. 1) ^ 2:
    actual.add(value)

  doAssert actual == @[
    @[0, 0],
    @[0, 1],
    @[1, 0],
    @[1, 1],
  ]


block:
  var actual: seq[seq[char]] = @[]

  for value in permutations(@['a', 'b']):
    actual.add(value)

  doAssert actual == @[
    @['a', 'b'],
    @['b', 'a'],
  ]


echo "ITERTOOLS_HEADER_EXPOSURE_OK"
