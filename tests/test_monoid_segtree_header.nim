include atcoder/extra/header/chaemon_header


proc headerAdd(a, b: int): int =
  a + b


proc headerZero(): int =
  0


proc headerMax(a, b: int): int =
  max(a, b)


proc headerNegativeInfinity(): int =
  low(int)


proc headerMapping(
    f,
    x: int
): int =
  if x == low(int):
    low(int)
  else:
    f + x


useMonoid(
  HeaderSumMonoidProbe,
  int,
  headerAdd,
  headerZero,
)

useMonoid(
  HeaderMaxMonoidProbe,
  int,
  headerMax,
  headerNegativeInfinity,
)

useMonoid(
  HeaderAddMonoidProbe,
  int,
  headerAdd,
  headerZero,
)

useActionMonoid(
  HeaderMaxAddActionProbe,
  HeaderAddMonoidProbe,
  HeaderMaxMonoidProbe,
  headerMapping,
)


block:
  var tree = HeaderSumMonoidProbe.initSegTree(
    @[1, 2, 3],
  )

  doAssert tree.prod(0..2) == 6

  echo "HEADER_SEGTREE_DESCRIPTOR_OK"
  echo "HEADER_RANGE_OK"


block:
  var tree = HeaderMaxAddActionProbe.initLazySegTree(
    @[1, 2, 3],
  )

  tree.apply(1..<3, 4)

  doAssert tree.get(1) == 6
  doAssert tree.get(2) == 7
  doAssert tree.prod(0..<3) == 7

  echo "HEADER_ACTION_DESCRIPTOR_OK"


echo "CHAEMON_HEADER_MONOID_SEGTREE_OK"
