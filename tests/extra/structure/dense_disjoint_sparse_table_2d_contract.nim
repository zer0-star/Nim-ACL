import std/sequtils
import atcoder/extra/monoid/monoid
import atcoder/extra/structure/dense_disjoint_sparse_table_2d

proc addInt64(
    a,
    b: int64
): int64 =
  a + b

proc zeroInt64(): int64 =
  0'i64

type
  AdditiveInt64Monoid =
    CommutativeMonoidOf(
      int64,
      addInt64,
      zeroInt64,
    )

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

proc naiveSum(
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
    0

  for row in rowBegin ..< rowEnd:
    for col in colBegin ..< colEnd:
      result +=
        values[row][col]

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
    initDenseDisjointSparseTable2D(
      height = 0,
      width = 0,
      AdditiveInt64Monoid,
    )

  doAssert zeroZero.height == 0
  doAssert zeroZero.width == 0
  doAssert zeroZero.allProd == 0

  let zeroHeight =
    initDenseDisjointSparseTable2D(
      height = 0,
      width = 4,
      AdditiveInt64Monoid,
    )

  doAssert zeroHeight.height == 0
  doAssert zeroHeight.width == 4

  doAssert zeroHeight.prod(
    rowBegin = 0,
    rowEnd = 0,
    colBegin = 0,
    colEnd = 4,
  ) == 0

  let zeroWidth =
    initDenseDisjointSparseTable2D(
      height = 3,
      width = 0,
      AdditiveInt64Monoid,
    )

  doAssert zeroWidth.height == 3
  doAssert zeroWidth.width == 0

  doAssert zeroWidth.prod(
    0,
    3,
    0,
    0,
  ) == 0

block nonSquareFixedSum:
  let values = @[
    @[1'i64, 2, 3, 4],
    @[5'i64, 6, 7, 8],
    @[9'i64, 10, 11, 12],
  ]

  let table =
    initDenseDisjointSparseTable2D[
      AdditiveInt64Monoid
    ](
      values,
      AdditiveInt64Monoid,
    )

  doAssert table.height == 3
  doAssert table.width == 4
  doAssert table.allProd == 78

  doAssert table.prod(
    rowBegin = 0,
    rowEnd = 2,
    colBegin = 1,
    colEnd = 4,
  ) == 30

  doAssert table.prod(
    2,
    3,
    3,
    4,
  ) == 12

  doAssert table.get(
    row = 1,
    col = 2,
  ) == 7

  doAssert table[0, 3] == 4

block exhaustiveSmallAdditive:
  for height in 0 .. 5:
    for width in 0 .. 6:
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
              17 * row -
              5 * col +
              3
            )

      let table =
        if height == 0:
          initDenseDisjointSparseTable2D(
            height,
            width,
            AdditiveInt64Monoid,
          )
        else:
          initDenseDisjointSparseTable2D[
            AdditiveInt64Monoid
          ](
            values,
            AdditiveInt64Monoid,
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
              ) == naiveSum(
                values,
                rowBegin,
                rowEnd,
                colBegin,
                colEnd,
              )

block deterministicRandomDifferential:
  var state =
    20260723'u64

  for caseIndex in 0 ..< 250:
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

    let sumTable =
      if height == 0:
        initDenseDisjointSparseTable2D(
          height,
          width,
          AdditiveInt64Monoid,
        )
      else:
        initDenseDisjointSparseTable2D[
          AdditiveInt64Monoid
        ](
          values,
          AdditiveInt64Monoid,
        )

    let minimumTable =
      if height == 0:
        initDenseDisjointSparseTable2D(
          height,
          width,
          MinimumInt64Monoid,
        )
      else:
        initDenseDisjointSparseTable2D[
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

      doAssert sumTable.prod(
        rowBegin,
        rowEnd,
        colBegin,
        colEnd,
      ) == naiveSum(
        values,
        rowBegin,
        rowEnd,
        colBegin,
        colEnd,
      )

      doAssert minimumTable.prod(
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

proc addBox(
    a,
    b: Box
): Box =
  Box(
    value:
      a.value + b.value
  )

proc zeroBox(): Box =
  Box(
    value:
      0
  )

type
  AdditiveBoxMonoid =
    CommutativeMonoidOf(
      Box,
      addBox,
      zeroBox,
    )

block genericCommutativeMonoid:
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
    initDenseDisjointSparseTable2D[
      AdditiveBoxMonoid
    ](
      values,
      AdditiveBoxMonoid,
    )

  doAssert table.allProd.value == 33

  doAssert table.prod(
    1,
    2,
    1,
    3,
  ).value == 10

block memoryShapeSanity:
  let table =
    initDenseDisjointSparseTable2D[
      AdditiveInt64Monoid
    ](
      newSeqWith(
        17,
        newSeqWith(
          19,
          1'i64,
        ),
      ),
      AdditiveInt64Monoid,
    )

  doAssert table.height == 17
  doAssert table.width == 19
  doAssert table.allProd == 323

echo "DENSE_DISJOINT_SPARSE_TABLE_2D_CONTRACT_OK"
