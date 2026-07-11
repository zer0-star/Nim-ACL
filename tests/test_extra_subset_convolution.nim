import std/[
  bitops,
  unittest,
]

import atcoder/modint
import atcoder/extra/math/subset_convolution


type
  mint = modint998244353


proc m(
    value: int,
): mint {.inline.} =
  mint.init(value)


proc naiveSubsetConvolution[T](
    f,
    g: openArray[T],
): seq[T] =
  doAssert f.len == g.len

  result = newSeq[T](f.len)

  for mask in 0 ..< f.len:
    var subset = mask

    while true:
      result[mask] +=
        f[subset] *
        g[mask xor subset]

      if subset == 0:
        break

      subset =
        (subset - 1) and mask


proc nextRandom(
    state: var uint64,
): uint64 {.inline.} =
  state = state xor (state shl 7)
  state = state xor (state shr 9)
  state = state xor (state shl 8)
  state


suite "subsetConvolution":
  test "one-element input":
    check subsetConvolution(
      @[m(3)],
      @[m(4)],
    ) == @[m(12)]

  test "known example":
    let
      f = @[m(1), m(2), m(3), m(4)]
      g = @[m(5), m(6), m(7), m(8)]

    check subsetConvolution(
      f,
      g,
    ) == @[
      m(5),
      m(16),
      m(22),
      m(60),
    ]

  test "inputs are preserved":
    let
      f = @[m(1), m(2), m(3), m(4)]
      g = @[m(5), m(6), m(7), m(8)]

      originalF = f
      originalG = g

    discard subsetConvolution(
      f,
      g,
    )

    check f == originalF
    check g == originalG

  test "length mismatch is rejected":
    expect ValueError:
      discard subsetConvolution(
        @[m(1), m(2)],
        @[m(3)],
      )

  test "empty input is rejected":
    expect ValueError:
      discard subsetConvolution(
        newSeq[mint](),
        newSeq[mint](),
      )

  test "non-power-of-two length is rejected":
    expect ValueError:
      discard subsetConvolution(
        @[m(1), m(2), m(3)],
        @[m(4), m(5), m(6)],
      )

  test "randomized naive differential":
    var state =
      0x57a3_10ce_8d29_f64b'u64

    for bitCount in 0 .. 9:
      let size = 1 shl bitCount

      for _ in 0 ..< 12:
        var
          f = newSeq[mint](size)
          g = newSeq[mint](size)

        for i in 0 ..< size:
          f[i] =
            mint.init(
              int(nextRandom(state) mod 1000'u64)
            )

          g[i] =
            mint.init(
              int(nextRandom(state) mod 1000'u64)
            )

        check subsetConvolution(
          f,
          g,
        ) == naiveSubsetConvolution(
          f,
          g,
        )
