import atcoder/extra/numeric/int128
import atcoder/extra/numeric/int256
import atcoder/extra/numeric/internal/limbs
import atcoder/extra/numeric/internal/wide_mul

static:
  doAssert sizeof(UInt256) == 32
  doAssert sizeof(Int256) == 32
  doAssert sizeof(UInt512Limbs) == 64

  doAssert declared(Uint256)
  doAssert declared(Int256)

block constructors:
  let value =
    fromUInt64Words(
      4'u64,
      3'u64,
      2'u64,
      1'u64,
    )

  doAssert word64(value, 0) == 1'u64
  doAssert word64(value, 1) == 2'u64
  doAssert word64(value, 2) == 3'u64
  doAssert word64(value, 3) == 4'u64

  let fromHalves =
    fromUInt128Halves(
      high128(value),
      low128(value),
    )

  doAssert fromHalves == value

  doAssert low64(low128(value)) == 1'u64
  doAssert high64(low128(value)) == 2'u64
  doAssert low64(high128(value)) == 3'u64
  doAssert high64(high128(value)) == 4'u64

block comparison:
  doAssert parseUInt256("0") < parseUInt256("1")

  doAssert parseUInt256(
    "340282366920938463463374607431768211456"
  ) > parseUInt256(
    "340282366920938463463374607431768211455"
  )

  doAssert parseInt256(
    "-1"
  ) < parseInt256(
    "0"
  )

  doAssert parseInt256(
    "-2"
  ) < parseInt256(
    "-1"
  )

block bitwise:
  let a =
    fromUInt64Words(
      0xF0F0F0F0F0F0F0F0'u64,
      0xAAAAAAAAAAAAAAAA'u64,
      0xCCCCCCCCCCCCCCCC'u64,
      0x123456789ABCDEF0'u64,
    )

  let b =
    fromUInt64Words(
      0x0F0F0F0F0F0F0F0F'u64,
      0x5555555555555555'u64,
      0x3333333333333333'u64,
      0xFEDCBA9876543210'u64,
    )

  doAssert word64(a and b, 3) == 0'u64
  doAssert word64(a or b, 2) == high(uint64)
  doAssert word64(a xor b, 1) == high(uint64)
  doAssert word64(not parseUInt256("0"), 0) == high(uint64)

block addSub:
  let two64 =
    parseUInt256(
      "18446744073709551616"
    )

  doAssert two64 -
    parseUInt256("1") ==
    parseUInt256(
      "18446744073709551615"
    )

  let maximum =
    parseUInt256(
      "115792089237316195423570985008687907853269984665640564039457584007913129639935"
    )

  doAssert maximum +
    parseUInt256("1") ==
    parseUInt256("0")

  doAssert parseUInt256("0") -
    parseUInt256("1") ==
    maximum

block shifts:
  let one =
    parseUInt256("1")

  doAssert one shl 64 ==
    parseUInt256(
      "18446744073709551616"
    )

  doAssert one shl 128 ==
    parseUInt256(
      "340282366920938463463374607431768211456"
    )

  doAssert one shl 255 ==
    parseUInt256(
      "57896044618658097711785492504343953926634992332820282019728792003956564819968"
    )

  doAssert one shl 256 ==
    parseUInt256("0")

  doAssert (
    one shl 255
  ) shr 255 == one

  doAssert parseInt256("-1") shr 200 ==
    parseInt256("-1")

block multiplication:
  let maximum =
    parseUInt256(
      "115792089237316195423570985008687907853269984665640564039457584007913129639935"
    )

  doAssert maximum *
    parseUInt256("2") ==
    parseUInt256(
      "115792089237316195423570985008687907853269984665640564039457584007913129639934"
    )

  let left =
    parseUInt256(
      "340282366920938463463374607431768211456"
    )

  let right =
    parseUInt256(
      "18446744073709551616"
    )

  doAssert left * right ==
    parseUInt256(
      "6277101735386680763835789423207666416102355444464034512896"
    )

block division:
  let maximum =
    parseUInt256(
      "115792089237316195423570985008687907853269984665640564039457584007913129639935"
    )

  let divisor =
    parseUInt256(
      "340282366920938463463374607431768211457"
    )

  let expected =
    parseUInt256(
      "340282366920938463463374607431768211455"
    )

  doAssert maximum div divisor == expected
  doAssert maximum mod divisor == parseUInt256("0")

  let numerator =
    parseUInt256(
      "123456789012345678901234567890123456789012345678901234567890"
    )

  let denominator =
    parseUInt256(
      "98765432109876543210987654321"
    )

  doAssert numerator ==
    (
      numerator div denominator
    ) * denominator +
    (
      numerator mod denominator
    )

block parseFormat:
  let maximumUnsigned =
    "115792089237316195423570985008687907853269984665640564039457584007913129639935"

  doAssert $parseUInt256(
    maximumUnsigned
  ) == maximumUnsigned

  let maximumSigned =
    "57896044618658097711785492504343953926634992332820282019728792003956564819967"

  let minimumSigned =
    "-57896044618658097711785492504343953926634992332820282019728792003956564819968"

  doAssert $parseInt256(
    maximumSigned
  ) == maximumSigned

  doAssert $parseInt256(
    minimumSigned
  ) == minimumSigned

