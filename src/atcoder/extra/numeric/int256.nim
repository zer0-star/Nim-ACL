import std/hashes
import atcoder/extra/numeric/int128
import atcoder/extra/numeric/internal/limbs
import atcoder/extra/numeric/internal/wide_mul
import atcoder/extra/numeric/internal/wide_div

type
  UInt256* = object
    limb0: uint64
    limb1: uint64
    limb2: uint64
    limb3: uint64

  Int256* = object
    limb0: uint64
    limb1: uint64
    limb2: uint64
    limb3: uint64

func rawUInt256(
    limb0,
    limb1,
    limb2,
    limb3: uint64,
): UInt256 {.inline.} =
  UInt256(
    limb0: limb0,
    limb1: limb1,
    limb2: limb2,
    limb3: limb3,
  )

func rawInt256(
    limb0,
    limb1,
    limb2,
    limb3: uint64,
): Int256 {.inline.} =
  Int256(
    limb0: limb0,
    limb1: limb1,
    limb2: limb2,
    limb3: limb3,
  )

func limbs(
    value: UInt256,
): UInt256Limbs {.inline.} =
  [
    value.limb0,
    value.limb1,
    value.limb2,
    value.limb3,
  ]

func limbs(
    value: Int256,
): UInt256Limbs {.inline.} =
  [
    value.limb0,
    value.limb1,
    value.limb2,
    value.limb3,
  ]

func fromLimbs(
    value: UInt256Limbs,
): UInt256 {.inline.} =
  rawUInt256(
    value[0],
    value[1],
    value[2],
    value[3],
  )

func fromSignedLimbs(
    value: UInt256Limbs,
): Int256 {.inline.} =
  rawInt256(
    value[0],
    value[1],
    value[2],
    value[3],
  )

func zeroUInt256(): UInt256 {.inline.} =
  rawUInt256(
    0'u64,
    0'u64,
    0'u64,
    0'u64,
  )

func zeroInt256(): Int256 {.inline.} =
  rawInt256(
    0'u64,
    0'u64,
    0'u64,
    0'u64,
  )

func maxUInt256Value(): UInt256 {.inline.} =
  rawUInt256(
    high(uint64),
    high(uint64),
    high(uint64),
    high(uint64),
  )

func maxInt256Value(): Int256 {.inline.} =
  rawInt256(
    high(uint64),
    high(uint64),
    high(uint64),
    high(uint64) shr 1,
  )

func minInt256Value(): Int256 {.inline.} =
  rawInt256(
    0'u64,
    0'u64,
    0'u64,
    1'u64 shl 63,
  )

func negativeMagnitudeLimit(): UInt256 {.inline.} =
  rawUInt256(
    0'u64,
    0'u64,
    0'u64,
    1'u64 shl 63,
  )

func positiveMagnitudeLimit(): UInt256 {.inline.} =
  rawUInt256(
    high(uint64),
    high(uint64),
    high(uint64),
    high(uint64) shr 1,
  )

func fromUInt64Words*(
    word3,
    word2,
    word1,
    word0: uint64,
): UInt256 {.inline.} =
  rawUInt256(
    word0,
    word1,
    word2,
    word3,
  )

func fromInt256Bits*(
    word3,
    word2,
    word1,
    word0: uint64,
): Int256 {.inline.} =
  rawInt256(
    word0,
    word1,
    word2,
    word3,
  )

func fromUInt128Halves*(
    highHalf,
    lowHalf: UInt128,
): UInt256 {.inline.} =
  fromUInt64Words(
    high64(highHalf),
    low64(highHalf),
    high64(lowHalf),
    low64(lowHalf),
  )

func low128*(
    value: UInt256,
): UInt128 {.inline.} =
  fromUInt64Words(
    value.limb1,
    value.limb0,
  )

func high128*(
    value: UInt256,
): UInt128 {.inline.} =
  fromUInt64Words(
    value.limb3,
    value.limb2,
  )

