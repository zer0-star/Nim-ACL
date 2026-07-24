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


# NIM_ACL_COMPRESSED_FENWICKTREE_2D_FOCUSED_EXTENSION_START

proc cf2dExtAddInt64(
    first,
    second: int64
): int64 =
  first + second

proc cf2dExtZeroInt64(): int64 =
  0'i64

proc cf2dExtNegateInt64(
    value: int64
): int64 =
  -value

type
  CF2DExtAdditiveInt64Group =
    CommutativeGroupOf(
      int64,
      cf2dExtAddInt64,
      cf2dExtZeroInt64,
      cf2dExtNegateInt64,
    )

proc cf2dExtNextState(
    state:
      var uint64
): uint64 =
  state =
    state * 6364136223846793005'u64 +
    1442695040888963407'u64

  state

proc cf2dExtNextInt(
    state:
      var uint64,
    bound:
      int
): int =
  doAssert bound > 0

  int(
    state.cf2dExtNextState mod uint64(bound)
  )

proc cf2dExtFindPoint(
    points:
      seq[
        CompressedFenwickPoint2D
      ],
    x,
    y:
      int
): int =
  for index, point in points:
    if point.x == x and
        point.y == y:
      return index

  -1

block cf2dExtDeterministicRandomDifferential:
  var state =
    20260724'u64

  var totalOperationCount =
    0

  var totalQueryCount =
    0

  for caseIndex in 0 ..< 160:
    let registrationCount =
      state.cf2dExtNextInt(60)

    var registrationRecords =
      newSeq[
        CompressedFenwickPoint2D
      ]()

    var uniquePoints =
      newSeq[
        CompressedFenwickPoint2D
      ]()

    for recordIndex in 0 ..<
        registrationCount:
      let point =
        (
          x:
            state.cf2dExtNextInt(61) - 30,
          y:
            state.cf2dExtNextInt(61) - 30,
        )

      registrationRecords.add(
        point
      )

      if uniquePoints.cf2dExtFindPoint(
        point.x,
        point.y,
      ) < 0:
        uniquePoints.add(
          point
        )

      if state.cf2dExtNextInt(5) == 0:
        registrationRecords.add(
          point
        )

      discard recordIndex

    var tree =
      initCompressedFenwickTree2D(
        registrationRecords,
        CF2DExtAdditiveInt64Group,
      )

    var naive =
      newSeq[int64](
        uniquePoints.len
      )

    doAssert tree.pointCount ==
      uniquePoints.len

    for point in uniquePoints:
      doAssert tree.containsPoint(
        point.x,
        point.y,
      )

    for operationIndex in 0 ..< 120:
      if uniquePoints.len > 0 and
          state.cf2dExtNextInt(10) < 6:
        let pointIndex =
          state.cf2dExtNextInt(
            uniquePoints.len
          )

        let delta =
          int64(
            state.cf2dExtNextInt(201) - 100
          )

        let point =
          uniquePoints[
            pointIndex
          ]

        tree.add(
          point.x,
          point.y,
          delta,
        )

        naive[
          pointIndex
        ] += delta
      else:
        let
          xBegin =
            state.cf2dExtNextInt(71) - 35
          xEnd =
            xBegin +
            state.cf2dExtNextInt(
              36 - xBegin
            )
          yBegin =
            state.cf2dExtNextInt(71) - 35
          yEnd =
            yBegin +
            state.cf2dExtNextInt(
              36 - yBegin
            )

        var rectangleExpected =
          0'i64

        var prefixExpected =
          0'i64

        var inclusiveExpected =
          0'i64

        for index, point in uniquePoints:
          if xBegin <= point.x and
              point.x < xEnd and
              yBegin <= point.y and
              point.y < yEnd:
            rectangleExpected +=
              naive[index]

          if point.x < xEnd and
              point.y < yEnd:
            prefixExpected +=
              naive[index]

          if point.x <= xEnd and
              point.y <= yEnd:
            inclusiveExpected +=
              naive[index]

        doAssert tree.sum(
          xBegin,
          xEnd,
          yBegin,
          yEnd,
        ) == rectangleExpected

        doAssert tree.prefixSum(
          xEnd,
          yEnd,
        ) == prefixExpected

        doAssert tree.prefixSumInclusive(
          xEnd,
          yEnd,
        ) == inclusiveExpected

        totalQueryCount.inc

      totalOperationCount.inc

      discard operationIndex

    var allExpected =
      0'i64

    for index, point in uniquePoints:
      allExpected +=
        naive[index]

      doAssert tree.get(
        point.x,
        point.y,
      ) == naive[index]

      doAssert tree[
        point.x,
        point.y
      ] == naive[index]

    doAssert tree.allSum ==
      allExpected

    doAssert tree.get(
      100000,
      100000,
    ) == 0

    discard caseIndex

  doAssert totalOperationCount ==
    19200

  doAssert totalQueryCount >
    4000

