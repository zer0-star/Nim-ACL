## Portable IEEE 754 binary128 bit representation.
##
## Phase F0 intentionally provides only:
## - raw bit construction and decomposition
## - sign, exponent and fraction extraction
## - value classification
## - signed zero, infinity and NaN construction
##
## Arithmetic and numeric conversions are intentionally deferred.

import atcoder/extra/numeric/int128
import atcoder/extra/numeric/int256

const
  Float128ExponentBits* = 15
  Float128FractionBits* = 112
  Float128PrecisionBits* = 113
  Float128ExponentBias* = 16383

  float128SignMask = 0x8000_0000_0000_0000'u64
  float128ExponentMask = 0x7FFF_0000_0000_0000'u64
  float128FractionHighMask = 0x0000_FFFF_FFFF_FFFF'u64
  float128QuietNaNMask = 0x0000_8000_0000_0000'u64
  float128SignalingPayloadHighMask = 0x0000_7FFF_FFFF_FFFF'u64
  float128MaxBiasedExponent = 0x7FFF'u16

type
  Float128* = object
    ## Raw binary128 storage. Fields remain private.
    high: uint64
    low: uint64

  Float128Class* = enum
    f128Zero
    f128Subnormal
    f128Normal
    f128Infinity
    f128QuietNaN
    f128SignalingNaN

const
  positiveZeroFloat128* =
    Float128(high: 0x0000_0000_0000_0000'u64, low: 0'u64)

  negativeZeroFloat128* =
    Float128(high: 0x8000_0000_0000_0000'u64, low: 0'u64)

  positiveInfinityFloat128* =
    Float128(high: 0x7FFF_0000_0000_0000'u64, low: 0'u64)

  negativeInfinityFloat128* =
    Float128(high: 0xFFFF_0000_0000_0000'u64, low: 0'u64)

  canonicalQuietNaNFloat128* =
    Float128(high: 0x7FFF_8000_0000_0000'u64, low: 0'u64)

  canonicalSignalingNaNFloat128* =
    Float128(high: 0x7FFF_0000_0000_0000'u64, low: 1'u64)

func fromBits*(high, low: uint64): Float128 {.inline.} =
  ## Constructs a Float128 from its exact binary representation.
  Float128(high: high, low: low)

func toBits*(value: Float128): tuple[high, low: uint64] {.inline.} =
  ## Returns the exact binary representation.
  (high: value.high, low: value.low)

func sameBits*(a, b: Float128): bool {.inline.} =
  ## Tests bitwise identity rather than IEEE numeric equality.
  a.high == b.high and a.low == b.low

func signBit*(value: Float128): bool {.inline.} =
  (value.high and float128SignMask) != 0'u64

func biasedExponent*(value: Float128): uint16 {.inline.} =
  uint16((value.high and float128ExponentMask) shr 48)

func fractionHighBits*(value: Float128): uint64 {.inline.} =
  value.high and float128FractionHighMask

func fractionLowBits*(value: Float128): uint64 {.inline.} =
  value.low

func fractionIsZero(value: Float128): bool {.inline.} =
  fractionHighBits(value) == 0'u64 and value.low == 0'u64

func isZero*(value: Float128): bool {.inline.} =
  biasedExponent(value) == 0'u16 and fractionIsZero(value)

func isSubnormal*(value: Float128): bool {.inline.} =
  biasedExponent(value) == 0'u16 and not fractionIsZero(value)

func isNormal*(value: Float128): bool {.inline.} =
  let exponent = biasedExponent(value)
  exponent != 0'u16 and exponent != float128MaxBiasedExponent

func isInfinite*(value: Float128): bool {.inline.} =
  biasedExponent(value) == float128MaxBiasedExponent and
    fractionIsZero(value)

func isNaN*(value: Float128): bool {.inline.} =
  biasedExponent(value) == float128MaxBiasedExponent and
    not fractionIsZero(value)

func isQuietNaN*(value: Float128): bool {.inline.} =
  isNaN(value) and
    (fractionHighBits(value) and float128QuietNaNMask) != 0'u64

func isSignalingNaN*(value: Float128): bool {.inline.} =
  isNaN(value) and
    (fractionHighBits(value) and float128QuietNaNMask) == 0'u64

