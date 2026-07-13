import std/algorithm as algorithm
import atcoder/modint
import atcoder/extra/other/itertools


block:
  let eager = algorithm.product(@[
    @[1],
    @[2],
  ])

  doAssert eager == @[
    @[1, 2],
  ]


block:
  var lazyValues: seq[seq[int]] = @[]

  for value in product(
    @[0, 1],
    repeat = 2,
  ):
    lazyValues.add(value)

  doAssert lazyValues == @[
    @[0, 0],
    @[0, 1],
    @[1, 0],
    @[1, 1],
  ]


echo "STD_PRODUCT_COEXISTENCE_OK"


block:
  type mint =
    modint998244353

  let powered = mint(2) ^ 10

  doAssert powered.val == 1024

  let backwards: BackwardsIndex = ^1

  doAssert int(backwards) == 1

  var cartesianCount = 0

  for value in (0 .. 1) ^ 2:
    doAssert value.len == 2
    cartesianCount.inc

  doAssert cartesianCount == 4


echo "CARET_COEXISTENCE_OK"
