import atcoder/extra/other/itertools


block:
  var actual: seq[seq[char]] = @[]

  for value in permutations(@['a', 'b', 'c']):
    actual.add(value)

  doAssert actual == @[
    @['a', 'b', 'c'],
    @['a', 'c', 'b'],
    @['b', 'a', 'c'],
    @['b', 'c', 'a'],
    @['c', 'a', 'b'],
    @['c', 'b', 'a'],
  ]

  var partial: seq[seq[char]] = @[]

  for value in permutations(
    @['a', 'b', 'c'],
    2,
  ):
    partial.add(value)

  doAssert partial == @[
    @['a', 'b'],
    @['a', 'c'],
    @['b', 'a'],
    @['b', 'c'],
    @['c', 'a'],
    @['c', 'b'],
  ]


echo "PERMUTATIONS_OK"


block:
  var actual: seq[seq[int]] = @[]

  for value in combinations(
    @[1, 2, 3, 4],
    2,
  ):
    actual.add(value)

  doAssert actual == @[
    @[1, 2],
    @[1, 3],
    @[1, 4],
    @[2, 3],
    @[2, 4],
    @[3, 4],
  ]


echo "COMBINATIONS_OK"


block:
  var duplicated: seq[seq[int]] = @[]

  for value in permutations(@[1, 1, 2]):
    duplicated.add(value)

  doAssert duplicated.len == 6

  var duplicatedCombinations:
      seq[seq[int]] = @[]

  for value in combinations(@[1, 1, 2], 2):
    duplicatedCombinations.add(value)

  doAssert duplicatedCombinations == @[
    @[1, 1],
    @[1, 2],
    @[1, 2],
  ]


echo "POSITION_BASED_DUPLICATES_OK"


block:
  var actual: seq[seq[int]] = @[]

  for value in product(
    @[0, 1],
    repeat = 3,
  ):
    actual.add(value)

  doAssert actual == @[
    @[0, 0, 0],
    @[0, 0, 1],
    @[0, 1, 0],
    @[0, 1, 1],
    @[1, 0, 0],
    @[1, 0, 1],
    @[1, 1, 0],
    @[1, 1, 1],
  ]


echo "PRODUCT_REPEAT_OK"


block:
  let pools = @[
    @["A", "K"],
    @["Q", "J"],
  ]

  var actual: seq[seq[string]] = @[]

  for value in cartesianProduct(pools):
    actual.add(value)

  doAssert actual == @[
    @["A", "Q"],
    @["A", "J"],
    @["K", "Q"],
    @["K", "J"],
  ]


echo "CARTESIAN_PRODUCT_OK"


block:
  var actual: seq[seq[int]] = @[]

  for value in (0 .. 1) ^ 3:
    actual.add(value)

  doAssert actual == @[
    @[0, 0, 0],
    @[0, 0, 1],
    @[0, 1, 0],
    @[0, 1, 1],
    @[1, 0, 0],
    @[1, 0, 1],
    @[1, 1, 0],
    @[1, 1, 1],
  ]

  var sequencePower: seq[seq[char]] = @[]

  for value in @['x', 'y'] ^ 2:
    sequencePower.add(value)

  doAssert sequencePower == @[
    @['x', 'x'],
    @['x', 'y'],
    @['y', 'x'],
    @['y', 'y'],
  ]


echo "CARTESIAN_POWER_OK"


block:
  var count = 0

  for value in permutations(
    @[1, 2],
    -1,
  ):
    discard value
    count.inc

  doAssert count == 0

  for value in permutations(
    @[1, 2],
    3,
  ):
    discard value
    count.inc

  doAssert count == 0

  for value in combinations(
    @[1, 2],
    -1,
  ):
    discard value
    count.inc

  doAssert count == 0

  for value in combinations(
    @[1, 2],
    3,
  ):
    discard value
    count.inc

  doAssert count == 0

  var zeroPermutationCount = 0

  for value in permutations(
    @[1, 2],
    0,
  ):
    doAssert value.len == 0
    zeroPermutationCount.inc

  doAssert zeroPermutationCount == 1

  var zeroCombinationCount = 0

  for value in combinations(
    @[1, 2],
    0,
  ):
    doAssert value.len == 0
    zeroCombinationCount.inc

  doAssert zeroCombinationCount == 1

  let noPools: seq[seq[int]] = @[]
  var emptyProductCount = 0

  for value in cartesianProduct(noPools):
    doAssert value.len == 0
    emptyProductCount.inc

  doAssert emptyProductCount == 1

  let poolsWithEmpty = @[
    @[1, 2],
    newSeq[int](),
  ]

  var emptyPoolCount = 0

  for value in cartesianProduct(
    poolsWithEmpty,
  ):
    discard value
    emptyPoolCount.inc

  doAssert emptyPoolCount == 0

  var zeroRepeatCount = 0

  for value in product(
    @[1, 2],
    repeat = 0,
  ):
    doAssert value.len == 0
    zeroRepeatCount.inc

  doAssert zeroRepeatCount == 1

  var negativeRepeatCount = 0

  for value in product(
    @[1, 2],
    repeat = -1,
  ):
    discard value
    negativeRepeatCount.inc

  doAssert negativeRepeatCount == 0


echo "BOUNDARY_CONTRACTS_OK"


block:
  var visited = 0

  for value in product(
    @[0, 1],
    repeat = 40,
  ):
    doAssert value.len == 40
    visited.inc

    if visited == 3:
      break

  doAssert visited == 3


echo "LAZY_EARLY_BREAK_OK"
echo "CANONICAL_ITERTOOLS_CONTRACT_OK"