func isFinite*(value: Float128): bool {.inline.} =
  biasedExponent(value) != float128MaxBiasedExponent

func classify*(value: Float128): Float128Class =
  let exponent = biasedExponent(value)

  if exponent == 0'u16:
    if fractionIsZero(value):
      result = f128Zero
    else:
      result = f128Subnormal
  elif exponent != float128MaxBiasedExponent:
    result = f128Normal
  elif fractionIsZero(value):
    result = f128Infinity
  elif isQuietNaN(value):
    result = f128QuietNaN
  else:
    result = f128SignalingNaN

func withSign*(value: Float128, negative: bool): Float128 {.inline.} =
  var high = value.high and not float128SignMask

  if negative:
    high = high or float128SignMask

  Float128(high: high, low: value.low)

func negateSign*(value: Float128): Float128 {.inline.} =
  Float128(
    high: value.high xor float128SignMask,
    low: value.low
  )

func zeroFloat128*(negative: bool = false): Float128 {.inline.} =
  if negative:
    negativeZeroFloat128
  else:
    positiveZeroFloat128

func infinityFloat128*(negative: bool = false): Float128 {.inline.} =
  if negative:
    negativeInfinityFloat128
  else:
    positiveInfinityFloat128

# ----------------------------------------------------------------------
# Exact integer conversion using IEEE 754 roundTiesToEven
# ----------------------------------------------------------------------

type
  Float128IntegerLimbs = array[4, uint64]

func integerLimbs(value: UInt128): Float128IntegerLimbs {.inline.} =
  result = [
    low64(value),
    high64(value),
    0'u64,
    0'u64
  ]

func integerLimbs(value: UInt256): Float128IntegerLimbs {.inline.} =
  let lowHalf = low128(value)
  let highHalf = high128(value)

  result = [
    low64(lowHalf),
    high64(lowHalf),
    low64(highHalf),
    high64(highHalf)
  ]

