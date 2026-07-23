import std/sequtils
import atcoder/extra/monoid/monoid
import atcoder/extra/structure/dense_dual_segtree_2d

proc addAction(a, b: int64): int64 = a + b
proc zeroAction(): int64 = 0'i64

type
  AdditiveActionMonoid =
    CommutativeMonoidOf(
      int64,
      addAction,
      zeroAction,
    )

  AdditiveMapper = object

proc mapping(
    _: typedesc[AdditiveMapper],
    action,
    value: int64
): int64 =
  value + action

proc xorAction(a, b: uint64): uint64 = a xor b
proc zeroXor(): uint64 = 0'u64

type
  XorActionMonoid =
    CommutativeMonoidOf(
      uint64,
      xorAction,
      zeroXor,
    )

  XorMapper = object

proc mapping(
    _: typedesc[XorMapper],
    action,
    value: uint64
): uint64 =
  value xor action

proc nextState(state: var uint64): uint64 =
  state =
    state * 6364136223846793005'u64 +
    1442695040888963407'u64
  state

proc nextInt(state: var uint64, bound: int): int =
  int(state.nextState mod uint64(bound))

block fixedAdditive:
  let values = @[
    @[1'i64, 2, 3, 4],
    @[5'i64, 6, 7, 8],
    @[9'i64, 10, 11, 12],
  ]

  var tree =
    initDenseDualSegTree2D[
      int64,
      AdditiveActionMonoid,
      AdditiveMapper
    ](
      values,
      AdditiveActionMonoid,
      AdditiveMapper,
    )

  tree.apply(0, 3, 0, 4, 5'i64)
  tree.apply(1, 3, 2, 4, -3'i64)

  doAssert tree[0, 0] == 6
  doAssert tree[1, 1] == 11
  doAssert tree[1, 2] == 9
  doAssert tree[2, 3] == 14

block fixedXor:
  let values = @[
    @[1'u64, 2, 3],
    @[4'u64, 5, 6],
  ]

  var tree =
    initDenseDualSegTree2D[
      uint64,
      XorActionMonoid,
      XorMapper
    ](
      values,
      XorActionMonoid,
      XorMapper,
    )

  tree.apply(0, 2, 0, 3, 7'u64)
  tree.apply(0, 1, 1, 3, 3'u64)

  doAssert tree[0, 0] == (1'u64 xor 7'u64)
  doAssert tree[0, 1] == (2'u64 xor 7'u64 xor 3'u64)
  doAssert tree[1, 2] == (6'u64 xor 7'u64)

block zeroDimensions:
  var zeroHeight =
    initDenseDualSegTree2D[
      int64,
      AdditiveActionMonoid,
      AdditiveMapper
    ](
      0,
      4,
      7'i64,
      AdditiveActionMonoid,
      AdditiveMapper,
    )

  zeroHeight.apply(0, 0, 0, 4, 10'i64)

  var zeroWidth =
    initDenseDualSegTree2D[
      int64,
      AdditiveActionMonoid,
      AdditiveMapper
    ](
      3,
      0,
      7'i64,
      AdditiveActionMonoid,
      AdditiveMapper,
    )

  zeroWidth.apply(0, 3, 0, 0, 10'i64)

block exhaustiveSingleUpdate:
  for height in 0 .. 3:
    for width in 0 .. 4:
      for rowBegin in 0 .. height:
        for rowEnd in rowBegin .. height:
          for colBegin in 0 .. width:
            for colEnd in colBegin .. width:
              var tree =
                initDenseDualSegTree2D[
                  int64,
                  AdditiveActionMonoid,
                  AdditiveMapper
                ](
                  height,
                  width,
                  2'i64,
                  AdditiveActionMonoid,
                  AdditiveMapper,
                )

              tree.apply(
                rowBegin,
                rowEnd,
                colBegin,
                colEnd,
                9'i64,
              )

              for row in 0 ..< height:
                for col in 0 ..< width:
                  let inside =
                    rowBegin <= row and
                    row < rowEnd and
                    colBegin <= col and
                    col < colEnd

                  let expected =
                    if inside:
                      11'i64
                    else:
                      2'i64

                  doAssert tree[row, col] == expected

block randomDifferential:
  var state = 20260723'u64

  for caseIndex in 0 ..< 160:
    let
      height = state.nextInt(8) + 1
      width = state.nextInt(9) + 1

    var additiveValues =
      newSeqWith(
        height,
        newSeq[int64](width),
      )

    var xorValues =
      newSeqWith(
        height,
        newSeq[uint64](width),
      )

    for row in 0 ..< height:
      for col in 0 ..< width:
        additiveValues[row][col] =
          int64(state.nextInt(2001) - 1000)
        xorValues[row][col] =
          uint64(state.nextInt(256))

    var additiveNaive = additiveValues
    var xorNaive = xorValues

    var additiveTree =
      initDenseDualSegTree2D[
        int64,
        AdditiveActionMonoid,
        AdditiveMapper
      ](
        additiveValues,
        AdditiveActionMonoid,
        AdditiveMapper,
      )

    var xorTree =
      initDenseDualSegTree2D[
        uint64,
        XorActionMonoid,
        XorMapper
      ](
        xorValues,
        XorActionMonoid,
        XorMapper,
      )

    for operationIndex in 0 ..< 100:
      if state.nextInt(10) < 7:
        let
          rowBegin = state.nextInt(height + 1)
          rowEnd =
            rowBegin +
            state.nextInt(height - rowBegin + 1)
          colBegin = state.nextInt(width + 1)
          colEnd =
            colBegin +
            state.nextInt(width - colBegin + 1)
          additiveValue =
            int64(state.nextInt(61) - 30)
          xorValue =
            uint64(state.nextInt(256))

        additiveTree.apply(
          rowBegin,
          rowEnd,
          colBegin,
          colEnd,
          additiveValue,
        )

        xorTree.apply(
          rowBegin,
          rowEnd,
          colBegin,
          colEnd,
          xorValue,
        )

        for row in rowBegin ..< rowEnd:
          for col in colBegin ..< colEnd:
            additiveNaive[row][col] += additiveValue
            xorNaive[row][col] =
              xorNaive[row][col] xor xorValue
      else:
        let
          row = state.nextInt(height)
          col = state.nextInt(width)

        doAssert additiveTree[row, col] ==
          additiveNaive[row][col]

        doAssert xorTree[row, col] ==
          xorNaive[row][col]

      discard caseIndex
      discard operationIndex

    for row in 0 ..< height:
      for col in 0 ..< width:
        doAssert additiveTree[row, col] ==
          additiveNaive[row][col]

        doAssert xorTree[row, col] ==
          xorNaive[row][col]

type
  Box = object
    value: int

  BoxMapper = object

proc mapping(
    _: typedesc[BoxMapper],
    action: int64,
    value: Box
): Box =
  Box(value: value.value + int(action))

block genericValue:
  let values = @[
    @[Box(value: 1), Box(value: 2)],
    @[Box(value: 3), Box(value: 4)],
  ]

  var tree =
    initDenseDualSegTree2D[
      Box,
      AdditiveActionMonoid,
      BoxMapper
    ](
      values,
      AdditiveActionMonoid,
      BoxMapper,
    )

  tree.apply(0, 2, 1, 2, 5'i64)

  doAssert tree[0, 0].value == 1
  doAssert tree[0, 1].value == 7
  doAssert tree[1, 1].value == 9

echo "DENSE_DUAL_SEGTREE_2D_CONTRACT_OK"
