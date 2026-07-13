discard """
  cmd: "nim cpp -r -d:release $file"
"""

import std/strutils

import atcoder/extra/structure/dense_bitset


proc nextRand(state: var uint64): uint64 =
  state = state xor (state shl 7)
  state = state xor (state shr 9)
  state = state xor (state shl 8)
  result = state


proc filled(n: int, value: int): seq[int] =
  result = newSeq[int](n)

  for i in 0 ..< n:
    result[i] = value


proc binaryOracle(
    a: seq[int],
    b: seq[int],
    operation: char,
): seq[int] =
  doAssert a.len == b.len
  result = newSeq[int](a.len)

  for i in 0 ..< a.len:
    case operation
    of '&':
      result[i] = a[i] and b[i]
    of '|':
      result[i] = a[i] or b[i]
    of '^':
      result[i] = a[i] xor b[i]
    else:
      doAssert false


proc notOracle(a: seq[int]): seq[int] =
  result = newSeq[int](a.len)

  for i, value in a:
    result[i] = 1 - value


proc leftOracle(a: seq[int], amount: int): seq[int] =
  result = newSeq[int](a.len)

  if amount >= a.len:
    return

  for i, value in a:
    if value != 0 and i + amount < a.len:
      result[i + amount] = 1


proc rightOracle(a: seq[int], amount: int): seq[int] =
  result = newSeq[int](a.len)

  if amount >= a.len:
    return

  for i, value in a:
    if value != 0 and i >= amount:
      result[i - amount] = 1


proc firstOne(a: seq[int]): int =
  for i, value in a:
    if value != 0:
      return i

  return a.len


proc lastOne(a: seq[int]): int =
  if a.len == 0:
    return -1

  for i in countdown(a.high, 0):
    if a[i] != 0:
      return i

  return -1


proc checkBits[BS](bits: BS, expected: seq[int]) =
  doAssert bits.getSize == expected.len

  var expectedCount = 0

  for i, value in expected:
    doAssert bits[i] == value
    expectedCount += value

  doAssert bits.count == expectedCount
  doAssert bits.any == (expectedCount != 0)
  doAssert bits.all == (expectedCount == expected.len)

  doAssert bits.toStr().len == expected.len
  doAssert bits.toStr().count('1') == expectedCount

  doAssert bits.firstSetBit == firstOne(expected)
  doAssert bits.fastLog2 == lastOne(expected)


proc fixedProbe[N: static[int]]() =
  var zero = initBitSet[N]()
  let zeros = filled(N, 0)
  let ones = filled(N, 1)

  checkBits(zero, zeros)

  let full = initBitSet1(N)

  checkBits(full, ones)
  checkBits(BitSet[N].init1(), ones)
  checkBits(not zero, ones)
  checkBits(not full, zeros)

  var a = initBitSet[N]()
  var b = initBitSet[N]()

  var expectedA = filled(N, 0)
  var expectedB = filled(N, 0)

  for i in 0 ..< N:
    if i mod 3 == 0:
      a[i] = 1
      expectedA[i] = 1

    if i mod 5 == 0:
      b[i] = 1
      expectedB[i] = 1

  checkBits(a and b, binaryOracle(expectedA, expectedB, '&'))
  checkBits(a or b, binaryOracle(expectedA, expectedB, '|'))
  checkBits(a xor b, binaryOracle(expectedA, expectedB, '^'))

  var inplace = a
  `and=`(inplace, b)
  checkBits(inplace, binaryOracle(expectedA, expectedB, '&'))

  inplace = a
  `or=`(inplace, b)
  checkBits(inplace, binaryOracle(expectedA, expectedB, '|'))

  inplace = a
  `xor=`(inplace, b)
  checkBits(inplace, binaryOracle(expectedA, expectedB, '^'))

  for amount in [0, 1, 2, 63, 64, N, N + 1]:
    checkBits(a shl amount, leftOracle(expectedA, amount))
    checkBits(a shr amount, rightOracle(expectedA, amount))

  if N >= 2:
    var small = initBitSet[N]()
    var large = initBitSet[N]()

    small[0] = 1
    large[N - 1] = 1

    doAssert small < large
    doAssert small <= large
    doAssert not (large < small)
    doAssert not (large <= small)
    doAssert small <= small


proc dynamicProbe(n: int) =
  var zero = initDynamicBitSet(n)
  let zeros = filled(n, 0)
  let ones = filled(n, 1)

  checkBits(zero, zeros)

  let full = initDynamicBitSet1(n)

  checkBits(full, ones)
  checkBits(not zero, ones)
  checkBits(not full, zeros)

  var a = initDynamicBitSet(n)
  var b = initDynamicBitSet(n)

  var expectedA = filled(n, 0)
  var expectedB = filled(n, 0)

  for i in 0 ..< n:
    if i mod 3 == 0:
      a[i] = 1
      expectedA[i] = 1

    if i mod 5 == 0:
      b[i] = 1
      expectedB[i] = 1

  checkBits(a and b, binaryOracle(expectedA, expectedB, '&'))
  checkBits(a or b, binaryOracle(expectedA, expectedB, '|'))
  checkBits(a xor b, binaryOracle(expectedA, expectedB, '^'))

  for amount in [0, 1, 2, 63, 64, n, n + 1]:
    checkBits(a shl amount, leftOracle(expectedA, amount))
    checkBits(a shr amount, rightOracle(expectedA, amount))

  if n >= 2:
    var small = initDynamicBitSet(n)
    var large = initDynamicBitSet(n)

    small[0] = 1
    large[n - 1] = 1

    doAssert small < large
    doAssert small <= large
    doAssert not (large < small)
    doAssert not (large <= small)


proc randomDynamicProbe(n: int, initialSeed: uint64) =
  var state = initialSeed
  var bits = initDynamicBitSet(n)
  var expected = filled(n, 0)

  for step in 0 ..< 1200:
    let index = int(nextRand(state) mod uint64(n))
    let value = int(nextRand(state) and 1'u64)

    bits[index] = value
    expected[index] = value

    if step mod 19 == 0:
      checkBits(bits, expected)
      checkBits(not bits, notOracle(expected))

      let amount =
        int(nextRand(state) mod uint64(n + 2))

      checkBits(bits shl amount, leftOracle(expected, amount))
      checkBits(bits shr amount, rightOracle(expected, amount))


fixedProbe[1]()
fixedProbe[2]()
fixedProbe[63]()
fixedProbe[64]()
fixedProbe[65]()
fixedProbe[127]()
fixedProbe[128]()
fixedProbe[129]()

for n in [0, 1, 2, 63, 64, 65, 127, 128, 129]:
  dynamicProbe(n)

for n in [1, 63, 64, 65, 129]:
  randomDynamicProbe(
    n,
    0x8e4d_62a1_9c37_51b5'u64 xor uint64(n),
  )


block:
  var original = initDynamicBitSet(65)
  original[0] = 1
  original[64] = 1

  var copied = original
  copied[1] = 1

  doAssert original[1] == 0
  doAssert copied[1] == 1

echo "BITSET_CONTRACT_TEST_OK"
