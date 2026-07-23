import atcoder/extra/structure/static_rectangle_sum

type
  Int64Ops =
    object

proc zero(
    _:
      typedesc[
        Int64Ops
      ]
): int64 =
  0'i64

proc add(
    _:
      typedesc[
        Int64Ops
      ],
    first,
    second:
      int64
): int64 =
  first + second

proc sub(
    _:
      typedesc[
        Int64Ops
      ],
    first,
    second:
      int64
): int64 =
  first - second

proc nextState(
    state:
      var uint64
): uint64 =
  state =
    state * 6364136223846793005'u64 +
    1442695040888963407'u64

  state

proc nextInt(
    state:
      var uint64,
    bound:
      int
): int =
  int(
    state.nextState mod uint64(bound)
  )

block emptyPointSet:
  let structure =
    initStaticRectangleSum[
      int64,
      Int64Ops
    ](
      newSeq[
        tuple[
          x:
            int,
          y:
            int,
          weight:
            int64
        ]
      ](),
      Int64Ops,
    )

  doAssert structure.pointCount == 0
  doAssert structure.allSum == 0

  doAssert structure.sum(
    -100,
    100,
    -100,
    100,
  ) == 0

block fixedPoints:
  let points = @[
    (
      x:
        -3,
      y:
        5,
      weight:
        7'i64,
    ),
    (
      x:
        2,
      y:
        -1,
      weight:
        11'i64,
    ),
    (
      x:
        2,
      y:
        -1,
      weight:
        -4'i64,
    ),
    (
      x:
        2,
      y:
        8,
      weight:
        3'i64,
    ),
    (
      x:
        10,
      y:
        4,
      weight:
        -6'i64,
    ),
  ]

  let structure =
    initStaticRectangleSum[
      int64,
      Int64Ops
    ](
      points,
      Int64Ops,
    )

  doAssert structure.pointCount == 5
  doAssert structure.allSum == 11

  doAssert structure.sum(
    -100,
    100,
    -100,
    100,
  ) == 11

  doAssert structure.sum(
    2,
    3,
    -1,
    0,
  ) == 7

  doAssert structure.sum(
    2,
    3,
    -2,
    9,
  ) == 10

  doAssert structure.sum(
    -3,
    2,
    5,
    6,
  ) == 7

  doAssert structure.sum(
    -3,
    -3,
    -100,
    100,
  ) == 0

  doAssert structure.sum(
    -100,
    100,
    4,
    4,
  ) == 0

block deterministicRandomDifferential:
  var state =
    20260723'u64

  for caseIndex in 0 ..< 220:
    let pointCount =
      state.nextInt(70)

    var points =
      newSeq[
        tuple[
          x:
            int,
          y:
            int,
          weight:
            int64
        ]
      ]()

    for pointIndex in 0 ..< pointCount:
      points.add(
        (
          x:
            state.nextInt(61) - 30,
          y:
            state.nextInt(61) - 30,
          weight:
            int64(
              state.nextInt(201) - 100
            ),
        )
      )

      discard pointIndex

    let structure =
      initStaticRectangleSum[
        int64,
        Int64Ops
      ](
        points,
        Int64Ops,
      )

    var expectedAll =
      0'i64

    for point in points:
      expectedAll +=
        point.weight

    doAssert structure.pointCount ==
      points.len

    doAssert structure.allSum ==
      expectedAll

    for queryIndex in 0 ..< 120:
      let
        xBegin =
          state.nextInt(71) - 35
        xEnd =
          xBegin +
          state.nextInt(
            36 - xBegin
          )
        yBegin =
          state.nextInt(71) - 35
        yEnd =
          yBegin +
          state.nextInt(
            36 - yBegin
          )

      var expected =
        0'i64

      for point in points:
        if xBegin <= point.x and
            point.x < xEnd and
            yBegin <= point.y and
            point.y < yEnd:
          expected +=
            point.weight

      doAssert structure.sum(
        xBegin,
        xEnd,
        yBegin,
        yEnd,
      ) == expected

      discard queryIndex

    discard caseIndex

type
  Box =
    object
      value:
        int64

  BoxOps =
    object

proc zero(
    _:
      typedesc[
        BoxOps
      ]
): Box =
  Box(
    value:
      0
  )

proc add(
    _:
      typedesc[
        BoxOps
      ],
    first,
    second:
      Box
): Box =
  Box(
    value:
      first.value + second.value
  )

proc sub(
    _:
      typedesc[
        BoxOps
      ],
    first,
    second:
      Box
): Box =
  Box(
    value:
      first.value - second.value
  )

block customValueAndOps:
  let points = @[
    (
      x:
        0,
      y:
        0,
      weight:
        Box(value: 5),
    ),
    (
      x:
        2,
      y:
        3,
      weight:
        Box(value: 8),
    ),
    (
      x:
        2,
      y:
        3,
      weight:
        Box(value: -1),
    ),
  ]

  let structure =
    initStaticRectangleSum[
      Box,
      BoxOps
    ](
      points,
      BoxOps,
    )

  doAssert structure.allSum.value == 12

  doAssert structure.sum(
    2,
    3,
    3,
    4,
  ).value == 7

echo "STATIC_RECTANGLE_SUM_CONTRACT_OK"