block cf2dExtUnregisteredUpdateRejected:
  var tree =
    initCompressedFenwickTree2D(
      @[
        (
          x:
            1,
          y:
            2,
        ),
      ],
      CF2DExtAdditiveInt64Group,
    )

  doAssertRaises(
      AssertionDefect
  ):
    tree.add(
      99,
      100,
      7'i64,
    )

block cf2dExtBuilderDuplicateParity:
  let registrationRecords =
    @[
      (
        x:
          4,
        y:
          5,
      ),
      (
        x:
          -1,
        y:
          2,
      ),
      (
        x:
          4,
        y:
          5,
      ),
      (
        x:
          8,
        y:
          -3,
      ),
      (
        x:
          -1,
        y:
          2,
      ),
    ]

  var directTree =
    initCompressedFenwickTree2D(
      registrationRecords,
      CF2DExtAdditiveInt64Group,
    )

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
        x:
          4,
        y:
          5,
      ),
      (
        x:
          8,
        y:
          -3,
      ),
      (
        x:
          -1,
        y:
          2,
      ),
    ]
  )

  var builderTree =
    builder.build(
      CF2DExtAdditiveInt64Group
    )

  doAssert directTree.pointCount == 3
  doAssert builderTree.pointCount == 3

  for update in @[
    (
      x:
        4,
      y:
        5,
      delta:
        6'i64,
    ),
    (
      x:
        4,
      y:
        5,
      delta:
        -2'i64,
    ),
    (
      x:
        -1,
      y:
        2,
      delta:
        7'i64,
    ),
    (
      x:
        8,
      y:
        -3,
      delta:
        9'i64,
    ),
  ]:
    directTree.add(
      update.x,
      update.y,
      update.delta,
    )

    builderTree.add(
      update.x,
      update.y,
      update.delta,
    )

  doAssert directTree.allSum ==
    builderTree.allSum

  doAssert directTree.allSum ==
    20'i64

  for point in @[
    (
      x:
        4,
      y:
        5,
    ),
    (
      x:
        -1,
      y:
        2,
    ),
    (
      x:
        8,
      y:
        -3,
    ),
  ]:
    doAssert directTree.get(
      point.x,
      point.y,
    ) == builderTree.get(
      point.x,
      point.y,
    )

  for rectangle in @[
    (
      xBegin:
        -100,
      xEnd:
        100,
      yBegin:
        -100,
      yEnd:
        100,
    ),
    (
      xBegin:
        4,
      xEnd:
        5,
      yBegin:
        5,
      yEnd:
        6,
    ),
    (
      xBegin:
        -2,
      xEnd:
        9,
      yBegin:
        -4,
      yEnd:
        6,
    ),
  ]:
    doAssert directTree.sum(
      rectangle.xBegin,
      rectangle.xEnd,
      rectangle.yBegin,
      rectangle.yEnd,
    ) == builderTree.sum(
      rectangle.xBegin,
      rectangle.xEnd,
      rectangle.yBegin,
      rectangle.yEnd,
    )

echo "COMPRESSED_FENWICKTREE_2D_EXTENDED_CONTRACT_OK"

# NIM_ACL_COMPRESSED_FENWICKTREE_2D_FOCUSED_EXTENSION_END
