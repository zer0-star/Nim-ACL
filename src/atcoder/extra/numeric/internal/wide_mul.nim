import atcoder/extra/numeric/int128
import atcoder/extra/numeric/internal/limbs

func multiply64(
    a,
    b: uint64,
): tuple[
    low: uint64,
    high: uint64,
] =
  let product =
    toUInt128(a) *
    toUInt128(b)

  (
    low64(product),
    high64(product),
  )

proc addWordAt(
    destination: var UInt512Limbs,
    startIndex: int,
    word: uint64,
) =
  var index =
    startIndex

  var addend =
    word

  while addend != 0'u64 and
      index < 8:
    let previous =
      destination[index]

    let sum =
      previous + addend

    destination[index] =
      sum

    if sum < previous:
      addend =
        1'u64
    else:
      addend =
        0'u64

    inc index

func multiplyWide4x4*(
    a,
    b: UInt256Limbs,
): UInt512Limbs =
  for leftIndex in 0 ..< 4:
    for rightIndex in 0 ..< 4:
      let product =
        multiply64(
          a[leftIndex],
          b[rightIndex],
        )

      let resultIndex =
        leftIndex + rightIndex

      addWordAt(
        result,
        resultIndex,
        product.low,
      )

      addWordAt(
        result,
        resultIndex + 1,
        product.high,
      )
