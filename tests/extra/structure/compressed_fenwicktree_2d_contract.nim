import atcoder/extra/monoid/monoid
import atcoder/extra/structure/compressed_fenwicktree_2d

proc addInt64(
    a,
    b: int64
): int64 =
  a + b

proc zeroInt64(): int64 =
  0'i64

proc negateInt64(
    value: int64
): int64 =
  -value

type
  AdditiveInt64Group =
    CommutativeGroupOf(
      int64,
      addInt64,
      zeroInt64,
      negateInt64,
    )

block directConstruction:
  let points = @[
    (
      x: 10,
      y: 20,
    ),
    (
      x: 0,
      y: 0,
    ),
    (
      x: 10,
      y: 20,
    ),
    (
      x: -5,
      y: 7,
    ),
    (
      x: 3,
      y: -2,
    ),
  ]

  var tree =
    initCompressedFenwickTree2D(
      points,
      AdditiveInt64Group,
    )

  doAssert tree.pointCount == 4

  doAssert tree.containsPoint(
    10,
    20,
  )

  doAssert not tree.containsPoint(
    99,
    99,
  )

  doAssert tree.allSum == 0

  tree.add(
    -5,
    7,
    4,
  )

  tree.add(
    0,
    0,
    3,
  )

  tree.add(
    3,
    -2,
    5,
  )

  tree.add(
    10,
    20,
    7,
  )

  tree.add(
    10,
    20,
    2,
  )

  doAssert tree.prefixSum(
    4,
    8,
  ) == 12

  doAssert tree.prefixSum(
    11,
    21,
  ) == 21

  doAssert tree.sum(
    -5,
    4,
    -3,
    8,
  ) == 12

  doAssert tree.sum(
    0,
    11,
    -1,
    21,
  ) == 12

  doAssert tree.get(
    10,
    20,
  ) == 9

  doAssert tree[
    3,
    -2,
  ] == 5

  doAssert tree.get(
    99,
    99,
  ) == 0

  doAssert tree.allSum == 21

  doAssert tree.sum(
    5,
    5,
    -100,
    100,
  ) == 0

block builderConstruction:
  var builder =
    initCompressedFenwickTree2DBuilder()

  builder.addPoint(
    4,
    5,
  )

  builder.registerPoint(
    -1,
    2,
  )

  builder.addPoints(
    @[
      (
        x: 4,
        y: 5,
      ),
      (
        x: 8,
        y: -3,
      ),
    ]
  )

  var tree =
    builder.build(
      AdditiveInt64Group
    )

  doAssert tree.pointCount == 3

  tree.add(
    4,
    5,
    6,
  )

  tree.add(
    -1,
    2,
    7,
  )

  tree.add(
    8,
    -3,
    9,
  )

  doAssert tree.sum(
    -100,
    100,
    -100,
    100,
  ) == 22

block emptyTopology:
  let points:
    seq[CompressedFenwickPoint2D] =
      @[]

  let tree =
    initCompressedFenwickTree2D(
      points,
      AdditiveInt64Group,
    )

  doAssert tree.pointCount == 0
  doAssert tree.allSum == 0

  doAssert tree.prefixSum(
    100,
    100,
  ) == 0

block inclusivePrefixBoundaries:
  let points = @[
    (
      x: low(int),
      y: low(int),
    ),
    (
      x: 0,
      y: 0,
    ),
    (
      x: high(int),
      y: high(int),
    ),
  ]

  var tree =
    initCompressedFenwickTree2D(
      points,
      AdditiveInt64Group,
    )

  tree.add(
    low(int),
    low(int),
    2,
  )

  tree.add(
    0,
    0,
    3,
  )

  tree.add(
    high(int),
    high(int),
    7,
  )

  doAssert tree.prefixSum(
    low(int),
    high(int),
  ) == 0

  doAssert tree.prefixSumInclusive(
    low(int),
    low(int),
  ) == 2

  doAssert tree.prefixSumInclusive(
    0,
    0,
  ) == 5

  doAssert tree.prefixSumInclusive(
    high(int),
    high(int),
  ) == 12

type
  Box =
    object
      value:
        int

proc boxOp(
    a,
    b: Box
): Box =
  Box(
    value:
      a.value + b.value
  )

proc boxZero(): Box =
  Box(
    value: 0
  )

proc boxInv(
    value: Box
): Box =
  Box(
    value:
      -value.value
  )

type
  BoxGroup =
    CommutativeGroupOf(
      Box,
      boxOp,
      boxZero,
      boxInv,
    )

block descriptorOnlyOperations:
  var tree =
    initCompressedFenwickTree2D(
      @[
        (
          x: 1,
          y: 2,
        ),
        (
          x: 3,
          y: 4,
        ),
      ],
      BoxGroup,
    )

  tree.add(
    1,
    2,
    Box(value: 11),
  )

  tree.add(
    3,
    4,
    Box(value: 13),
  )

  doAssert tree.allSum.value == 24

  doAssert tree.sum(
    0,
    2,
    0,
    3,
  ).value == 11

echo "COMPRESSED_FENWICKTREE_2D_CONTRACT_OK"
