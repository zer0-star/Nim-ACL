import atcoder/extra/monoid/monoid
import atcoder/extra/structure/dense_segtree_2d

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

proc naiveProd(
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
  for row in rowBegin ..< rowEnd:
    for col in colBegin ..< colEnd:
      result +=
        values[row][col]

block dimensionsAndZero:
  let zeroZero =
    initDenseSegTree2D(
      height = 0,
      width = 0,
      AdditiveInt64Monoid,
    )

  doAssert zeroZero.height == 0
  doAssert zeroZero.width == 0
  doAssert zeroZero.allProd == 0
  doAssert zeroZero.prod(
    rowBegin = 0,
    rowEnd = 0,
    colBegin = 0,
    colEnd = 0,
  ) == 0

  let zeroHeight =
    initDenseSegTree2D(
      height = 0,
      width = 4,
      AdditiveInt64Monoid,
    )

  doAssert zeroHeight.height == 0
  doAssert zeroHeight.width == 4
  doAssert zeroHeight.allProd == 0
  doAssert zeroHeight.prod(
    rowBegin = 0,
    rowEnd = 0,
    colBegin = 0,
    colEnd = 4,
  ) == 0

  let zeroWidth =
    initDenseSegTree2D(
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

block nonSquareBuildAndSet:
  let values = @[
    @[1'i64, 2, 3, 4],
    @[5'i64, 6, 7, 8],
    @[9'i64, 10, 11, 12],
  ]

  var tree =
    initDenseSegTree2D[AdditiveInt64Monoid](
      values,
      AdditiveInt64Monoid,
    )

  doAssert tree.height == 3
  doAssert tree.width == 4
  doAssert tree.allProd == 78

  doAssert tree.prod(
    rowBegin = 1,
    rowEnd = 3,
    colBegin = 1,
    colEnd = 4,
  ) == 54

  doAssert tree.get(
    row = 2,
    col = 3,
  ) == 12

  doAssert tree[0, 2] == 3

  doAssert tree.prod(
    1,
    1,
    0,
    4,
  ) == 0

  tree.set(
    row = 1,
    col = 2,
    value = 100,
  )

  doAssert tree.get(
    1,
    2,
  ) == 100

  doAssert tree.prod(
    1,
    2,
    0,
    4,
  ) == 119

  doAssert tree.allProd == 171

block exhaustiveSmall:
  for height in 0 .. 3:
    for width in 0 .. 4:
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
              10 * row + col - 7
            )

      var tree =
        if height == 0:
          initDenseSegTree2D(
            height,
            width,
            AdditiveInt64Monoid,
          )
        else:
          initDenseSegTree2D[AdditiveInt64Monoid](
            values,
            AdditiveInt64Monoid,
          )

      for rowBegin in 0 .. height:
        for rowEnd in rowBegin .. height:
          for colBegin in 0 .. width:
            for colEnd in colBegin .. width:
              doAssert tree.prod(
                rowBegin,
                rowEnd,
                colBegin,
                colEnd,
              ) == naiveProd(
                values,
                rowBegin,
                rowEnd,
                colBegin,
                colEnd,
              )

      for row in 0 ..< height:
        for col in 0 ..< width:
          let replacement =
            int64(
              1000 + 13 * row + col
            )

          values[row][col] =
            replacement

          tree.set(
            row,
            col,
            replacement,
          )

          doAssert tree.get(
            row,
            col,
          ) == replacement

          doAssert tree.allProd ==
            naiveProd(
              values,
              0,
              height,
              0,
              width,
            )

block deterministicRandomDifferential:
  var state =
    20260721'u64

  for caseIndex in 0 ..< 500:
    let
      height =
        state.nextInt(9)
      width =
        state.nextInt(10)

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
            state.nextInt(201) - 100
          )

    var tree =
      if height == 0:
        initDenseSegTree2D(
          height,
          width,
          AdditiveInt64Monoid,
        )
      else:
        initDenseSegTree2D[AdditiveInt64Monoid](
          values,
          AdditiveInt64Monoid,
        )

    for operationIndex in 0 ..< 100:
      if height > 0 and
         width > 0 and
         state.nextInt(100) < 45:
        let
          row =
            state.nextInt(height)
          col =
            state.nextInt(width)
          value =
            int64(
              state.nextInt(2001) - 1000
            )

        values[row][col] =
          value

        tree.set(
          row,
          col,
          value,
        )

        doAssert tree.get(
          row,
          col,
        ) == value
      else:
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

        doAssert tree.prod(
          rowBegin,
          rowEnd,
          colBegin,
          colEnd,
        ) == naiveProd(
          values,
          rowBegin,
          rowEnd,
          colBegin,
          colEnd,
        )

      discard caseIndex
      discard operationIndex

type
  Box =
    object
      value:
        int

proc combineBox(
    a,
    b: Box
): Box =
  Box(
    value:
      a.value + b.value
  )

proc emptyBox(): Box =
  Box(
    value:
      0
  )

type
  BoxMonoid =
    CommutativeMonoidOf(
      Box,
      combineBox,
      emptyBox,
    )

block genericCommutativeMonoid:
  let values = @[
    @[
      Box(value: 1),
      Box(value: 2),
      Box(value: 3),
    ],
    @[
      Box(value: 4),
      Box(value: 5),
      Box(value: 6),
    ],
  ]

  var tree =
    initDenseSegTree2D[BoxMonoid](
      values,
      BoxMonoid,
    )

  doAssert tree.allProd.value == 21

  tree.set(
    1,
    2,
    Box(value: 10),
  )

  doAssert tree.prod(
    0,
    2,
    1,
    3,
  ).value == 20

echo "DENSE_SEGTREE_2D_CONTRACT_OK"
