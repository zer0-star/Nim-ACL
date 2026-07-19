import atcoder/modint
import atcoder/extra/math/formal_power_series
import atcoder/extra/math/ntt
import atcoder/extra/math/fft2d

type mint = modint998244353

proc makeMatrix(
    rows: seq[seq[int]],
): seq[FormalPowerSeries[mint]] =
  result = newSeq[FormalPowerSeries[mint]](rows.len)

  for i in 0 ..< rows.len:
    result[i] = initFormalPowerSeries[mint](rows[i])

proc assertSame(
    actual,
    expected: seq[FormalPowerSeries[mint]],
) =
  doAssert actual.len == expected.len

  for i in 0 ..< expected.len:
    doAssert actual[i].len == expected[i].len

    for j in 0 ..< expected[i].len:
      doAssert actual[i][j] == expected[i][j]

proc assertValues(
    actual: seq[FormalPowerSeries[mint]],
    expected: seq[seq[int]],
) =
  doAssert actual.len == expected.len

  for i in 0 ..< expected.len:
    doAssert actual[i].len == expected[i].len

    for j in 0 ..< expected[i].len:
      doAssert actual[i][j] == mint(expected[i][j])

block emptyInputs:
  let emptyMatrix =
    newSeq[FormalPowerSeries[mint]](0)

  doAssert multiply2d_naive(
    emptyMatrix,
    emptyMatrix,
  ).len == 0

  doAssert multiply2d_partially_naive(
    emptyMatrix,
    emptyMatrix,
  ).len == 0

  doAssert multiply2d(
    emptyMatrix,
    emptyMatrix,
  ).len == 0

  var emptyRowMatrix =
    newSeq[FormalPowerSeries[mint]](1)

  emptyRowMatrix[0] =
    initFormalPowerSeries[mint](0)

  doAssert multiply2d(
    emptyRowMatrix,
    emptyRowMatrix,
  ).len == 0

block exactSmallConvolution:
  let a = makeMatrix(@[
    @[1, 2],
    @[3, 4],
  ])

  let b = makeMatrix(@[
    @[5, 6],
    @[7, 8],
  ])

  let expected = makeMatrix(@[
    @[5, 16, 12],
    @[22, 60, 40],
    @[21, 52, 32],
  ])

  assertSame(
    multiply2d_naive(a, b),
    expected,
  )

  assertSame(
    multiply2d_partially_naive(a, b),
    expected,
  )

  assertSame(
    multiply2d(a, b),
    expected,
  )

block transformRoundTrip:
  let expected = @[
    @[1, 2, 3, 4],
    @[0, 0, 0, 0],
    @[5, 6, 7, 8],
    @[9, 10, 11, 12],
  ]

  var values = makeMatrix(expected)

  fft2d(values)
  ifft2d(values)

  assertValues(values, expected)

block deterministicEquivalence:
  var aRows = newSeq[seq[int]](7)
  var bRows = newSeq[seq[int]](7)

  for i in 0 ..< 7:
    aRows[i] = newSeq[int](7)
    bRows[i] = newSeq[int](7)

    for j in 0 ..< 7:
      aRows[i][j] =
        ((i * 7 + j) mod 11) - 5

      bRows[i][j] =
        ((i * 5 + j * 3) mod 13) - 6

  let a = makeMatrix(aRows)
  let b = makeMatrix(bRows)
  let expected = multiply2d_naive(a, b)

  assertSame(
    multiply2d_partially_naive(a, b),
    expected,
  )

  assertSame(
    multiply2d(a, b),
    expected,
  )

echo "FFT2D_CONTRACT_OK"