func low128*(
    value: Int256,
): UInt128 {.inline.} =
  fromUInt64Words(
    value.limb1,
    value.limb0,
  )

func high128*(
    value: Int256,
): UInt128 {.inline.} =
  fromUInt64Words(
    value.limb3,
    value.limb2,
  )

func word64*(
    value: UInt256,
    index: range[0 .. 3],
): uint64 {.inline.} =
  case index
  of 0:
    value.limb0
  of 1:
    value.limb1
  of 2:
    value.limb2
  of 3:
    value.limb3

func word64*(
    value: Int256,
    index: range[0 .. 3],
): uint64 {.inline.} =
  case index
  of 0:
    value.limb0
  of 1:
    value.limb1
  of 2:
    value.limb2
  of 3:
    value.limb3

func asInt256*(
    value: UInt256,
): Int256 {.inline.} =
  rawInt256(
    value.limb0,
    value.limb1,
    value.limb2,
    value.limb3,
  )

func asUInt256*(
    value: Int256,
): UInt256 {.inline.} =
  rawUInt256(
    value.limb0,
    value.limb1,
    value.limb2,
    value.limb3,
  )

func toUInt256*(
    value: uint64,
): UInt256 {.inline.} =
  rawUInt256(
    value,
    0'u64,
    0'u64,
    0'u64,
  )

func toUInt256*(
    value: UInt128,
): UInt256 {.inline.} =
  rawUInt256(
    low64(value),
    high64(value),
    0'u64,
    0'u64,
  )

func toInt256*(
    value: int64,
): Int256 {.inline.} =
  if value < 0'i64:
    rawInt256(
      cast[uint64](value),
      high(uint64),
      high(uint64),
      high(uint64),
    )
  else:
    rawInt256(
      uint64(value),
      0'u64,
      0'u64,
      0'u64,
    )

