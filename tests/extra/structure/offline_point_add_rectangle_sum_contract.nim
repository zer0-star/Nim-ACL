import atcoder/extra/structure/offline_point_add_rectangle_sum

type
  Int64Ops =
    object

proc zero(_: typedesc[Int64Ops]): int64 =
  0'i64

proc add(
    _: typedesc[Int64Ops],
    first,
    second: int64
): int64 =
  first + second

proc sub(
    _: typedesc[Int64Ops],
    first,
    second: int64
): int64 =
  first - second

proc nextState(state: var uint64): uint64 =
  state =
    state * 6364136223846793005'u64 +
    1442695040888963407'u64
  state

proc nextInt(state: var uint64, bound: int): int =
  doAssert bound > 0
  int(state.nextState mod uint64(bound))

block emptyUniverse:
  var solver =
    initOfflinePointAddRectangleSum[
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

  discard solver.addRectangleQuery(
    -100,
    100,
    -100,
    100,
  )

  doAssert solver.solve() == @[0'i64]

block lifecycle:
  var solver =
    initOfflinePointAddRectangleSum[
      int64,
      Int64Ops
    ](
      @[
        (x: 0, y: 0, weight: 5'i64),
      ],
      Int64Ops,
    )

  let first =
    solver.addRectangleQuery(
      -1,
      1,
      -1,
      1,
    )

  solver.addPoint(
    0,
    0,
    3'i64,
  )

  let second =
    solver.addRectangleQuery(
      -1,
      1,
      -1,
      1,
    )

  doAssert first == 0
  doAssert second == 1
  doAssert solver.queryCount == 2

  let beforeAppend =
    solver.solve()

  doAssert beforeAppend ==
    @[
      5'i64,
      8'i64,
    ]

  doAssert solver.solve() ==
    beforeAppend

  solver.addPoint(
    0,
    0,
    2'i64,
  )

  let third =
    solver.addRectangleQuery(
      -1,
      1,
      -1,
      1,
    )

  doAssert third == 2

  doAssert solver.solve() ==
    @[
      5'i64,
      8'i64,
      10'i64,
    ]

block deterministicRandomDifferential:
  var state =
    20260724'u64

  for caseIndex in 0 ..< 180:
    let initialCount =
      state.nextInt(25)

    var initialPoints =
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

    var naivePoints =
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

    for pointIndex in 0 ..< initialCount:
      let point =
        (
          x:
            state.nextInt(51) - 25,
          y:
            state.nextInt(51) - 25,
          weight:
            int64(
              state.nextInt(201) - 100
            ),
        )

      initialPoints.add(point)
      naivePoints.add(point)

      discard pointIndex

    var solver =
      initOfflinePointAddRectangleSum[
        int64,
        Int64Ops
      ](
        initialPoints,
        Int64Ops,
      )

    var expectedAnswers =
      newSeq[int64]()

    for eventIndex in 0 ..< 120:
      if state.nextInt(10) < 6:
        let point =
          (
            x:
              state.nextInt(51) - 25,
            y:
              state.nextInt(51) - 25,
            weight:
              int64(
                state.nextInt(201) - 100
              ),
          )

        solver.addPoint(
          point.x,
          point.y,
          point.weight,
        )

        naivePoints.add(point)
      else:
        let
          xBegin =
            state.nextInt(61) - 30
          xEnd =
            xBegin +
            state.nextInt(
              31 - xBegin
            )
          yBegin =
            state.nextInt(61) - 30
          yEnd =
            yBegin +
            state.nextInt(
              31 - yBegin
            )

        let queryIndex =
          solver.addRectangleQuery(
            xBegin,
            xEnd,
            yBegin,
            yEnd,
          )

        doAssert queryIndex ==
          expectedAnswers.len

        var expected =
          0'i64

        for point in naivePoints:
          if xBegin <= point.x and
              point.x < xEnd and
              yBegin <= point.y and
              point.y < yEnd:
            expected += point.weight

        expectedAnswers.add(expected)

      discard eventIndex

    doAssert solver.solve() ==
      expectedAnswers

    doAssert solver.solve() ==
      expectedAnswers

    discard caseIndex

type
  Box = object
    value: int64

  BoxOps = object

proc zero(_: typedesc[BoxOps]): Box =
  Box(value: 0)

proc add(
    _: typedesc[BoxOps],
    first,
    second: Box
): Box =
  Box(
    value:
      first.value + second.value
  )

proc sub(
    _: typedesc[BoxOps],
    first,
    second: Box
): Box =
  Box(
    value:
      first.value - second.value
  )

block customOps:
  var solver =
    initOfflinePointAddRectangleSum[
      Box,
      BoxOps
    ](
      @[
        (
          x:
            0,
          y:
            0,
          weight:
            Box(value: 3),
        ),
      ],
      BoxOps,
    )

  discard solver.addRectangleQuery(
    -1,
    1,
    -1,
    1,
  )

  solver.addPoint(
    0,
    0,
    Box(value: 5),
  )

  discard solver.addRectangleQuery(
    -1,
    1,
    -1,
    1,
  )

  let answers =
    solver.solve()

  doAssert answers[0].value == 3
  doAssert answers[1].value == 8

echo "OFFLINE_POINT_ADD_RECTANGLE_SUM_CONTRACT_OK"