func integerBit(
    limbs: Float128IntegerLimbs,
    index: int
  ): bool {.inline.} =
  let limbIndex = index shr 6
  let bitIndex = index and 63

  ((limbs[limbIndex] shr bitIndex) and 1'u64) != 0'u64

func integerBitLength(
    limbs: Float128IntegerLimbs
  ): int =
  for index in countdown(255, 0):
    if integerBit(limbs, index):
      return index + 1

  0

func anyIntegerBitsBelow(
    limbs: Float128IntegerLimbs,
    highExclusive: int
  ): bool =
  if highExclusive <= 0:
    return false

  for index in 0 ..< highExclusive:
    if integerBit(limbs, index):
      return true

  false

func setSignificandBit(
    significandHigh: var uint64,
    significandLow: var uint64,
    index: int
  ) {.inline.} =
  if index < 64:
    significandLow =
      significandLow or (1'u64 shl index)
  else:
    significandHigh =
      significandHigh or (1'u64 shl (index - 64))

func toFloat128FromIntegerLimbs(
    limbs: Float128IntegerLimbs,
    negative: bool
  ): Float128 =
  let bitLength = integerBitLength(limbs)

  if bitLength == 0:
    return positiveZeroFloat128

  var exponent = bitLength - 1
  var significandHigh = 0'u64
  var significandLow = 0'u64

  if bitLength <= Float128PrecisionBits:
    let leftShift = Float128PrecisionBits - bitLength

    for sourceBit in 0 ..< bitLength:
      if integerBit(limbs, sourceBit):
        setSignificandBit(
          significandHigh,
          significandLow,
          sourceBit + leftShift
        )
  else:
    let rightShift = bitLength - Float128PrecisionBits

    for destinationBit in 0 ..< Float128PrecisionBits:
      if integerBit(
          limbs,
          destinationBit + rightShift
        ):
        setSignificandBit(
          significandHigh,
          significandLow,
          destinationBit
        )

    let guardBit =
      integerBit(limbs, rightShift - 1)

    let stickyBit =
      anyIntegerBitsBelow(
        limbs,
        rightShift - 1
      )

    let retainedLeastBitIsOdd =
      (significandLow and 1'u64) != 0'u64

    if guardBit and
        (stickyBit or retainedLeastBitIsOdd):
      significandLow = significandLow + 1'u64

      if significandLow == 0'u64:
        significandHigh = significandHigh + 1'u64

      if significandHigh ==
          0x0002_0000_0000_0000'u64:
        significandHigh =
          0x0001_0000_0000_0000'u64

        significandLow = 0'u64
        exponent += 1

  let fractionHigh =
    significandHigh and
    0x0000_FFFF_FFFF_FFFF'u64

  var high =
    (uint64(exponent + Float128ExponentBias) shl 48) or
    fractionHigh

  if negative:
    high = high or 0x8000_0000_0000_0000'u64

  fromBits(high, significandLow)

func toFloat128*(value: UInt128): Float128 =
  ## Converts UInt128 exactly when possible and otherwise uses
  ## IEEE 754 roundTiesToEven.
  toFloat128FromIntegerLimbs(
    integerLimbs(value),
    false
  )

func toFloat128*(value: Int128): Float128 =
  ## Converts Int128 using its two's-complement magnitude.
  let bits = cast[UInt128](value)

  let negative =
    (high64(bits) and 0x8000_0000_0000_0000'u64) !=
    0'u64

  let magnitude =
    if negative:
      toUInt128(0'u64) - bits
    else:
      bits

  toFloat128FromIntegerLimbs(
    integerLimbs(magnitude),
    negative
  )

func toFloat128*(value: UInt256): Float128 =
  ## Converts UInt256 using IEEE 754 roundTiesToEven.
  toFloat128FromIntegerLimbs(
    integerLimbs(value),
    false
  )

func toFloat128*(value: Int256): Float128 =
  ## Converts Int256 using its two's-complement magnitude.
  let bits = cast[UInt256](value)
  let highHalf = high128(bits)

  let negative =
    (high64(highHalf) and 0x8000_0000_0000_0000'u64) !=
    0'u64

  let magnitude =
    if negative:
      toUInt256(0'u64) - bits
    else:
      bits

  toFloat128FromIntegerLimbs(
    integerLimbs(magnitude),
    negative
  )

# ----------------------------------------------------------------------
# Exact float32 / float64 conversion
# ----------------------------------------------------------------------

func float32SourceHighestBit(value: uint32): int {.inline.} =
  for index in countdown(31, 0):
    if ((value shr index) and 1'u32) != 0'u32:
      return index

  -1

func float64SourceHighestBit(value: uint64): int {.inline.} =
  for index in countdown(63, 0):
    if ((value shr index) and 1'u64) != 0'u64:
      return index

  -1

func toFloat128*(value: float32): Float128 =
  ## Converts an IEEE 754 binary32 value exactly to binary128.
  ##
  ## NaN sign, quiet/signaling state and payload bits are preserved by
  ## left-aligning the binary32 fraction in the binary128 fraction.
  let
    sourceBits = cast[uint32](value)
    sourceSign = uint64(sourceBits shr 31) shl 63
    sourceExponent = (sourceBits shr 23) and 0xFF'u32
    sourceFraction = sourceBits and 0x007F_FFFF'u32

  if sourceExponent == 0'u32:
    if sourceFraction == 0'u32:
      return fromBits(sourceSign, 0'u64)

    let
      highestBit = float32SourceHighestBit(sourceFraction)
      targetExponent = uint64(highestBit + 16234)
      remainder =
        sourceFraction xor (1'u32 shl highestBit)
      targetFractionHigh =
        uint64(remainder) shl (48 - highestBit)

    return fromBits(
      sourceSign or
        (targetExponent shl 48) or
        targetFractionHigh,
      0'u64
    )

  let targetExponent =
    if sourceExponent == 0xFF'u32:
      0x7FFF'u64
    else:
      uint64(sourceExponent) + 16256'u64

  fromBits(
    sourceSign or
      (targetExponent shl 48) or
      (uint64(sourceFraction) shl 25),
    0'u64
  )

func toFloat128*(value: float64): Float128 =
  ## Converts an IEEE 754 binary64 value exactly to binary128.
  ##
  ## NaN sign, quiet/signaling state and payload bits are preserved by
  ## left-aligning the binary64 fraction in the binary128 fraction.
  let
    sourceBits = cast[uint64](value)
    sourceSign = sourceBits and 0x8000_0000_0000_0000'u64
    sourceExponent =
      (sourceBits shr 52) and 0x7FF'u64
    sourceFraction =
      sourceBits and 0x000F_FFFF_FFFF_FFFF'u64

  if sourceExponent == 0'u64:
    if sourceFraction == 0'u64:
      return fromBits(sourceSign, 0'u64)

    let
      highestBit = float64SourceHighestBit(sourceFraction)
      targetExponent = uint64(highestBit + 15309)
      remainder =
        sourceFraction xor (1'u64 shl highestBit)

    var
      targetFractionHigh: uint64
      targetFractionLow: uint64

    if highestBit <= 48:
      targetFractionHigh =
        remainder shl (48 - highestBit)
      targetFractionLow = 0'u64
    else:
      targetFractionHigh =
        remainder shr (highestBit - 48)
      targetFractionLow =
        remainder shl (112 - highestBit)

    return fromBits(
      sourceSign or
        (targetExponent shl 48) or
        targetFractionHigh,
      targetFractionLow
    )

  let targetExponent =
    if sourceExponent == 0x7FF'u64:
      0x7FFF'u64
    else:
      sourceExponent + 15360'u64

  fromBits(
    sourceSign or
      (targetExponent shl 48) or
      (sourceFraction shr 4),
    sourceFraction shl 60
  )

# ----------------------------------------------------------------------
# Checked Float128 to fixed-width integer conversion
# ----------------------------------------------------------------------

proc float128IntegerMagnitude128(
    value: Float128;
    destination: var UInt128;
    negative: var bool;
    unbiasedExponent: var int;
    sourceFractionNonzero: var bool;
): bool =
  destination = toUInt128(0'u64)

  let
    raw = toBits(value)
    exponentField =
      int((raw.high shr 48) and 0x7FFF'u64)
    fractionHigh =
      raw.high and 0x0000_FFFF_FFFF_FFFF'u64

  negative =
    (raw.high and 0x8000_0000_0000_0000'u64) != 0'u64

  sourceFractionNonzero =
    fractionHigh != 0'u64 or raw.low != 0'u64

  unbiasedExponent = -16383

  if exponentField == 0x7FFF:
    return false

  if exponentField == 0:
    return true

  unbiasedExponent = exponentField - 16383

  if unbiasedExponent < 0:
    return true

  if unbiasedExponent > 127:
    return false

  let significand =
    (
      toUInt128(
        fractionHigh or 0x0001_0000_0000_0000'u64
      ) shl 64
    ) or toUInt128(raw.low)

  if unbiasedExponent >= 112:
    destination =
      significand shl (unbiasedExponent - 112)
  else:
    destination =
      significand shr (112 - unbiasedExponent)

  true

proc float128IntegerMagnitude256(
    value: Float128;
    destination: var UInt256;
    negative: var bool;
    unbiasedExponent: var int;
    sourceFractionNonzero: var bool;
): bool =
  destination = toUInt256(0'u64)

  let
    raw = toBits(value)
    exponentField =
      int((raw.high shr 48) and 0x7FFF'u64)
    fractionHigh =
      raw.high and 0x0000_FFFF_FFFF_FFFF'u64

  negative =
    (raw.high and 0x8000_0000_0000_0000'u64) != 0'u64

  sourceFractionNonzero =
    fractionHigh != 0'u64 or raw.low != 0'u64

  unbiasedExponent = -16383

  if exponentField == 0x7FFF:
    return false

  if exponentField == 0:
    return true

  unbiasedExponent = exponentField - 16383

  if unbiasedExponent < 0:
    return true

  if unbiasedExponent > 255:
    return false

  let significand128 =
    (
      toUInt128(
        fractionHigh or 0x0001_0000_0000_0000'u64
      ) shl 64
    ) or toUInt128(raw.low)

  let significand =
    toUInt256(significand128)

  if unbiasedExponent >= 112:
    destination =
      significand shl (unbiasedExponent - 112)
  else:
    destination =
      significand shr (112 - unbiasedExponent)

  true

proc tryToUInt128*(
    value: Float128;
    destination: var UInt128;
): bool =
  destination = toUInt128(0'u64)

  var
    magnitude: UInt128
    negative: bool
    unbiasedExponent: int
    sourceFractionNonzero: bool

  if not float128IntegerMagnitude128(
    value,
    magnitude,
    negative,
    unbiasedExponent,
    sourceFractionNonzero,
  ):
    return false

  if negative and unbiasedExponent >= 0:
    return false

  destination = magnitude
  true

proc tryToInt128*(
    value: Float128;
    destination: var Int128;
): bool =
  destination =
    cast[Int128](toUInt128(0'u64))

  var
    magnitude: UInt128
    negative: bool
    unbiasedExponent: int
    sourceFractionNonzero: bool

  if not float128IntegerMagnitude128(
    value,
    magnitude,
    negative,
    unbiasedExponent,
    sourceFractionNonzero,
  ):
    return false

  if unbiasedExponent == 127:
    if not negative or sourceFractionNonzero:
      return false

  if negative:
    destination =
      cast[Int128](
        toUInt128(0'u64) - magnitude
      )
  else:
    destination = cast[Int128](magnitude)

  true

proc tryToUInt256*(
    value: Float128;
    destination: var UInt256;
): bool =
  destination = toUInt256(0'u64)

  var
    magnitude: UInt256
    negative: bool
    unbiasedExponent: int
    sourceFractionNonzero: bool

  if not float128IntegerMagnitude256(
    value,
    magnitude,
    negative,
    unbiasedExponent,
    sourceFractionNonzero,
  ):
    return false

  if negative and unbiasedExponent >= 0:
    return false

  destination = magnitude
  true

proc tryToInt256*(
    value: Float128;
    destination: var Int256;
): bool =
  destination =
    cast[Int256](toUInt256(0'u64))

  var
    magnitude: UInt256
    negative: bool
    unbiasedExponent: int
    sourceFractionNonzero: bool

  if not float128IntegerMagnitude256(
    value,
    magnitude,
    negative,
    unbiasedExponent,
    sourceFractionNonzero,
  ):
    return false

  if unbiasedExponent == 255:
    if not negative or sourceFractionNonzero:
      return false

  if negative:
    destination =
      cast[Int256](
        toUInt256(0'u64) - magnitude
      )
  else:
    destination = cast[Int256](magnitude)

  true

# ----------------------------------------------------------------------
# Exact binary128 downconversion
# ----------------------------------------------------------------------

func float128HighestBit64(value: uint64): int {.inline.} =
  for index in countdown(63, 0):
    if ((value shr index) and 1'u64) != 0'u64:
      return index

  -1

func float128HighestBit112(
    high, low: uint64;
): int {.inline.} =
  if high != 0'u64:
    return 64 + float128HighestBit64(high)

  float128HighestBit64(low)

func float128ShiftRightToUInt64(
    high, low: uint64;
    shift: int;
): uint64 {.inline.} =
  if shift <= 0:
    if shift == 0:
      return low

    let leftShift = -shift

    if high == 0'u64 and leftShift < 64:
      return low shl leftShift

    return 0'u64

  if shift < 64:
    return
      (low shr shift) or
      (high shl (64 - shift))

  if shift == 64:
    return high

  if shift < 128:
    return high shr (shift - 64)

  0'u64

func float128RoundShiftToUInt64(
    high, low: uint64;
    shift: int;
): uint64 {.inline.} =
  if shift <= 0:
    return float128ShiftRightToUInt64(
      high,
      low,
      shift,
    )

  if shift > 128:
    return 0'u64

  let
    retained =
      float128ShiftRightToUInt64(
        high,
        low,
        shift,
      )
    guardPosition = shift - 1

  var
    guard = 0'u64
    sticky = false

  if guardPosition < 64:
    guard =
      (low shr guardPosition) and 1'u64

    if guardPosition > 0:
      let mask =
        (1'u64 shl guardPosition) - 1'u64

      sticky = (low and mask) != 0'u64
  else:
    let highPosition = guardPosition - 64

    guard =
      (high shr highPosition) and 1'u64

    sticky = low != 0'u64

    if highPosition > 0:
      let mask =
        (1'u64 shl highPosition) - 1'u64

      sticky =
        sticky or
        ((high and mask) != 0'u64)

  if guard != 0'u64 and
      (sticky or ((retained and 1'u64) != 0'u64)):
    return retained + 1'u64

  retained

func float128ToBinaryBits(
    value: Float128;
    targetFractionBits: int;
    targetBias: int;
    targetMinimumExponent: int;
    targetMaximumExponent: int;
    targetSignShift: int;
    targetExponentAllOnes: uint64;
): uint64 =
  let
    source = toBits(value)
    sourceHigh = source.high
    sourceLow = source.low
    sourceSign = sourceHigh shr 63
    sourceExponent =
      int((sourceHigh shr 48) and 0x7FFF'u64)
    sourceFractionHigh =
      sourceHigh and 0x0000_FFFF_FFFF_FFFF'u64
    targetSign =
      sourceSign shl targetSignShift

  if sourceExponent == 0x7FFF:
    if sourceFractionHigh == 0'u64 and
        sourceLow == 0'u64:
      return
        targetSign or
        (targetExponentAllOnes shl targetFractionBits)

    let payloadShift =
      112 - targetFractionBits

    var targetFraction =
      float128ShiftRightToUInt64(
        sourceFractionHigh,
        sourceLow,
        payloadShift,
      )

    if targetFraction == 0'u64:
      targetFraction = 1'u64

    return
      targetSign or
      (targetExponentAllOnes shl targetFractionBits) or
      targetFraction

  if sourceExponent == 0 and
      sourceFractionHigh == 0'u64 and
      sourceLow == 0'u64:
    return targetSign

  var
    significandHigh: uint64
    significandLow = sourceLow
    highestBit: int
    binaryExponent: int

  if sourceExponent == 0:
    significandHigh = sourceFractionHigh
    highestBit =
      float128HighestBit112(
        significandHigh,
        significandLow,
      )
    binaryExponent = -16494
  else:
    significandHigh =
      sourceFractionHigh or
      (1'u64 shl 48)
    highestBit = 112
    binaryExponent =
      sourceExponent - 16383 - 112

  let resultExponent =
    highestBit + binaryExponent

  if resultExponent > targetMaximumExponent:
    return
      targetSign or
      (targetExponentAllOnes shl targetFractionBits)

  let targetHiddenBit =
    1'u64 shl targetFractionBits

  if resultExponent >= targetMinimumExponent:
    let shift =
      highestBit - targetFractionBits

    var
      roundedSignificand =
        float128RoundShiftToUInt64(
          significandHigh,
          significandLow,
          shift,
        )
      normalizedExponent = resultExponent

    if roundedSignificand ==
        (targetHiddenBit shl 1):
      roundedSignificand =
        roundedSignificand shr 1
      inc normalizedExponent

    if normalizedExponent > targetMaximumExponent:
      return
        targetSign or
        (targetExponentAllOnes shl targetFractionBits)

    let
      targetExponent =
        uint64(normalizedExponent + targetBias)
      targetFraction =
        roundedSignificand - targetHiddenBit

    return
      targetSign or
      (targetExponent shl targetFractionBits) or
      targetFraction

  let
    targetQuantumExponent =
      targetMinimumExponent - targetFractionBits
    shift =
      targetQuantumExponent - binaryExponent
    roundedFraction =
      float128RoundShiftToUInt64(
        significandHigh,
        significandLow,
        shift,
      )

  if roundedFraction == 0'u64:
    return targetSign

  if roundedFraction >= targetHiddenBit:
    return
      targetSign or
      (1'u64 shl targetFractionBits)

  targetSign or roundedFraction

func toFloat32*(value: Float128): float32 =
  ## Converts binary128 to binary32 using roundTiesToEven.
  ##
  ## Signed zero and infinity are preserved. NaN sign and the most
  ## significant representable payload bits are retained. A signaling
  ## NaN remains signaling when its retained payload is nonzero.
  let bits =
    uint32(
      float128ToBinaryBits(
        value,
        23,
        127,
        -126,
        127,
        31,
        0xFF'u64,
      )
    )

  cast[float32](bits)

func toFloat64*(value: Float128): float64 =
  ## Converts binary128 to binary64 using roundTiesToEven.
  ##
  ## Signed zero and infinity are preserved. NaN sign and the most
  ## significant representable payload bits are retained. A signaling
  ## NaN remains signaling when its retained payload is nonzero.
  let bits =
    float128ToBinaryBits(
      value,
      52,
      1023,
      -1022,
      1023,
      63,
      0x7FF'u64,
    )

  cast[float64](bits)
