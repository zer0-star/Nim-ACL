import atcoder/extra/dp/cumulative_sum_2d

block emptyConstruction:
  var cumulative =
    initCumulativeSum2D[int](
      height = 0,
      width = 3,
    )

  cumulative.build()

  doAssert cumulative.height == 0
  doAssert cumulative.width == 3

  doAssert cumulative.sum(
    rowBegin = 0,
    rowEnd = 0,
    colBegin = 0,
    colEnd = 3,
  ) == 0

  doAssert cumulative.allSum == 0

  echo "CUMULATIVE_SUM_2D_EMPTY_OK"

block incrementalConstruction:
  var cumulative =
    initCumulativeSum2D[int](
      height = 3,
      width = 4,
    )

  cumulative.add(
    row = 0,
    col = 0,
    value = 1,
  )

  cumulative.add(1, 1, 5)
  cumulative.add(2, 3, 7)
  cumulative.build()

  doAssert cumulative.height == 3
  doAssert cumulative.width == 4

  doAssert cumulative[
    0 .. 0,
    0 .. 0,
  ] == 1

  doAssert cumulative[
    0 .. 2,
    0 .. 3,
  ] == 13

  doAssert cumulative.sum(
    rowBegin = 0,
    rowEnd = 3,
    colBegin = 0,
    colEnd = 4,
  ) == 13

  doAssert cumulative.sum(
    1,
    3,
    1,
    4,
  ) == 12

  doAssert cumulative.sum(
    2,
    2,
    0,
    4,
  ) == 0

  doAssert cumulative.allSum == 13

  echo "CUMULATIVE_SUM_2D_HALF_OPEN_OK"

block matrixConstruction:
  let data = @[
    @[1, 2, 3, 4],
    @[5, 6, 7, 8],
    @[9, 10, 11, 12],
  ]

  let cumulative =
    initCumulativeSum2D(data)

  doAssert cumulative.height == 3
  doAssert cumulative.width == 4

  doAssert cumulative[
    1 .. 2,
    2 .. 3,
  ] == 38

  doAssert cumulative.sum(
    1,
    3,
    2,
    4,
  ) == 38

  doAssert cumulative.sum(
    0,
    3,
    1,
    3,
  ) == 39

  doAssert cumulative.allSum == 78

  echo "CUMULATIVE_SUM_2D_MATRIX_OK"


# NIM_ACL_CUMULATIVE_SUM_2D_FOCUSED_EXTENSION_START

proc cs2dExtNextState(
    state:
      var uint64
): uint64 =
  state =
    state * 6364136223846793005'u64 +
    1442695040888963407'u64

  state

proc cs2dExtNextInt(
    state:
      var uint64,
    bound:
      int
): int =
  doAssert bound > 0

  int(
    state.cs2dExtNextState mod uint64(bound)
  )

block cs2dExtDeterministicRandomDifferential:
  var state =
    20260724'u64

  var totalUpdateCount =
    0

  var totalQueryCount =
    0

  for caseIndex in 0 ..< 120:
    let
      height =
        state.cs2dExtNextInt(13)
      width =
        state.cs2dExtNextInt(13)

    var naive =
      newSeq[
        seq[
          int64
        ]
      ](
        height
      )

    for row in 0 ..< height:
      naive[row] =
        newSeq[int64](
          width
        )

    var cumulative =
      initCumulativeSum2D[
        int64
      ](
        height,
        width,
      )

    for updateIndex in 0 ..< 80:
      let
        row =
          state.cs2dExtNextInt(
            height + 4
          ) - 2
        col =
          state.cs2dExtNextInt(
            width + 4
          ) - 2
        value =
          int64(
            state.cs2dExtNextInt(201) - 100
          )

      cumulative.add(
        row,
        col,
        value,
      )

      if 0 <= row and row < height and
          0 <= col and col < width:
        naive[row][col] +=
          value

      totalUpdateCount.inc

      discard updateIndex

    cumulative.build()
    cumulative.build()

    doAssert cumulative.height ==
      height

    doAssert cumulative.width ==
      width

    var allExpected =
      0'i64

    for row in 0 ..< height:
      for col in 0 ..< width:
        allExpected +=
          naive[row][col]

    doAssert cumulative.allSum ==
      allExpected

    for queryIndex in 0 ..< 80:
      let
        rowBegin =
          state.cs2dExtNextInt(
            height + 1
          )
        rowEnd =
          rowBegin +
          state.cs2dExtNextInt(
            height - rowBegin + 1
          )
        colBegin =
          state.cs2dExtNextInt(
            width + 1
          )
        colEnd =
          colBegin +
          state.cs2dExtNextInt(
            width - colBegin + 1
          )

      var expected =
        0'i64

      for row in rowBegin ..< rowEnd:
        for col in colBegin ..< colEnd:
          expected +=
            naive[row][col]

      doAssert cumulative.sum(
        rowBegin,
        rowEnd,
        colBegin,
        colEnd,
      ) == expected

      if rowBegin < rowEnd and
          colBegin < colEnd:
        doAssert cumulative[
          rowBegin .. rowEnd - 1,
          colBegin .. colEnd - 1,
        ] == expected

      totalQueryCount.inc

      discard queryIndex

    discard caseIndex

  doAssert totalUpdateCount ==
    9600

  doAssert totalQueryCount ==
    9600

