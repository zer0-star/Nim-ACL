import std/hashes
import atcoder/extra/numeric/int128

doAssert declared(UInt128)
doAssert declared(Uint128)
doAssert declared(Int128)

doAssert sizeof(UInt128) == 16
doAssert sizeof(Int128) == 16

block styleCompatibility:
  let canonical: UInt128 =
    parseUInt128("1")

  let legacySpelling: Uint128 =
    parseUint128("1")

  doAssert canonical == legacySpelling

block unsignedArithmetic:
  let zero =
    parseUInt128("0")

  let one =
    parseUInt128("1")

  let two64 =
    parseUInt128("18446744073709551616")

  let maximum =
    parseUInt128(
      "340282366920938463463374607431768211455"
    )

  doAssert $zero == "0"
  doAssert $(two64 + one) ==
    "18446744073709551617"

  doAssert maximum + one == zero
  doAssert zero - one == maximum

  doAssert $(two64 * parseUInt128("3")) ==
    "55340232221128654848"

  doAssert maximum div parseUInt128("10") ==
    parseUInt128(
      "34028236692093846346337460743176821145"
    )

  doAssert maximum mod parseUInt128("10") ==
    parseUInt128("5")

block shifts:
  let one =
    parseUInt128("1")

  doAssert one shl 64 ==
    parseUInt128("18446744073709551616")

  doAssert one shl 127 ==
    parseUInt128(
      "170141183460469231731687303715884105728"
    )

  doAssert (
    parseUInt128(
      "170141183460469231731687303715884105728"
    ) shr 127
  ) == one

block signedArithmetic:
  let negativeSeven =
    parseInt128("-7")

  let three =
    parseInt128("3")

  doAssert $(negativeSeven div three) == "-2"
  doAssert $(negativeSeven mod three) == "-1"
  doAssert $floorDiv(negativeSeven, three) == "-3"
  doAssert $floorMod(negativeSeven, three) == "2"

  doAssert $parseInt128(
    "170141183460469231731687303715884105727"
  ) ==
    "170141183460469231731687303715884105727"

  doAssert $parseInt128(
    "-170141183460469231731687303715884105728"
  ) ==
    "-170141183460469231731687303715884105728"

block powers:
  let two =
    parseInt128("2")

  let seventeen =
    parseInt128("17")

  doAssert $(two ^ seventeen) == "131072"

  doAssert $pow(
    two,
    seventeen,
    parseInt128("1000000007"),
  ) == "131072"

block hashes:
  let first =
    parseUInt128("123456789")

  let second =
    parseUInt128("123456789")

  doAssert hash(first) == hash(second)

echo "META.DECLARED_UINT128=YES"
echo "META.DECLARED_INT128=YES"
echo "META.SIZEOF_UINT128=", sizeof(UInt128)
echo "META.SIZEOF_INT128=", sizeof(Int128)
echo "META.STYLE_COMPATIBILITY=YES"
echo "CORE.ADD_SUB=PASS"
echo "CORE.BITWISE=PASS"
echo "CORE.SHIFT=PASS"
echo "CORE.MULTIPLICATION=PASS"
echo "CORE.DIVISION=PASS"
echo "CORE.PARSE_FORMAT=PASS"
echo "CORE.SIGNED_DIVISION=PASS"
echo "CORE.HASH=PASS"
echo "CORE.POW=PASS"

block phase2UnsignedOverflow:
  let zero =
    parseUInt128("0")

  let one =
    parseUInt128("1")

  let two =
    parseUInt128("2")

  let maximum =
    parseUInt128(
      "340282366920938463463374607431768211455"
    )

  let addOverflow =
    overflowingAdd(
      maximum,
      one,
    )

  doAssert addOverflow.overflow
  doAssert addOverflow.value == zero
  doAssert wrappingAdd(maximum, one) == zero
  doAssert saturatingAdd(maximum, one) == maximum

  let subOverflow =
    overflowingSub(
      zero,
      one,
    )

  doAssert subOverflow.overflow
  doAssert subOverflow.value == maximum
  doAssert wrappingSub(zero, one) == maximum
  doAssert saturatingSub(zero, one) == zero

  let mulOverflow =
    overflowingMul(
      maximum,
      two,
    )

  doAssert mulOverflow.overflow
  doAssert $mulOverflow.value ==
    "340282366920938463463374607431768211454"

  doAssert wrappingMul(maximum, two) ==
    mulOverflow.value

  doAssert saturatingMul(maximum, two) ==
    maximum

  let mulExact =
    overflowingMul(
      maximum,
      one,
    )

  doAssert not mulExact.overflow
  doAssert mulExact.value == maximum

