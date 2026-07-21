import atcoder/extra/monoid/monoid
import atcoder/extra/structure/dense_sparse_table_2d

proc minimumInt64(
    a,
    b: int64
): int64 =
  min(
    a,
    b,
  )

proc positiveInfinityInt64(): int64 =
  high(int64)

type
  MinimumInt64Monoid =
    CommutativeMonoidOf(
      int64,
      minimumInt64,
      positiveInfinityInt64,
    )

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
    bound: int
): int =
  doAssert bound > 0

  int(
    state.nextState mod uint64(bound)
  )

proc naiveMinimum(
    values:
      seq[
        seq[
          int64
        ]
      ],
    rowBegin,
    rowEnd,
    colBegin,
    colEnd: int
): int64 =
  result =
    high(int64)

  for row in rowBegin ..< rowEnd:
    for col in colBegin ..< colEnd:
      result =
        min(
          result,
          values[row][col],
        )

block zeroDimensions:
  let zeroZero =
    initDenseSparseTable2D(
      height = 0,
      width = 0,
      MinimumInt64Monoid,
    )

  doAssert zeroZero.height == 0
  doAssert zeroZero.width == 0
  doAssert zeroZero.allProd == high(int64)

  let zeroHeight =
    initDenseSparseTable2D(
      height = 0,
      width = 4,
      MinimumInt64Monoid,
    )

  doAssert zeroHeight.height == 0
  doAssert zeroHeight.width == 4

  doAssert zeroHeight.prod(
    rowBegin = 0,
    rowEnd = 0,
    colBegin = 0,
    colEnd = 4,
  ) == high(int64)

  let zeroWidth =
    initDenseSparseTable2D(
      height = 3,
      width = 0,
      MinimumInt64Monoid,
    )

  doAssert zeroWidth.height == 3
  doAssert zeroWidth.width == 0

  doAssert zeroWidth.prod(
    0,
    3,
    0,
    0,
  ) == high(int64)

block nonSquareFixed:
  let values = @[
    @[9'i64, 5, 7, 3],
    @[8'i64, 6, 4, 2],
    @[1'i64, 10, 11, 12],
  ]

  let table =
    initDenseSparseTable2D[
      MinimumInt64Monoid
    ](
      values,
      MinimumInt64Monoid,
    )

  doAssert table.height == 3
  doAssert table.width == 4
  doAssert table.allProd == 1

  doAssert table.prod(
    rowBegin = 0,
    rowEnd = 2,
    colBegin = 1,
    colEnd = 4,
  ) == 2

  doAssert table.prod(
    2,
    3,
    0,
    1,
  ) == 1

  doAssert table.get(
    row = 1,
    col = 2,
  ) == 4

  doAssert table[0, 3] == 3

block exhaustiveSmall:
  for height in 0 .. 4:
    for width in 0 .. 5:
      var values =
        newSeq[
          seq[
            int64
          ]
        ](
          height
        )

      for row in 0 ..< height:
        values[row] =
          newSeq[
            int64
          ](
            width
          )

        for col in 0 ..< width:
          values[row][col] =
            int64(
              100 -
              11 * row -
              3 * col
            )

      let table =
        if height == 0:
          initDenseSparseTable2D(
            height,
            width,
            MinimumInt64Monoid,
          )
        else:
          initDenseSparseTable2D[
            MinimumInt64Monoid
          ](
            values,
            MinimumInt64Monoid,
          )

      for rowBegin in 0 .. height:
        for rowEnd in rowBegin .. height:
          for colBegin in 0 .. width:
            for colEnd in colBegin .. width:
              doAssert table.prod(
                rowBegin,
                rowEnd,
                colBegin,
                colEnd,
              ) == naiveMinimum(
                values,
                rowBegin,
                rowEnd,
                colBegin,
                colEnd,
              )

block deterministicRandomDifferential:
  var state =
    20260721'u64

  for caseIndex in 0 ..< 300:
    let
      height =
        state.nextInt(10)
      width =
        state.nextInt(11)

    var values =
      newSeq[
        seq[
          int64
        ]
      ](
        height
      )

    for row in 0 ..< height:
      values[row] =
        newSeq[
          int64
        ](
          width
        )

      for col in 0 ..< width:
        values[row][col] =
          int64(
            state.nextInt(2001) - 1000
          )

    let table =
      if height == 0:
        initDenseSparseTable2D(
          height,
          width,
          MinimumInt64Monoid,
        )
      else:
        initDenseSparseTable2D[
          MinimumInt64Monoid
        ](
          values,
          MinimumInt64Monoid,
        )

    for queryIndex in 0 ..< 100:
      let
        rowBegin =
          state.nextInt(height + 1)
        rowEnd =
          rowBegin +
          state.nextInt(
            height - rowBegin + 1
          )
        colBegin =
          state.nextInt(width + 1)
        colEnd =
          colBegin +
          state.nextInt(
            width - colBegin + 1
          )

      doAssert table.prod(
        rowBegin,
        rowEnd,
        colBegin,
        colEnd,
      ) == naiveMinimum(
        values,
        rowBegin,
        rowEnd,
        colBegin,
        colEnd,
      )

      discard caseIndex
      discard queryIndex

type
  Box =
    object
      value:
        int

proc minimumBox(
    a,
    b: Box
): Box =
  if a.value <= b.value:
    a
  else:
    b

proc positiveInfinityBox(): Box =
  Box(
    value:
      high(int)
  )

type
  MinimumBoxMonoid =
    CommutativeMonoidOf(
      Box,
      minimumBox,
      positiveInfinityBox,
    )

block genericIdempotentCommutativeMonoid:
  let values = @[
    @[
      Box(value: 5),
      Box(value: 2),
      Box(value: 9),
    ],
    @[
      Box(value: 7),
      Box(value: 4),
      Box(value: 6),
    ],
  ]

  let table =
    initDenseSparseTable2D[
      MinimumBoxMonoid
    ](
      values,
      MinimumBoxMonoid,
    )

  doAssert table.allProd.value == 2

  doAssert table.prod(
    1,
    2,
    1,
    3,
  ).value == 4

echo "DENSE_SPARSE_TABLE_2D_CONTRACT_OK"
