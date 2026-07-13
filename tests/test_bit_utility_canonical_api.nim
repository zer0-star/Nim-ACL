discard """
  cmd: "nim cpp -r -d:release $file"
"""

import atcoder/extra/bit/bitmask
import atcoder/extra/structure/dense_bitset


let mask =
  maskFromBitIndices[uint64](0, 2, 63)

doAssert bitIndices(mask) == @[0, 2, 63]
doAssert lowBitsMask[uint64](0) == 0'u64
doAssert lowBitsMask[uint64](64) == high(uint64)
doAssert toBitString(mask, 64).len == 64

var submaskCount = 0

for submask in submasks(mask):
  doAssert (submask and mask) == submask
  inc submaskCount

doAssert submaskCount == 8

var subsetMaskCount = 0

for subset in subsetMasks(@[1, 3, 7], uint64):
  discard subset
  inc subsetMaskCount

doAssert subsetMaskCount == 8

let fixed = initFullBitSet[65]()
let dynamic = initFullDynamicBitSet(65)

doAssert fixed.count == 65
doAssert dynamic.count == 65
doAssert fixed.firstSetBit == 0
doAssert dynamic.fastLog2 == 64

echo "BIT_UTILITY_CANONICAL_API_OK"