func toInt256*(
    value: Int128,
): Int256 {.inline.} =
  let fill =
    if value < toInt128(0'i64):
      high(uint64)
    else:
      0'u64

  rawInt256(
    low64(value),
    high64(value),
    fill,
    fill,
  )

func isZero*(
    value: UInt256,
): bool {.inline.} =
  value.limb0 == 0'u64 and
  value.limb1 == 0'u64 and
  value.limb2 == 0'u64 and
  value.limb3 == 0'u64

func isZero*(
    value: Int256,
): bool {.inline.} =
  value.limb0 == 0'u64 and
  value.limb1 == 0'u64 and
  value.limb2 == 0'u64 and
  value.limb3 == 0'u64

func isNegative*(
    value: Int256,
): bool {.inline.} =
  (
    value.limb3 and
    (1'u64 shl 63)
  ) != 0'u64

func cmp*(
    a,
    b: UInt256,
): int {.inline.} =
  compare4(
    limbs(a),
    limbs(b),
  )

func cmp*(
    a,
    b: Int256,
): int {.inline.} =
  let aNegative =
    isNegative(a)

  let bNegative =
    isNegative(b)

  if aNegative != bNegative:
    if aNegative:
      -1
    else:
      1
  else:
    compare4(
      limbs(a),
      limbs(b),
    )

func `==`*(
    a,
    b: UInt256,
): bool {.inline.} =
  cmp(a, b) == 0

func `==`*(
    a,
    b: Int256,
): bool {.inline.} =
  cmp(a, b) == 0

func `<`*(
    a,
    b: UInt256,
): bool {.inline.} =
  cmp(a, b) < 0

func `<`*(
    a,
    b: Int256,
): bool {.inline.} =
  cmp(a, b) < 0

func `<=`*(
    a,
    b: UInt256,
): bool {.inline.} =
  cmp(a, b) <= 0

func `<=`*(
    a,
    b: Int256,
): bool {.inline.} =
  cmp(a, b) <= 0

func `>`*(
    a,
    b: UInt256,
): bool {.inline.} =
  cmp(a, b) > 0

func `>`*(
    a,
    b: Int256,
): bool {.inline.} =
  cmp(a, b) > 0

func `>=`*(
    a,
    b: UInt256,
): bool {.inline.} =
  cmp(a, b) >= 0

func `>=`*(
    a,
    b: Int256,
): bool {.inline.} =
  cmp(a, b) >= 0

func `and`*(
    a,
    b: UInt256,
): UInt256 {.inline.} =
  rawUInt256(
    a.limb0 and b.limb0,
    a.limb1 and b.limb1,
    a.limb2 and b.limb2,
    a.limb3 and b.limb3,
  )

func `and`*(
    a,
    b: Int256,
): Int256 {.inline.} =
  asInt256(
    asUInt256(a) and
    asUInt256(b)
  )

func `or`*(
    a,
    b: UInt256,
): UInt256 {.inline.} =
  rawUInt256(
    a.limb0 or b.limb0,
    a.limb1 or b.limb1,
    a.limb2 or b.limb2,
    a.limb3 or b.limb3,
  )

func `or`*(
    a,
    b: Int256,
): Int256 {.inline.} =
  asInt256(
    asUInt256(a) or
    asUInt256(b)
  )

func `xor`*(
    a,
    b: UInt256,
): UInt256 {.inline.} =
  rawUInt256(
    a.limb0 xor b.limb0,
    a.limb1 xor b.limb1,
    a.limb2 xor b.limb2,
    a.limb3 xor b.limb3,
  )

func `xor`*(
    a,
    b: Int256,
): Int256 {.inline.} =
  asInt256(
    asUInt256(a) xor
    asUInt256(b)
  )

func `not`*(
    value: UInt256,
): UInt256 {.inline.} =
  rawUInt256(
    not value.limb0,
    not value.limb1,
    not value.limb2,
    not value.limb3,
  )

func `not`*(
    value: Int256,
): Int256 {.inline.} =
  asInt256(
    not asUInt256(value)
  )

func `+`*(
    a,
    b: UInt256,
): UInt256 {.inline.} =
  fromLimbs(
    add4(
      limbs(a),
      limbs(b),
    ).value
  )

func `+`*(
    a,
    b: Int256,
): Int256 {.inline.} =
  asInt256(
    asUInt256(a) +
    asUInt256(b)
  )

func `-`*(
    a,
    b: UInt256,
): UInt256 {.inline.} =
  fromLimbs(
    sub4(
      limbs(a),
      limbs(b),
    ).value
  )

func `-`*(
    a,
    b: Int256,
): Int256 {.inline.} =
  asInt256(
    asUInt256(a) -
    asUInt256(b)
  )

func `-`*(
    value: UInt256,
): UInt256 {.inline.} =
  zeroUInt256() - value

func `-`*(
    value: Int256,
): Int256 {.inline.} =
  asInt256(
    -asUInt256(value)
  )

func shiftLeftUnsigned(
    value: UInt256,
    amount: int,
): UInt256 =
  if amount <= 0:
    return value

  if amount >= 256:
    return zeroUInt256()

  let wordShift =
    amount shr 6

  let bitShift =
    amount and 63

  let source =
    limbs(value)

  var destination:
    UInt256Limbs

  for destinationIndex in countdown(3, 0):
    let sourceIndex =
      destinationIndex - wordShift

    if sourceIndex < 0:
      continue

    destination[destinationIndex] =
      destination[destinationIndex] or
      (source[sourceIndex] shl bitShift)

    if bitShift != 0 and
        sourceIndex > 0:
      destination[destinationIndex] =
        destination[destinationIndex] or
        (
          source[sourceIndex - 1] shr
          (64 - bitShift)
        )

  fromLimbs(destination)

func shiftRightUnsigned(
    value: UInt256,
    amount: int,
): UInt256 =
  if amount <= 0:
    return value

  if amount >= 256:
    return zeroUInt256()

  let wordShift =
    amount shr 6

  let bitShift =
    amount and 63

  let source =
    limbs(value)

  var destination:
    UInt256Limbs

  for destinationIndex in 0 ..< 4:
    let sourceIndex =
      destinationIndex + wordShift

    if sourceIndex >= 4:
      continue

    destination[destinationIndex] =
      destination[destinationIndex] or
      (source[sourceIndex] shr bitShift)

    if bitShift != 0 and
        sourceIndex + 1 < 4:
      destination[destinationIndex] =
        destination[destinationIndex] or
        (
          source[sourceIndex + 1] shl
          (64 - bitShift)
        )

  fromLimbs(destination)

func `shl`*(
    value: UInt256,
    amount: int,
): UInt256 {.inline.} =
  shiftLeftUnsigned(
    value,
    amount,
  )

func `shr`*(
    value: UInt256,
    amount: int,
): UInt256 {.inline.} =
  shiftRightUnsigned(
    value,
    amount,
  )

func `shl`*(
    value: Int256,
    amount: int,
): Int256 {.inline.} =
  asInt256(
    shiftLeftUnsigned(
      asUInt256(value),
      amount,
    )
  )

func `shr`*(
    value: Int256,
    amount: int,
): Int256 =
  if amount <= 0:
    return value

  if amount >= 256:
    if isNegative(value):
      return asInt256(
        maxUInt256Value()
      )

    return zeroInt256()

  var shifted =
    shiftRightUnsigned(
      asUInt256(value),
      amount,
    )

  if isNegative(value):
    let fill =
      shiftLeftUnsigned(
        maxUInt256Value(),
        256 - amount,
      )

    shifted =
      shifted or fill

  asInt256(shifted)

func `*`*(
    a,
    b: UInt256,
): UInt256 =
  let product =
    multiplyWide4x4(
      limbs(a),
      limbs(b),
    )

  rawUInt256(
    product[0],
    product[1],
    product[2],
    product[3],
  )

func `*`*(
    a,
    b: Int256,
): Int256 {.inline.} =
  asInt256(
    asUInt256(a) *
    asUInt256(b)
  )

proc divModUnsigned(
    numerator,
    denominator: UInt256,
): tuple[
    quotient: UInt256,
    remainder: UInt256,
] =
  let division =
    divideMod4(
      limbs(numerator),
      limbs(denominator),
    )

  (
    fromLimbs(division.quotient),
    fromLimbs(division.remainder),
  )

proc `div`*(
    numerator,
    denominator: UInt256,
): UInt256 =
  divModUnsigned(
    numerator,
    denominator,
  ).quotient

proc `mod`*(
    numerator,
    denominator: UInt256,
): UInt256 =
  divModUnsigned(
    numerator,
    denominator,
  ).remainder

func magnitude(
    value: Int256,
): UInt256 {.inline.} =
  let bits =
    asUInt256(value)

  if isNegative(value):
    -bits
  else:
    bits

func applySign(
    value: UInt256,
    negative: bool,
): Int256 {.inline.} =
  if negative:
    asInt256(-value)
  else:
    asInt256(value)

proc `div`*(
    numerator,
    denominator: Int256,
): Int256 =
  if isZero(denominator):
    raise newException(
      DivByZeroDefect,
      "division by zero",
    )

  let quotient =
    magnitude(numerator) div
    magnitude(denominator)

  applySign(
    quotient,
    isNegative(numerator) xor
    isNegative(denominator),
  )

proc `mod`*(
    numerator,
    denominator: Int256,
): Int256 =
  if isZero(denominator):
    raise newException(
      DivByZeroDefect,
      "division by zero",
    )

  let remainder =
    magnitude(numerator) mod
    magnitude(denominator)

  applySign(
    remainder,
    isNegative(numerator),
  )

proc floorDiv*(
    numerator,
    denominator: Int256,
): Int256 =
  let quotient =
    numerator div denominator

  let remainder =
    numerator mod denominator

  if not isZero(remainder) and
      (
        isNegative(numerator) xor
        isNegative(denominator)
      ):
    quotient - toInt256(1'i64)
  else:
    quotient

proc floorMod*(
    numerator,
    denominator: Int256,
): Int256 =
  numerator -
  floorDiv(
    numerator,
    denominator,
  ) * denominator

proc parseUInt256*(
    text: string,
): UInt256 =
  if text.len == 0:
    raise newException(
      ValueError,
      "empty UInt256",
    )

  var index =
    0

  if text[0] == '+':
    inc index

  if index == text.len:
    raise newException(
      ValueError,
      "missing UInt256 digits",
    )

  let ten =
    toUInt256(10'u64)

  for position in index ..< text.len:
    let character =
      text[position]

    if character < '0' or
        character > '9':
      raise newException(
        ValueError,
        "invalid UInt256 digit",
      )

    let digit =
      toUInt256(
        uint64(
          ord(character) -
          ord('0')
        )
      )

    let threshold =
      (
        maxUInt256Value() -
        digit
      ) div ten

    if result > threshold:
      raise newException(
        ValueError,
        "UInt256 overflow",
      )

    result =
      result * ten +
      digit

proc parseInt256*(
    text: string,
): Int256 =
  if text.len == 0:
    raise newException(
      ValueError,
      "empty Int256",
    )

  var index =
    0

  var negative =
    false

  if text[0] == '-':
    negative =
      true

    inc index
  elif text[0] == '+':
    inc index

  if index == text.len:
    raise newException(
      ValueError,
      "missing Int256 digits",
    )

  var magnitudeValue =
    zeroUInt256()

  let ten =
    toUInt256(10'u64)

  let limit =
    if negative:
      negativeMagnitudeLimit()
    else:
      positiveMagnitudeLimit()

  for position in index ..< text.len:
    let character =
      text[position]

    if character < '0' or
        character > '9':
      raise newException(
        ValueError,
        "invalid Int256 digit",
      )

    let digit =
      toUInt256(
        uint64(
          ord(character) -
          ord('0')
        )
      )

    let threshold =
      (
        limit -
        digit
      ) div ten

    if magnitudeValue > threshold:
      raise newException(
        ValueError,
        "Int256 overflow",
      )

    magnitudeValue =
      magnitudeValue * ten +
      digit

  applySign(
    magnitudeValue,
    negative,
  )

proc `$`*(
    value: UInt256,
): string =
  if isZero(value):
    return "0"

  let ten =
    toUInt256(10'u64)

  var remaining =
    value

  var reversed =
    ""

  while not isZero(remaining):
    let division =
      divModUnsigned(
        remaining,
        ten,
      )

    let digit =
      int(
        division.remainder.limb0
      )

    reversed.add(
      char(
        ord('0') +
        digit
      )
    )

    remaining =
      division.quotient

  result =
    newString(
      reversed.len
    )

  for index in 0 ..< reversed.len:
    result[index] =
      reversed[
        reversed.high - index
      ]

proc `$`*(
    value: Int256,
): string =
  if isZero(value):
    return "0"

  let digits =
    $magnitude(value)

  if isNegative(value):
    "-" & digits
  else:
    digits

func wrappingAdd*(
    a,
    b: UInt256,
): UInt256 {.inline.} =
  a + b

func wrappingSub*(
    a,
    b: UInt256,
): UInt256 {.inline.} =
  a - b

func wrappingMul*(
    a,
    b: UInt256,
): UInt256 {.inline.} =
  a * b

func wrappingAdd*(
    a,
    b: Int256,
): Int256 {.inline.} =
  a + b

func wrappingSub*(
    a,
    b: Int256,
): Int256 {.inline.} =
  a - b

func wrappingMul*(
    a,
    b: Int256,
): Int256 {.inline.} =
  a * b

proc overflowingAdd*(
    a,
    b: UInt256,
): tuple[
    value: UInt256,
    overflow: bool,
] =
  let calculation =
    add4(
      limbs(a),
      limbs(b),
    )

  (
    fromLimbs(calculation.value),
    calculation.carry,
  )

proc overflowingSub*(
    a,
    b: UInt256,
): tuple[
    value: UInt256,
    overflow: bool,
] =
  let calculation =
    sub4(
      limbs(a),
      limbs(b),
    )

  (
    fromLimbs(calculation.value),
    calculation.borrow,
  )

proc overflowingMul*(
    a,
    b: UInt256,
): tuple[
    value: UInt256,
    overflow: bool,
] =
  let product =
    multiplyWide4x4(
      limbs(a),
      limbs(b),
    )

  let overflow =
    product[4] != 0'u64 or
    product[5] != 0'u64 or
    product[6] != 0'u64 or
    product[7] != 0'u64

  (
    rawUInt256(
      product[0],
      product[1],
      product[2],
      product[3],
    ),
    overflow,
  )

proc overflowingAdd*(
    a,
    b: Int256,
): tuple[
    value: Int256,
    overflow: bool,
] =
  let value =
    a + b

  let aNegative =
    isNegative(a)

  (
    value,
    aNegative == isNegative(b) and
      isNegative(value) != aNegative,
  )

proc overflowingSub*(
    a,
    b: Int256,
): tuple[
    value: Int256,
    overflow: bool,
] =
  let value =
    a - b

  let aNegative =
    isNegative(a)

  (
    value,
    aNegative != isNegative(b) and
      isNegative(value) != aNegative,
  )

proc overflowingMul*(
    a,
    b: Int256,
): tuple[
    value: Int256,
    overflow: bool,
] =
  let value =
    a * b

  if isZero(a) or
      isZero(b):
    return (
      value,
      false,
    )

  let negativeResult =
    isNegative(a) xor
    isNegative(b)

  let limit =
    if negativeResult:
      negativeMagnitudeLimit()
    else:
      positiveMagnitudeLimit()

  let overflow =
    magnitude(a) >
      limit div magnitude(b)

  (
    value,
    overflow,
  )

proc saturatingAdd*(
    a,
    b: UInt256,
): UInt256 =
  let calculation =
    overflowingAdd(
      a,
      b,
    )

  if calculation.overflow:
    maxUInt256Value()
  else:
    calculation.value

proc saturatingSub*(
    a,
    b: UInt256,
): UInt256 =
  let calculation =
    overflowingSub(
      a,
      b,
    )

  if calculation.overflow:
    zeroUInt256()
  else:
    calculation.value

proc saturatingMul*(
    a,
    b: UInt256,
): UInt256 =
  let calculation =
    overflowingMul(
      a,
      b,
    )

  if calculation.overflow:
    maxUInt256Value()
  else:
    calculation.value

proc saturatingAdd*(
    a,
    b: Int256,
): Int256 =
  let calculation =
    overflowingAdd(
      a,
      b,
    )

  if calculation.overflow:
    if isNegative(a):
      minInt256Value()
    else:
      maxInt256Value()
  else:
    calculation.value

proc saturatingSub*(
    a,
    b: Int256,
): Int256 =
  let calculation =
    overflowingSub(
      a,
      b,
    )

  if calculation.overflow:
    if isNegative(a):
      minInt256Value()
    else:
      maxInt256Value()
  else:
    calculation.value

proc saturatingMul*(
    a,
    b: Int256,
): Int256 =
  let calculation =
    overflowingMul(
      a,
      b,
    )

  if calculation.overflow:
    if isNegative(a) xor
        isNegative(b):
      minInt256Value()
    else:
      maxInt256Value()
  else:
    calculation.value

func countLeadingZeroBits64(
    value: uint64,
): int =
  if value == 0'u64:
    return 64

  var mask =
    1'u64 shl 63

  while (
    value and mask
  ) == 0'u64:
    inc result

    mask =
      mask shr 1

func countTrailingZeroBits64(
    value: uint64,
): int =
  if value == 0'u64:
    return 64

  var mask =
    1'u64

  while (
    value and mask
  ) == 0'u64:
    inc result

    mask =
      mask shl 1

func popcount64(
    value: uint64,
): int =
  var remaining =
    value

  while remaining != 0'u64:
    remaining =
      remaining and
      (
        remaining -
        1'u64
      )

    inc result

func countLeadingZeroBits*(
    value: UInt256,
): int =
  if value.limb3 != 0'u64:
    countLeadingZeroBits64(
      value.limb3
    )
  elif value.limb2 != 0'u64:
    64 +
      countLeadingZeroBits64(
        value.limb2
      )
  elif value.limb1 != 0'u64:
    128 +
      countLeadingZeroBits64(
        value.limb1
      )
  else:
    192 +
      countLeadingZeroBits64(
        value.limb0
      )

func countTrailingZeroBits*(
    value: UInt256,
): int =
  if value.limb0 != 0'u64:
    countTrailingZeroBits64(
      value.limb0
    )
  elif value.limb1 != 0'u64:
    64 +
      countTrailingZeroBits64(
        value.limb1
      )
  elif value.limb2 != 0'u64:
    128 +
      countTrailingZeroBits64(
        value.limb2
      )
  else:
    192 +
      countTrailingZeroBits64(
        value.limb3
      )

func popcount*(
    value: UInt256,
): int =
  popcount64(value.limb0) +
  popcount64(value.limb1) +
  popcount64(value.limb2) +
  popcount64(value.limb3)

func countLeadingZeroBits*(
    value: Int256,
): int =
  countLeadingZeroBits(
    asUInt256(value)
  )

func countTrailingZeroBits*(
    value: Int256,
): int =
  countTrailingZeroBits(
    asUInt256(value)
  )

func popcount*(
    value: Int256,
): int =
  popcount(
    asUInt256(value)
  )

func normalizedRotation(
    distance: int,
): int =
  result =
    distance mod 256

  if result < 0:
    result +=
      256

func rotateLeft*(
    value: UInt256,
    distance: int,
): UInt256 =
  let shift =
    normalizedRotation(distance)

  if shift == 0:
    value
  else:
    (
      value shl shift
    ) or
    (
      value shr
      (256 - shift)
    )

func rotateRight*(
    value: UInt256,
    distance: int,
): UInt256 =
  let shift =
    normalizedRotation(distance)

  if shift == 0:
    value
  else:
    (
      value shr shift
    ) or
    (
      value shl
      (256 - shift)
    )

func rotateLeft*(
    value: Int256,
    distance: int,
): Int256 =
  asInt256(
    rotateLeft(
      asUInt256(value),
      distance,
    )
  )

func rotateRight*(
    value: Int256,
    distance: int,
): Int256 =
  asInt256(
    rotateRight(
      asUInt256(value),
      distance,
    )
  )

func hash*(
    value: UInt256,
): Hash =
  var current:
    Hash

  current =
    current !&
    hash(value.limb0)

  current =
    current !&
    hash(value.limb1)

  current =
    current !&
    hash(value.limb2)

  current =
    current !&
    hash(value.limb3)

  !$current

func hash*(
    value: Int256,
): Hash =
  hash(
    asUInt256(value)
  )

proc addMod(
    a,
    b,
    modulus: UInt256,
): UInt256 =
  let distance =
    modulus - b

  if a >= distance:
    a - distance
  else:
    a + b

proc multiplyMod(
    a,
    b,
    modulus: UInt256,
): UInt256 =
  var left =
    a mod modulus

  var right =
    b

  while not isZero(right):
    if (
      word64(right, 0) and
      1'u64
    ) != 0'u64:
      result =
        addMod(
          result,
          left,
          modulus,
        )

    right =
      right shr 1

    if not isZero(right):
      left =
        addMod(
          left,
          left,
          modulus,
        )

proc pow*(
    base: UInt256,
    exponent: int,
): UInt256 =
  if exponent < 0:
    raise newException(
      ValueError,
      "negative exponent",
    )

  result =
    toUInt256(1'u64)

  var factor =
    base

  var remaining =
    exponent

  while remaining > 0:
    if (
      remaining and 1
    ) != 0:
      result =
        result * factor

    remaining =
      remaining shr 1

    if remaining > 0:
      factor =
        factor * factor

proc pow*(
    base: Int256,
    exponent: int,
): Int256 =
  if exponent < 0:
    raise newException(
      ValueError,
      "negative exponent",
    )

  result =
    toInt256(1'i64)

  var factor =
    base

  var remaining =
    exponent

  while remaining > 0:
    if (
      remaining and 1
    ) != 0:
      result =
        result * factor

    remaining =
      remaining shr 1

    if remaining > 0:
      factor =
        factor * factor

proc pow*(
    base: UInt256,
    exponent: int,
    modulus: UInt256,
): UInt256 =
  if exponent < 0:
    raise newException(
      ValueError,
      "negative exponent",
    )

  if isZero(modulus):
    raise newException(
      DivByZeroDefect,
      "zero modulus",
    )

  result =
    toUInt256(1'u64) mod
    modulus

  var factor =
    base mod modulus

  var remaining =
    exponent

  while remaining > 0:
    if (
      remaining and 1
    ) != 0:
      result =
        multiplyMod(
          result,
          factor,
          modulus,
        )

    remaining =
      remaining shr 1

    if remaining > 0:
      factor =
        multiplyMod(
          factor,
          factor,
          modulus,
        )

proc `^`*(
    base: UInt256,
    exponent: int,
): UInt256 =
  pow(
    base,
    exponent,
  )

proc `^`*(
    base: Int256,
    exponent: int,
): Int256 =
  pow(
    base,
    exponent,
  )

func abs*(
    value: Int256,
): Int256 {.inline.} =
  if isNegative(value):
    -value
  else:
    value

func toInt*(
    value: Int256,
): int {.inline.} =
  int(
    cast[int64](
      value.limb0
    )
  )

func toInt*(
    value: UInt256,
): int {.inline.} =
  int(
    cast[int64](
      value.limb0
    )
  )

func toInt32*(
    value: Int256,
): int32 {.inline.} =
  cast[int32](
    uint32(
      value.limb0
    )
  )

func toUInt*(
    value: UInt256,
): uint {.inline.} =
  uint(
    value.limb0
  )

proc inc*(
    value: var UInt256,
) {.inline.} =
  value =
    value +
    toUInt256(1'u64)

proc inc*(
    value: var Int256,
) {.inline.} =
  value =
    value +
    toInt256(1'i64)

proc dec*(
    value: var UInt256,
) {.inline.} =
  value =
    value -
    toUInt256(1'u64)

proc dec*(
    value: var Int256,
) {.inline.} =
  value =
    value -
    toInt256(1'i64)

proc `+=`*(
    value: var UInt256,
    other: UInt256,
) {.inline.} =
  value =
    value + other

proc `+=`*(
    value: var Int256,
    other: Int256,
) {.inline.} =
  value =
    value + other

proc `-=`*(
    value: var UInt256,
    other: UInt256,
) {.inline.} =
  value =
    value - other

proc `-=`*(
    value: var Int256,
    other: Int256,
) {.inline.} =
  value =
    value - other

proc `*=`*(
    value: var UInt256,
    other: UInt256,
) {.inline.} =
  value =
    value * other

proc `*=`*(
    value: var Int256,
    other: Int256,
) {.inline.} =
  value =
    value * other