block cs2dExtBoundaryAndIdempotence:
  block zeroHeight:
    var cumulative =
      initCumulativeSum2D[int](
        0,
        4,
      )

    cumulative.add(
      -1,
      0,
      100,
    )

    cumulative.add(
      0,
      0,
      100,
    )

    cumulative.build()
    cumulative.build()

    doAssert cumulative.height == 0
    doAssert cumulative.width == 4

    doAssert cumulative.sum(
      0,
      0,
      0,
      4,
    ) == 0

    doAssert cumulative.allSum == 0

  block zeroWidth:
    var cumulative =
      initCumulativeSum2D[int](
        3,
        0,
      )

    cumulative.add(
      0,
      -1,
      100,
    )

    cumulative.add(
      0,
      0,
      100,
    )

    cumulative.build()
    cumulative.build()

    doAssert cumulative.height == 3
    doAssert cumulative.width == 0

    doAssert cumulative.sum(
      0,
      3,
      0,
      0,
    ) == 0

    doAssert cumulative.allSum == 0

  block outOfGridAddsIgnored:
    var cumulative =
      initCumulativeSum2D[int](
        2,
        3,
      )

    cumulative.add(-1, 0, 100)
    cumulative.add(0, -1, 100)
    cumulative.add(2, 0, 100)
    cumulative.add(0, 3, 100)
    cumulative.add(0, 0, 7)
    cumulative.add(1, 2, 11)

    cumulative.build()
    cumulative.build()

    doAssert cumulative.allSum == 18

    doAssert cumulative.sum(
      0,
      2,
      0,
      3,
    ) == 18

block cs2dExtRejectionSemantics:
  doAssertRaises(
    AssertionDefect
  ):
    discard initCumulativeSum2D[int](
      -1,
      3,
    )

  doAssertRaises(
    AssertionDefect
  ):
    discard initCumulativeSum2D[int](
      3,
      -1,
    )

  let ragged =
    @[
      @[
        1,
        2,
      ],
      @[
        3,
      ],
    ]

  doAssertRaises(
    AssertionDefect
  ):
    discard initCumulativeSum2D(
      ragged
    )

  var cumulative =
    initCumulativeSum2D[int](
      2,
      3,
    )

  cumulative.build()

  doAssertRaises(
    AssertionDefect
  ):
    cumulative.add(
      0,
      0,
      1,
    )

  doAssertRaises(
    AssertionDefect
  ):
    discard cumulative.sum(
      -1,
      1,
      0,
      1,
    )

  doAssertRaises(
    AssertionDefect
  ):
    discard cumulative.sum(
      1,
      0,
      0,
      1,
    )

  doAssertRaises(
    AssertionDefect
  ):
    discard cumulative.sum(
      0,
      3,
      0,
      1,
    )

  doAssertRaises(
    AssertionDefect
  ):
    discard cumulative.sum(
      0,
      1,
      -1,
      1,
    )

  doAssertRaises(
    AssertionDefect
  ):
    discard cumulative.sum(
      0,
      1,
      2,
      1,
    )

  doAssertRaises(
    AssertionDefect
  ):
    discard cumulative.sum(
      0,
      1,
      0,
      4,
    )

type
  CS2DExtBox =
    distinct int64

proc `+`(
    first,
    second:
      CS2DExtBox
): CS2DExtBox =
  CS2DExtBox(
    int64(first) +
    int64(second)
  )

proc `-`(
    first,
    second:
      CS2DExtBox
): CS2DExtBox =
  CS2DExtBox(
    int64(first) -
    int64(second)
  )

proc `+=`(
    target:
      var CS2DExtBox,
    value:
      CS2DExtBox
) =
  target =
    target + value

block cs2dExtCustomCarrier:
  var cumulative =
    initCumulativeSum2D[
      CS2DExtBox
    ](
      3,
      4,
    )

  cumulative.add(
    0,
    0,
    CS2DExtBox(5),
  )

  cumulative.add(
    1,
    2,
    CS2DExtBox(7),
  )

  cumulative.add(
    2,
    3,
    CS2DExtBox(-3),
  )

  cumulative.build()

  doAssert int64(
    cumulative.allSum
  ) == 9

  doAssert int64(
    cumulative.sum(
      1,
      3,
      2,
      4,
    )
  ) == 4

  let matrix =
    @[
      @[
        CS2DExtBox(1),
        CS2DExtBox(2),
      ],
      @[
        CS2DExtBox(3),
        CS2DExtBox(4),
      ],
    ]

  let fromMatrix =
    initCumulativeSum2D(
      matrix
    )

  doAssert int64(
    fromMatrix.allSum
  ) == 10

  doAssert int64(
    fromMatrix[
      0 .. 1,
      1 .. 1,
    ]
  ) == 6

block cs2dExtZeroWidthMatrix:
  let matrix =
    @[
      newSeq[int](),
      newSeq[int](),
    ]

  let cumulative =
    initCumulativeSum2D(
      matrix
    )

  doAssert cumulative.height == 2
  doAssert cumulative.width == 0
  doAssert cumulative.allSum == 0

echo "CUMULATIVE_SUM_2D_EXTENDED_CONTRACT_OK"

# NIM_ACL_CUMULATIVE_SUM_2D_FOCUSED_EXTENSION_END