block signedDivision:
  let negativeSeven =
    parseInt256("-7")

  let three =
    parseInt256("3")

  doAssert negativeSeven div three ==
    parseInt256("-2")

  doAssert negativeSeven mod three ==
    parseInt256("-1")

  doAssert floorDiv(
    negativeSeven,
    three,
  ) == parseInt256("-3")

  doAssert floorMod(
    negativeSeven,
    three,
  ) == parseInt256("2")

block wideProduct:
  let maximumLimbs: UInt256Limbs =
    [
      high(uint64),
      high(uint64),
      high(uint64),
      high(uint64),
    ]

  let product =
    multiplyWide4x4(
      maximumLimbs,
      maximumLimbs,
    )

  doAssert product[0] == 1'u64
  doAssert product[1] == 0'u64
  doAssert product[2] == 0'u64
  doAssert product[3] == 0'u64
  doAssert product[4] == high(uint64) - 1'u64
  doAssert product[5] == high(uint64)
  doAssert product[6] == high(uint64)
  doAssert product[7] == high(uint64)

echo "TYPE_SIZE_UINT256=", sizeof(UInt256)
echo "TYPE_SIZE_INT256=", sizeof(Int256)
echo "TYPE_SIZE_UINT512=", sizeof(UInt512Limbs)
echo "STYLE_UINT256=YES"
echo "STYLE_INT256=YES"
echo "CONSTRUCTORS=PASS"
echo "COMPARISON=PASS"
echo "BITWISE=PASS"
echo "ADD_SUB=PASS"
echo "SHIFT=PASS"
echo "MULTIPLICATION=PASS"
echo "DIVISION=PASS"
echo "PARSE_FORMAT=PASS"
echo "SIGNED_DIVISION=PASS"
echo "WIDE_PRODUCT=PASS"

