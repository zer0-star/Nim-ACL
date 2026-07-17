import std/strutils
import atcoder/extra/numeric/float128

proc emitVector(name: string, value: Float128) =
  let raw = toBits(value)

  echo(
    name,
    "\t", toHex(raw.high, 16),
    "\t", toHex(raw.low, 16),
    "\t", $classify(value),
    "\t", biasedExponent(value),
    "\t", toHex(fractionHighBits(value), 12),
    "\t", toHex(fractionLowBits(value), 16)
  )

doAssert sizeof(Float128) == 16

doAssert Float128ExponentBits == 15
doAssert Float128FractionBits == 112
doAssert Float128PrecisionBits == 113
doAssert Float128ExponentBias == 16383

doAssert sameBits(
  positiveZeroFloat128,
  fromBits(0x0000_0000_0000_0000'u64, 0'u64)
)

doAssert sameBits(
  negativeZeroFloat128,
  fromBits(0x8000_0000_0000_0000'u64, 0'u64)
)

doAssert isZero(positiveZeroFloat128)
doAssert isZero(negativeZeroFloat128)
doAssert not signBit(positiveZeroFloat128)
doAssert signBit(negativeZeroFloat128)
doAssert classify(positiveZeroFloat128) == f128Zero

let minSubnormal =
  fromBits(0x0000_0000_0000_0000'u64, 1'u64)

let maxSubnormal =
  fromBits(
    0x0000_FFFF_FFFF_FFFF'u64,
    0xFFFF_FFFF_FFFF_FFFF'u64
  )

let minNormal =
  fromBits(0x0001_0000_0000_0000'u64, 0'u64)

let one =
  fromBits(0x3FFF_0000_0000_0000'u64, 0'u64)

let maxFinite =
  fromBits(
    0x7FFE_FFFF_FFFF_FFFF'u64,
    0xFFFF_FFFF_FFFF_FFFF'u64
  )

doAssert isSubnormal(minSubnormal)
doAssert isSubnormal(maxSubnormal)
doAssert not isNormal(maxSubnormal)

doAssert isNormal(minNormal)
doAssert isNormal(one)
doAssert isNormal(maxFinite)

doAssert isFinite(minSubnormal)
doAssert isFinite(maxFinite)

doAssert isInfinite(positiveInfinityFloat128)
doAssert isInfinite(negativeInfinityFloat128)
doAssert not isFinite(positiveInfinityFloat128)

doAssert isQuietNaN(canonicalQuietNaNFloat128)
doAssert isSignalingNaN(canonicalSignalingNaNFloat128)
doAssert isNaN(canonicalQuietNaNFloat128)
doAssert isNaN(canonicalSignalingNaNFloat128)

let quietPayload =
  fromBits(
    0xFFFF_8000_0000_1234'u64,
    0x0000_0000_0000_5678'u64
  )

doAssert isQuietNaN(quietPayload)
doAssert signBit(quietPayload)
doAssert fractionHighBits(quietPayload) ==
  0x0000_8000_0000_1234'u64
doAssert fractionLowBits(quietPayload) == 0x5678'u64

let signalingPayload =
  fromBits(
    0x7FFF_0000_0000_0000'u64,
    0x0000_0000_0000_0001'u64
  )

doAssert isSignalingNaN(signalingPayload)
doAssert toBits(signalingPayload).low == 1'u64

doAssert sameBits(
  zeroFloat128(false),
  positiveZeroFloat128
)

doAssert sameBits(
  zeroFloat128(true),
  negativeZeroFloat128
)

doAssert sameBits(
  infinityFloat128(false),
  positiveInfinityFloat128
)

doAssert sameBits(
  infinityFloat128(true),
  negativeInfinityFloat128
)

doAssert sameBits(
  withSign(positiveInfinityFloat128, true),
  negativeInfinityFloat128
)

doAssert sameBits(
  negateSign(negativeZeroFloat128),
  positiveZeroFloat128
)

emitVector(
  "positiveZero",
  positiveZeroFloat128
)

emitVector(
  "negativeZero",
  negativeZeroFloat128
)

emitVector(
  "minSubnormal",
  minSubnormal
)

emitVector(
  "maxSubnormal",
  maxSubnormal
)

emitVector(
  "minNormal",
  minNormal
)

emitVector(
  "one",
  one
)

emitVector(
  "maxFinite",
  maxFinite
)

emitVector(
  "positiveInfinity",
  positiveInfinityFloat128
)

emitVector(
  "negativeInfinity",
  negativeInfinityFloat128
)

emitVector(
  "quietNaN",
  canonicalQuietNaNFloat128
)

emitVector(
  "signalingNaN",
  canonicalSignalingNaNFloat128
)

emitVector(
  "negativeQuietNaN",
  fromBits(0xFFFF_8000_0000_0000'u64, 0'u64)
)

echo "F0.CONSTANTS=PASS"
echo "F0.RAW_BITS=PASS"
echo "F0.CLASSIFICATION=PASS"
echo "F0.SPECIAL_CONSTRUCTORS=PASS"
echo "F0.SIGN_OPERATIONS=PASS"
echo "F0.API_FREEZE=PASS"
echo "FLOAT128_F0_OK"