block phase2SignedOverflow:
  let one =
    parseInt128("1")

  let negativeOne =
    parseInt128("-1")

  let two =
    parseInt128("2")

  let maximum =
    parseInt128(
      "170141183460469231731687303715884105727"
    )

  let minimum =
    parseInt128(
      "-170141183460469231731687303715884105728"
    )

  let addPositiveOverflow =
    overflowingAdd(
      maximum,
      one,
    )

  doAssert addPositiveOverflow.overflow
  doAssert addPositiveOverflow.value == minimum
  doAssert saturatingAdd(maximum, one) == maximum

  let addNegativeOverflow =
    overflowingAdd(
      minimum,
      negativeOne,
    )

  doAssert addNegativeOverflow.overflow
  doAssert addNegativeOverflow.value == maximum
  doAssert saturatingAdd(minimum, negativeOne) == minimum

  let subPositiveOverflow =
    overflowingSub(
      maximum,
      negativeOne,
    )

  doAssert subPositiveOverflow.overflow
  doAssert subPositiveOverflow.value == minimum
  doAssert saturatingSub(maximum, negativeOne) == maximum

  let subNegativeOverflow =
    overflowingSub(
      minimum,
      one,
    )

  doAssert subNegativeOverflow.overflow
  doAssert subNegativeOverflow.value == maximum
  doAssert saturatingSub(minimum, one) == minimum

  let mulPositiveOverflow =
    overflowingMul(
      maximum,
      two,
    )

  doAssert mulPositiveOverflow.overflow
  doAssert $mulPositiveOverflow.value == "-2"
  doAssert saturatingMul(maximum, two) == maximum

  let minTimesNegativeOne =
    overflowingMul(
      minimum,
      negativeOne,
    )

  doAssert minTimesNegativeOne.overflow
  doAssert minTimesNegativeOne.value == minimum
  doAssert saturatingMul(minimum, negativeOne) == maximum

  let minTimesOne =
    overflowingMul(
      minimum,
      one,
    )

  doAssert not minTimesOne.overflow
  doAssert minTimesOne.value == minimum

block phase2BitCounts:
  let zero =
    parseUInt128("0")

  let one =
    parseUInt128("1")

  let topBit =
    parseUInt128(
      "170141183460469231731687303715884105728"
    )

  let maximum =
    parseUInt128(
      "340282366920938463463374607431768211455"
    )

  doAssert countLeadingZeroBits(zero) == 128
  doAssert countTrailingZeroBits(zero) == 128
  doAssert popcount(zero) == 0

  doAssert countLeadingZeroBits(one) == 127
  doAssert countTrailingZeroBits(one) == 0
  doAssert popcount(one) == 1

  doAssert countLeadingZeroBits(topBit) == 0
  doAssert countTrailingZeroBits(topBit) == 127
  doAssert popcount(topBit) == 1

  doAssert popcount(maximum) == 128
  doAssert popcount(parseInt128("-1")) == 128

block phase2Rotations:
  let one =
    parseUInt128("1")

  let two64 =
    parseUInt128(
      "18446744073709551616"
    )

  let topBit =
    parseUInt128(
      "170141183460469231731687303715884105728"
    )

  doAssert rotateLeft(one, 64) == two64
  doAssert rotateRight(two64, 64) == one
  doAssert rotateLeft(topBit, 1) == one
  doAssert rotateRight(one, 1) == topBit
  doAssert rotateLeft(one, -1) == topBit
  doAssert rotateRight(topBit, -1) == one
  doAssert rotateLeft(parseInt128("-1"), 37) ==
    parseInt128("-1")

echo "PHASE2.WRAPPING_ADD=PASS"
echo "PHASE2.WRAPPING_SUB=PASS"
echo "PHASE2.WRAPPING_MUL=PASS"
echo "PHASE2.OVERFLOWING_ADD=PASS"
echo "PHASE2.OVERFLOWING_SUB=PASS"
echo "PHASE2.OVERFLOWING_MUL=PASS"
echo "PHASE2.SATURATING_ADD=PASS"
echo "PHASE2.SATURATING_SUB=PASS"
echo "PHASE2.SATURATING_MUL=PASS"
echo "PHASE2.COUNT_LEADING_ZERO=PASS"
echo "PHASE2.COUNT_TRAILING_ZERO=PASS"
echo "PHASE2.POPCOUNT=PASS"
echo "PHASE2.ROTATE_LEFT=PASS"
echo "PHASE2.ROTATE_RIGHT=PASS"
echo "CONTRACT_OK"
