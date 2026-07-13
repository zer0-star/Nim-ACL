discard """
  cmd: "nim cpp -r -d:release $file"
"""

import atcoder/extra/bit/bitmask
import atcoder/extra/structure/dense_bitset

import atcoder/extra/other/bitset
import atcoder/extra/other/bitutils


let oldMask =
  seqToBits[uint64](0, 2, 63)

doAssert bitsToSeq(oldMask) == @[0, 2, 63]

let oldFixed = initBitSet1(65)
let oldDynamic = initDynamicBitSet1(65)

doAssert oldFixed.count == 65
doAssert oldDynamic.count == 65

let newMask =
  maskFromBitIndices[uint64](1, 4)

doAssert bitIndices(newMask) == @[1, 4]

let newFixed = initFullBitSet[5]()
let newDynamic = initFullDynamicBitSet(5)

doAssert newFixed.count == 5
doAssert newDynamic.count == 5

echo "BIT_UTILITY_LEGACY_AND_MIXED_IMPORTS_OK"
