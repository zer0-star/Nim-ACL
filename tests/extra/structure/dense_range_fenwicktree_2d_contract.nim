import atcoder/modint
import atcoder/extra/structure/dense_range_fenwicktree_2d

type
  mint = modint998244353

  NaiveGrid = object
    data: seq[seq[int64]]

proc initNaiveGrid(
    height,
    width: int,
): NaiveGrid =
  result.data =
    newSeq[seq[int64]](height)

  for row in 0 ..< height:
    result.data[row] =
      newSeq[int64](width)

proc add(
    grid: var NaiveGrid,
    rowBegin,
    rowEnd,
    colBegin,
    colEnd: int,
    delta: int64,
) =
  for row in rowBegin ..< rowEnd:
    for col in colBegin ..< colEnd:
      grid.data[row][col] += delta

proc sum(
    grid: NaiveGrid,
    rowBegin,
    rowEnd,
    colBegin,
    colEnd: int,
): int64 =
  for row in rowBegin ..< rowEnd:
    for col in colBegin ..< colEnd:
      result += grid.data[row][col]

proc nextState(
    state: var uint64,
): uint64 =
  state =
    state * 6364136223846793005'u64 +
    1442695040888963407'u64

  state

proc nextInt(
    state: var uint64,
    bound: int,
): int =
  doAssert bound > 0
  int(
    state.nextState mod uint64(bound)
  )

proc randomRange(
    state: var uint64,
    size: int,
): tuple[
    beginIndex,
    endIndex: int,
] =
  result.beginIndex =
    state.nextInt(size + 1)

  result.endIndex =
    result.beginIndex +
    state.nextInt(
      size - result.beginIndex + 1,
    )

block emptyDimensions:
  var zeroZero =
    initDenseRangeFenwickTree2D[int64](
      0,
      0,
    )

  zeroZero.add(
    0,
    0,
    0,
    0,
    123'i64,
  )

  doAssert zeroZero.sum(
    0,
    0,
    0,
    0,
  ) == 0'i64

  var zeroByThree =
    initDenseRangeFenwickTree2D[int64](
      0,
      3,
    )

  zeroByThree.add(
    0,
    0,
    0,
    3,
    456'i64,
  )

  doAssert zeroByThree.sum(
    0,
    0,
    0,
    3,
  ) == 0'i64

  var threeByZero =
    initDenseRangeFenwickTree2D[int64](
      3,
      0,
    )

  threeByZero.add(
    0,
    3,
    0,
    0,
    789'i64,
  )

  doAssert threeByZero.sum(
    0,
    3,
    0,
    0,
  ) == 0'i64

