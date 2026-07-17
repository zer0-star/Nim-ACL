## Portable IEEE 754 binary128 bit representation.
##
## Phase F0 intentionally provides only:
## - raw bit construction and decomposition
## - sign, exponent and fraction extraction
## - value classification
## - signed zero, infinity and NaN construction
##
## Arithmetic and numeric conversions are intentionally deferred.

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
