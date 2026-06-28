when not declared SUCCINCT_INDEXABLE_DICTIONARY_HPP:
  const SUCCINCT_INDEXABLE_DICTIONARY_HPP* = 1
  import bitops
  type SuccinctIndexableDictionary* = object
    len, blocks:int
    bit, sum:seq[uint32]

  proc initSuccinctIndexableDictionary*(len:int):SuccinctIndexableDictionary =
    let b = (len + 31) shr 5
    SuccinctIndexableDictionary(len:len, blocks:b, bit:newSeq[uint32](b), sum:newSeq[uint32](b))

  proc set*(self:var SuccinctIndexableDictionary, k:int) =
    let i = k shr 5
    self.bit[i] = self.bit[i] or (1'u32 shl (k and 31))

  proc build*(self:var SuccinctIndexableDictionary) =
    self.sum[0] = 0'u32
    for i in 0..<self.blocks:
      self.sum[i] = self.sum[i - 1] + popcount(self.bit[i - 1]).uint32

  proc `[]`*(self:SuccinctIndexableDictionary, k:int):bool =
    bool((self.bit[k shr 5] shr (k and 31)) and 1)

  proc rank*(self:SuccinctIndexableDictionary, k:int):int =
    return self.sum[k shr 5].int + popcount(self.bit[k shr 5] and ((1'u32 shl (k and 31)) - 1))

  proc rank*(self:SuccinctIndexableDictionary, val:bool, k:int):int =
    return if val: self.rank(k) else: k - self.rank(k)
