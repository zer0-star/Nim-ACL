discard """
  cmd: "nim cpp -r -d:release $file"
"""

import std/algorithm

import atcoder/extra/bit/bitmask


proc oracleMask[B: SomeInteger](n: int): B =
  const bitWidth = sizeof(B) * 8

  when sizeof(B) == 1:
    type U = uint8
  elif sizeof(B) == 2:
    type U = uint16
  elif sizeof(B) == 4:
    type U = uint32
  elif sizeof(B) == 8:
    type U = uint64
  else:
    {.error: "unsupported integer width".}

  var mask: U

  if n == 0:
    mask = U(0)
  elif n == bitWidth:
    mask = high(U)
  else:
    mask = (U(1) shl n) - U(1)

  result = cast[B](mask)


proc oracleSlice[B: SomeInteger](
    value: B,
    first: int,
    last: int,
): B =
  let width = last - first + 1

  if width == sizeof(B) * 8:
    result = value
  else:
    result =
      (value shr first) and oracleMask[B](width)


proc nextRand(state: var uint64): uint64 =
  state = state xor (state shl 7)
  state = state xor (state shr 9)
  state = state xor (state shl 8)
  result = state


block:
  doAssert allSetBits[uint8](0) == 0'u8
  doAssert allSetBits[uint8](8) == high(uint8)

  doAssert allSetBits[uint16](0) == 0'u16
  doAssert allSetBits[uint16](16) == high(uint16)

  doAssert allSetBits[uint32](0) == 0'u32
  doAssert allSetBits[uint32](32) == high(uint32)

  doAssert allSetBits[uint64](0) == 0'u64
  doAssert allSetBits[uint64](64) == high(uint64)

  doAssert allSetBits[int](0) == 0
  doAssert allSetBits[int](5) == 31
  doAssert allSetBits[int](sizeof(int) * 8) == not 0


block:
  let value64 = 0xFEDC_BA98_7654_3210'u64
  let value32 = 0xDEAD_BEEF'u32

  let partial64: uint64 = value64[8 .. 31]
  let complete64: uint64 = value64[0 .. 63]

  let partial32: uint32 = value32[4 .. 19]
  let complete32: uint32 = value32[0 .. 31]

  doAssert partial64 == oracleSlice(value64, 8, 31)
  doAssert complete64 == value64

  doAssert partial32 == oracleSlice(value32, 4, 19)
  doAssert complete32 == value32


block:
  let mask = 0b10110'u64

  var actual: seq[uint64]

  for subset in subsets(mask):
    actual.add(subset)

  actual.sort()

  let expected = @[
    0'u64,
    0b00010'u64,
    0b00100'u64,
    0b00110'u64,
    0b10000'u64,
    0b10010'u64,
    0b10100'u64,
    0b10110'u64,
  ]

  doAssert actual == expected


block:
  var actual: seq[uint64]

  for subset in subsets(@[1, 3], uint64):
    actual.add(subset)

  actual.sort()

  doAssert actual == @[0'u64, 2'u64, 8'u64, 10'u64]


block:
  var state = 0x8e4d_62a1_9c37_51b5'u64

  for _ in 0 ..< 100:
    let value = nextRand(state)

    for first in 0 ..< 64:
      for last in first ..< 64:
        let actual: uint64 = value[first .. last]

        doAssert actual == oracleSlice(
          value,
          first,
          last,
        )


block:
  var state = 0x916a_c4e8_75d3_2fb1'u64

  for _ in 0 ..< 100:
    let value = uint32(nextRand(state))

    for first in 0 ..< 32:
      for last in first ..< 32:
        let actual: uint32 = value[first .. last]

        doAssert actual == oracleSlice(
          value,
          first,
          last,
        )

echo "BITUTILS_REGRESSION_OK"