block phase2UnsignedOverflow:
  let zero =
    parseUInt256("0")

  let one =
    parseUInt256("1")

  let two =
    parseUInt256("2")

  let maximum =
    parseUInt256(
      "115792089237316195423570985008687907853269984665640564039457584007913129639935"
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

  doAssert mulOverflow.value ==
    maximum - one

  doAssert wrappingMul(maximum, two) ==
    mulOverflow.value

  doAssert saturatingMul(maximum, two) ==
    maximum

block phase2SignedOverflow:
  let one =
    parseInt256("1")

  let negativeOne =
    parseInt256("-1")

  let two =
    parseInt256("2")

  let maximum =
    parseInt256(
      "57896044618658097711785492504343953926634992332820282019728792003956564819967"
    )

  let minimum =
    parseInt256(
      "-57896044618658097711785492504343953926634992332820282019728792003956564819968"
    )

  let positiveAdd =
    overflowingAdd(
      maximum,
      one,
    )

  doAssert positiveAdd.overflow
  doAssert positiveAdd.value == minimum
  doAssert saturatingAdd(maximum, one) == maximum

  let negativeAdd =
    overflowingAdd(
      minimum,
      negativeOne,
    )

  doAssert negativeAdd.overflow
  doAssert negativeAdd.value == maximum
  doAssert saturatingAdd(minimum, negativeOne) == minimum

  let positiveSub =
    overflowingSub(
      maximum,
      negativeOne,
    )

  doAssert positiveSub.overflow
  doAssert saturatingSub(maximum, negativeOne) == maximum

  let negativeSub =
    overflowingSub(
      minimum,
      one,
    )

  doAssert negativeSub.overflow
  doAssert saturatingSub(minimum, one) == minimum

  let positiveMul =
    overflowingMul(
      maximum,
      two,
    )

  doAssert positiveMul.overflow
  doAssert saturatingMul(maximum, two) == maximum

  let minTimesNegativeOne =
    overflowingMul(
      minimum,
      negativeOne,
    )

  doAssert minTimesNegativeOne.overflow
  doAssert minTimesNegativeOne.value == minimum
  doAssert saturatingMul(minimum, negativeOne) == maximum

block phase2BitCounts:
  let zero =
    parseUInt256("0")

  let one =
    parseUInt256("1")

  let top =
    parseUInt256(
      "57896044618658097711785492504343953926634992332820282019728792003956564819968"
    )

  let maximum =
    parseUInt256(
      "115792089237316195423570985008687907853269984665640564039457584007913129639935"
    )

  doAssert countLeadingZeroBits(zero) == 256
  doAssert countTrailingZeroBits(zero) == 256
  doAssert popcount(zero) == 0

  doAssert countLeadingZeroBits(one) == 255
  doAssert countTrailingZeroBits(one) == 0
  doAssert popcount(one) == 1

  doAssert countLeadingZeroBits(top) == 0
  doAssert countTrailingZeroBits(top) == 255
  doAssert popcount(top) == 1

  doAssert popcount(maximum) == 256
  doAssert popcount(parseInt256("-1")) == 256

block phase2Rotations:
  let one =
    parseUInt256("1")

  let top =
    parseUInt256(
      "57896044618658097711785492504343953926634992332820282019728792003956564819968"
    )

  doAssert rotateLeft(one, 255) == top
  doAssert rotateRight(top, 255) == one
  doAssert rotateLeft(top, 1) == one
  doAssert rotateRight(one, 1) == top
  doAssert rotateLeft(one, -1) == top
  doAssert rotateRight(top, -1) == one
  doAssert rotateLeft(parseInt256("-1"), 93) ==
    parseInt256("-1")

block phase2HashAndPower:
  let value =
    parseUInt256(
      "123456789012345678901234567890123456789"
    )

  doAssert hash(value) ==
    hash(
      parseUInt256(
        "123456789012345678901234567890123456789"
      )
    )

  doAssert pow(
    parseUInt256("2"),
    20,
  ) == parseUInt256("1048576")

  doAssert (
    parseUInt256("2") ^ 20
  ) == parseUInt256("1048576")

  doAssert pow(
    parseInt256("-2"),
    5,
  ) == parseInt256("-32")

  doAssert pow(
    parseUInt256("123456789"),
    123,
    parseUInt256("1000000007"),
  ) == parseUInt256("922271998")

block phase2UInt512StructuredProducts:
  let value: UInt256Limbs =
    [
      1'u64,
      0'u64,
      1'u64,
      0'u64,
    ]

  let square =
    multiplyWide4x4(
      value,
      value,
    )

  doAssert square[0] == 1'u64
  doAssert square[1] == 0'u64
  doAssert square[2] == 2'u64
  doAssert square[3] == 0'u64
  doAssert square[4] == 1'u64
  doAssert square[5] == 0'u64
  doAssert square[6] == 0'u64
  doAssert square[7] == 0'u64

  let top: UInt256Limbs =
    [
      0'u64,
      0'u64,
      0'u64,
      1'u64 shl 63,
    ]

  let topSquare =
    multiplyWide4x4(
      top,
      top,
    )

  doAssert topSquare[0] == 0'u64
  doAssert topSquare[1] == 0'u64
  doAssert topSquare[2] == 0'u64
  doAssert topSquare[3] == 0'u64
  doAssert topSquare[4] == 0'u64
  doAssert topSquare[5] == 0'u64
  doAssert topSquare[6] == 0'u64
  doAssert topSquare[7] == 1'u64 shl 62

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
echo "PHASE2.HASH=PASS"
echo "PHASE2.POW=PASS"
echo "PHASE2.MODULAR_POW=PASS"
echo "PHASE2.UINT512_STRUCTURED_PRODUCT=PASS"

block ergonomicAbsoluteAndConversions:
  doAssert abs(
    parseInt256("-7")
  ) == parseInt256("7")

  doAssert abs(
    parseInt256("7")
  ) == parseInt256("7")

  let minimum =
    parseInt256(
      "-57896044618658097711785492504343953926634992332820282019728792003956564819968"
    )

  doAssert abs(minimum) ==
    minimum

  let unsignedValue =
    fromUInt64Words(
      4'u64,
      3'u64,
      2'u64,
      42'u64,
    )

  doAssert toInt(unsignedValue) == 42
  doAssert toUInt(unsignedValue) == 42'u

  doAssert toInt(
    parseInt256("-1")
  ) == -1

  doAssert toInt32(
    parseInt256("-1")
  ) == -1'i32

block ergonomicIncDec:
  var unsignedValue =
    parseUInt256("1")

  inc unsignedValue

  doAssert unsignedValue ==
    parseUInt256("2")

  dec unsignedValue

  doAssert unsignedValue ==
    parseUInt256("1")

  var signedValue =
    parseInt256("-1")

  inc signedValue

  doAssert signedValue ==
    parseInt256("0")

  dec signedValue

  doAssert signedValue ==
    parseInt256("-1")

block ergonomicAssignments:
  var unsignedValue =
    parseUInt256("10")

  unsignedValue +=
    parseUInt256("5")

  unsignedValue -=
    parseUInt256("3")

  unsignedValue *=
    parseUInt256("4")

  doAssert unsignedValue ==
    parseUInt256("48")

  var signedValue =
    parseInt256("-10")

  signedValue +=
    parseInt256("3")

  signedValue -=
    parseInt256("5")

  signedValue *=
    parseInt256("-2")

  doAssert signedValue ==
    parseInt256("24")

echo "ERGONOMIC.ABS=PASS"
echo "ERGONOMIC.TO_INT=PASS"
echo "ERGONOMIC.TO_INT32=PASS"
echo "ERGONOMIC.TO_UINT=PASS"
echo "ERGONOMIC.INC=PASS"
echo "ERGONOMIC.DEC=PASS"
echo "ERGONOMIC.ADD_ASSIGN=PASS"
echo "ERGONOMIC.SUB_ASSIGN=PASS"
echo "ERGONOMIC.MUL_ASSIGN=PASS"
echo "CONTRACT_OK"