block fixedCases:
  const
    Height = 4
    Width = 5

  var tree =
    initDenseRangeFenwickTree2D[int64](
      height = Height,
      width = Width,
    )

  var naive =
    initNaiveGrid(
      Height,
      Width,
    )

  let updates = [
    (0, 4, 0, 5, 3'i64),
    (1, 3, 2, 5, -2'i64),
    (0, 1, 0, 1, 7'i64),
    (2, 4, 1, 4, 5'i64),
    (4, 4, 0, 5, 999'i64),
    (0, 4, 5, 5, -999'i64),
  ]

  for update in updates:
    let (
      rowBegin,
      rowEnd,
      colBegin,
      colEnd,
      delta,
    ) = update

    tree.add(
      rowBegin,
      rowEnd,
      colBegin,
      colEnd,
      delta,
    )

    naive.add(
      rowBegin,
      rowEnd,
      colBegin,
      colEnd,
      delta,
    )

  tree.add(
    rowBegin = 0,
    rowEnd = 0,
    colBegin = 0,
    colEnd = Width,
    delta = 111'i64,
  )

  for rowBegin in 0 .. Height:
    for rowEnd in rowBegin .. Height:
      for colBegin in 0 .. Width:
        for colEnd in colBegin .. Width:
          doAssert tree.sum(
            rowBegin,
            rowEnd,
            colBegin,
            colEnd,
          ) == naive.sum(
            rowBegin,
            rowEnd,
            colBegin,
            colEnd,
          )

  for row in 0 ..< Height:
    for col in 0 ..< Width:
      doAssert tree.get(
        row = row,
        col = col,
      ) == naive.data[row][col]

block exhaustiveSingleUpdates:
  const Deltas = [
    -3'i64,
    -1'i64,
    0'i64,
    2'i64,
    5'i64,
  ]

  for height in 0 .. 4:
    for width in 0 .. 4:
      for rowBegin in 0 .. height:
        for rowEnd in rowBegin .. height:
          for colBegin in 0 .. width:
            for colEnd in colBegin .. width:
              for delta in Deltas:
                var tree =
                  initDenseRangeFenwickTree2D[int64](
                    height,
                    width,
                  )

                var naive =
                  initNaiveGrid(
                    height,
                    width,
                  )

                tree.add(
                  rowBegin,
                  rowEnd,
                  colBegin,
                  colEnd,
                  delta,
                )

                naive.add(
                  rowBegin,
                  rowEnd,
                  colBegin,
                  colEnd,
                  delta,
                )

                for queryRowBegin in 0 .. height:
                  for queryRowEnd in queryRowBegin .. height:
                    for queryColBegin in 0 .. width:
                      for queryColEnd in queryColBegin .. width:
                        doAssert tree.sum(
                          queryRowBegin,
                          queryRowEnd,
                          queryColBegin,
                          queryColEnd,
                        ) == naive.sum(
                          queryRowBegin,
                          queryRowEnd,
                          queryColBegin,
                          queryColEnd,
                        )

block deterministicRandomDifferential:
  var state = 20260719'u64

  for caseIndex in 0 ..< 500:
    let
      height = state.nextInt(9)
      width = state.nextInt(9)

    var tree =
      initDenseRangeFenwickTree2D[int64](
        height,
        width,
      )

    var naive =
      initNaiveGrid(
        height,
        width,
      )

    for operationIndex in 0 ..< 80:
      let
        rowRange =
          state.randomRange(height)
        colRange =
          state.randomRange(width)

      if state.nextInt(100) < 58:
        let delta =
          int64(
            state.nextInt(2001) - 1000
          )

        tree.add(
          rowRange.beginIndex,
          rowRange.endIndex,
          colRange.beginIndex,
          colRange.endIndex,
          delta,
        )

        naive.add(
          rowRange.beginIndex,
          rowRange.endIndex,
          colRange.beginIndex,
          colRange.endIndex,
          delta,
        )
      else:
        doAssert tree.sum(
          rowRange.beginIndex,
          rowRange.endIndex,
          colRange.beginIndex,
          colRange.endIndex,
        ) == naive.sum(
          rowRange.beginIndex,
          rowRange.endIndex,
          colRange.beginIndex,
          colRange.endIndex,
        )

      discard caseIndex
      discard operationIndex

    for row in 0 ..< height:
      for col in 0 ..< width:
        doAssert tree.get(
          row,
          col,
        ) == naive.data[row][col]

block modintCase:
  var tree =
    initDenseRangeFenwickTree2D[mint](
      3,
      4,
    )

  tree.add(
    0,
    3,
    0,
    4,
    mint(5),
  )

  tree.add(
    1,
    3,
    2,
    4,
    mint(-2),
  )

  tree.add(
    0,
    1,
    0,
    1,
    mint(7),
  )

  doAssert tree.get(
    0,
    0,
  ) == mint(12)

  doAssert tree.get(
    1,
    2,
  ) == mint(3)

  doAssert tree.get(
    2,
    3,
  ) == mint(3)

  doAssert tree.sum(
    0,
    3,
    0,
    4,
  ) == mint(59)

  doAssert tree.sum(
    1,
    3,
    2,
    4,
  ) == mint(12)

echo "DENSE_RANGE_FENWICKTREE_2D_CONTRACT_OK"
