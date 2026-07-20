import atcoder/extra/monoid/monoid
import atcoder/extra/structure/compressed_dual_fenwicktree_2d

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

  Rectangle =
    tuple[
      xLeft,
      xRight,
      yLower,
      yUpper: int
    ]

  AppliedUpdate =
    tuple[
      rectangle:
        Rectangle,
      delta:
        int64
    ]

proc naiveValue(
    updates:
      openArray[
        AppliedUpdate
      ],
    x,
    y: int
): int64 =
  for update in updates:
    let rectangle =
      update.rectangle

    if rectangle.xLeft <= x and
       x < rectangle.xRight and
       rectangle.yLower <= y and
       y < rectangle.yUpper:
      result += update.delta

proc nextState(
    state: var uint64
): uint64 =
  state =
    state * 6364136223846793005'u64 +
    1442695040888963407'u64

  state

proc nextInt(
    state: var uint64,
    bound: int
): int =
  doAssert bound > 0
  int(state.nextState mod uint64(bound))

block fixedRectangles:
  var builder =
    initCompressedDualFenwickTree2DBuilder()

  builder.registerRectangle(
    0,
    3,
    1,
    4,
  )

  builder.registerRectangle(
    -2,
    1,
    -1,
    2,
  )

  var tree =
    builder.build(
      AdditiveInt64Group
    )

  tree.add(
    0,
    3,
    1,
    4,
    5,
  )

  tree.add(
    -2,
    1,
    -1,
    2,
    -3,
  )

  doAssert tree.get(-2, -1) == -3
  doAssert tree.get(0, 1) == 2
  doAssert tree.get(2, 3) == 5
  doAssert tree.get(3, 3) == 0
  doAssert tree.get(0, 4) == 0

block emptyRectangles:
  var builder =
    initCompressedDualFenwickTree2DBuilder()

  builder.registerRectangle(
    1,
    1,
    -5,
    9,
  )

  var tree =
    builder.build(
      AdditiveInt64Group
    )

  tree.add(
    1,
    1,
    -5,
    9,
    100,
  )

  doAssert tree.get(
    high(int),
    high(int),
  ) == 0

block exhaustiveSingleUpdates:
  const coordinates = [
    -2,
    -1,
    0,
    1,
    2,
  ]

  const deltas = [
    -3'i64,
    -1'i64,
    2'i64,
  ]

  var intervals:
    seq[
      tuple[
        left,
        right: int
      ]
    ]

  for left in coordinates:
    for right in coordinates:
      if left < right:
        intervals.add(
          (
            left: left,
            right: right,
          )
        )

  for xInterval in intervals:
    for yInterval in intervals:
      for delta in deltas:
        var builder =
          initCompressedDualFenwickTree2DBuilder()

        builder.registerRectangle(
          xInterval.left,
          xInterval.right,
          yInterval.left,
          yInterval.right,
        )

        var tree =
          builder.build(
            AdditiveInt64Group
          )

        tree.add(
          xInterval.left,
          xInterval.right,
          yInterval.left,
          yInterval.right,
          delta,
        )

        for x in -3 .. 3:
          for y in -3 .. 3:
            let expected =
              if xInterval.left <= x and
                 x < xInterval.right and
                 yInterval.left <= y and
                 y < yInterval.right:
                delta
              else:
                0'i64

            doAssert tree.get(
              x,
              y,
            ) == expected

block deterministicRandomDifferential:
  var state =
    20260720'u64

  for caseIndex in 0 ..< 500:
    let rectangleCount =
      state.nextInt(20) + 1

    var rectangles =
      newSeq[Rectangle](
        rectangleCount
      )

    var builder =
      initCompressedDualFenwickTree2DBuilder()

    for index in 0 ..< rectangleCount:
      let
        rawX1 =
          state.nextInt(101) - 50
        rawX2 =
          state.nextInt(101) - 50
        rawY1 =
          state.nextInt(101) - 50
        rawY2 =
          state.nextInt(101) - 50

      let rectangle = (
        xLeft:
          min(rawX1, rawX2),
        xRight:
          max(rawX1, rawX2),
        yLower:
          min(rawY1, rawY2),
        yUpper:
          max(rawY1, rawY2),
      )

      rectangles[index] =
        rectangle

      builder.registerRectangle(
        rectangle.xLeft,
        rectangle.xRight,
        rectangle.yLower,
        rectangle.yUpper,
      )

    var tree =
      builder.build(
        AdditiveInt64Group
      )

    var updates:
      seq[AppliedUpdate]

    for operationIndex in 0 ..< 80:
      if state.nextInt(100) < 60:
        let rectangle =
          rectangles[
            state.nextInt(
              rectangles.len
            )
          ]

        let delta =
          int64(
            state.nextInt(2001) - 1000
          )

        tree.add(
          rectangle.xLeft,
          rectangle.xRight,
          rectangle.yLower,
          rectangle.yUpper,
          delta,
        )

        if rectangle.xLeft != rectangle.xRight and
           rectangle.yLower != rectangle.yUpper:
          updates.add(
            (
              rectangle:
                rectangle,
              delta:
                delta,
            )
          )
      else:
        let
          x =
            state.nextInt(141) - 70
          y =
            state.nextInt(141) - 70

        doAssert tree.get(
          x,
          y,
        ) == naiveValue(
          updates,
          x,
          y,
        )

      discard caseIndex
      discard operationIndex

block integerBoundaries:
  var builder =
    initCompressedDualFenwickTree2DBuilder()

  builder.registerRectangle(
    low(int),
    low(int) + 2,
    low(int),
    low(int) + 3,
  )

  builder.registerRectangle(
    high(int) - 2,
    high(int),
    high(int) - 3,
    high(int),
  )

  var tree =
    builder.build(
      AdditiveInt64Group
    )

  tree.add(
    low(int),
    low(int) + 2,
    low(int),
    low(int) + 3,
    5,
  )

  tree.add(
    high(int) - 2,
    high(int),
    high(int) - 3,
    high(int),
    7,
  )

  doAssert tree.get(
    low(int),
    low(int),
  ) == 5

  doAssert tree.get(
    low(int) + 2,
    low(int),
  ) == 0

  doAssert tree.get(
    high(int) - 1,
    high(int) - 1,
  ) == 7

  doAssert tree.get(
    high(int),
    high(int) - 1,
  ) == 0

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

block genericGroup:
  var builder =
    initCompressedDualFenwickTree2DBuilder()

  builder.registerRectangle(
    -1,
    4,
    2,
    6,
  )

  var tree =
    builder.build(
      BoxGroup
    )

  tree.add(
    -1,
    4,
    2,
    6,
    Box(value: 11),
  )

  doAssert tree.get(
    0,
    3,
  ).value == 11

  doAssert tree.get(
    4,
    3,
  ).value == 0

echo "COMPRESSED_DUAL_FENWICKTREE_2D_CONTRACT_OK"
