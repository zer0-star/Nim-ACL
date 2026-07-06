
when not declared SUCCINCT_INDEXABLE_DICTIONARY_HPP:
  const SUCCINCT_INDEXABLE_DICTIONARY_HPP* = 1
  import std/bitops

  type SuccinctIndexableDictionary* = object
    len*, blocks*: int
    bit*, sum*: seq[uint32]

  proc initSuccinctIndexableDictionary*(len: int): SuccinctIndexableDictionary =
    let blocks = (len + 31) shr 5
    return SuccinctIndexableDictionary(
      len: len,
      blocks: blocks,
      bit: newSeq[uint32](blocks),
      sum: newSeq[uint32](blocks + 1)
    )

  proc set*(self: var SuccinctIndexableDictionary, k: int) =
    assert 0 <= k and k < self.len
    let i = k shr 5
    self.bit[i] = self.bit[i] or (1'u32 shl (k and 31))

  proc build*(self: var SuccinctIndexableDictionary) =
    self.sum[0] = 0'u32
    for i in 0..<self.blocks:
      self.sum[i + 1] = self.sum[i] + popcount(self.bit[i]).uint32

  proc `[]`*(self: SuccinctIndexableDictionary, k: int): bool =
    assert 0 <= k and k < self.len
    return (((self.bit[k shr 5] shr (k and 31)) and 1'u32) != 0'u32)

  proc rank*(self: SuccinctIndexableDictionary, k: int): int =
    assert 0 <= k and k <= self.len
    let blk = k shr 5
    let offset = k and 31

    result = self.sum[blk].int

    if offset != 0 and blk < self.blocks:
      let mask = (1'u32 shl offset) - 1'u32
      result += popcount(self.bit[blk] and mask)

  proc rank*(self: SuccinctIndexableDictionary, val: bool, k: int): int =
    if val:
      return self.rank(k)
    else:
      return k - self.rank(k)
