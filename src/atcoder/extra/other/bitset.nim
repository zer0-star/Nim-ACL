when not declared ATCODER_BITSET_HPP:
  const ATCODER_BITSET_HPP* = 1
  import strutils, sequtils, algorithm
  import atcoder/extra/other/bitutils
  
  const BitWidth = 64
  
  # bitset
  type BitSet*[N:static[int]] = object
    data: array[(N + BitWidth - 1) div BitWidth, uint64]
  
  proc initBitSet*[N:static[int]](): BitSet[N] =
    discard
  proc initBitSet1*[N:static[int]](): BitSet[N] =
    result = initBitSet(N)
    let
      q = N div BitWidth
      r = N mod BitWidth
    for i in 0..<q:result.data[i] = (not 0'u64)
    if r > 0:result.data[q] = ((1'u64 shl uint64(r)) - 1)
  proc init*[N:static[int]](self: BitSet[N]):BitSet[N] = initBitSet[N]()
  proc init1*[N:static[int]](self: BitSet[N]):BitSet[N] = initBitSet1[N]()
  proc getSize*[N:static[int]](self: BitSet[N]):int = N

  # dynamic bitset
  type DynamicBitSet* = object
    N:int
    data: seq[uint64]
  
  proc initDynamicBitSet*(N:int): DynamicBitSet =
    let size = (N + BitWidth - 1) div BitWidth
    return DynamicBitSet(N:N, data:newSeqWith(size, 0'u64))
  proc initDynamicBitSet1*(N:int): DynamicBitSet =
    result = initDynamicBitSet(N)
    let
      q = N div BitWidth
      r = N mod BitWidth
    for i in 0..<q:result.data[i] = (not 0'u64)
    if r > 0:result.data[q] = ((1'u64 shl uint64(r)) - 1)
  proc init*(self: DynamicBitSet):DynamicBitSet = initDynamicBitSet(self.N)
  proc init1*(self: DynamicBitSet):DynamicBitSet = initDynamicBitSet1(self.N)
  proc getSize*(self: DynamicBitSet):int = self.N

  type SomeBitSet* = BitSet | DynamicBitSet
  
  proc toBin*(b:uint64, n: int): string =
    result = ""
    for i in countdown(n-1, 0):
      if (b and (1'u64 shl uint64(i))) != 0'u64: result &= "1"
      else: result &= "0"
  
  proc `$`*(a: SomeBitSet):string =
    let N = a.getSize()
    var
      q = N div BitWidth
      r = N mod BitWidth
    var v = newSeq[string]()
    for i in 0..<q: v.add(a.data[i].toBin(BitWidth))
    if r > 0: v.add(a.data[q].toBin(r))
    v.reverse()
    return v.join("")
  
  proc `not`*(a: SomeBitSet): auto =
    result = a.init1()
    for i in 0..<a.data.len: result.data[i] = (not a.data[i]) and result.data[i]
  proc `or`*(a, b: SomeBitSet): auto =
    result = a.init()
    for i in 0..<a.data.len: result.data[i] = a.data[i] or b.data[i]
  proc `and`*(a, b: SomeBitSet): auto =
    result = a.init()
    for i in 0..<a.data.len: result.data[i] = a.data[i] and b.data[i]
  proc `xor`*(a, b: SomeBitSet): auto =
    result = a.init()
    for i in 0..<a.data.len: result.data[i] = a.data[i] xor b.data[i]
  
  proc any*(a: SomeBitSet): bool = 
    let N = a.getSize()
    var
      q = N div BitWidth
      r = N mod BitWidth
    for i in 0..<q:
      if a.data[i] != 0.uint64: return true
    if r > 0 and (a.data[^1] and setBits[uint64](r)) != 0.uint64: return true
    return false
  
  proc all*(a: SomeBitSet): bool =
    let N = a.getSize()
    var
      q = N div BitWidth
      r = N mod BitWidth
    for i in 0..<q:
      if (not a.data[i]) != 0.uint64: return false
    if r > 0 and a.data[^1] != setBits[uint64](r): return false
    return true
  
  proc `[]`*(b:SomeBitSet,n:int):int =
    let N = b.getSize()
    assert 0 <= n and n < N
    let
      q = n div BitWidth
      r = n mod BitWidth
    return b.data[q][r].int
  proc `[]=`*(b:var SomeBitSet,n:int,t:int) =
    let N = b.getSize()
    assert 0 <= n and n < N
    assert t == 0 or t == 1
    let
      q = n div BitWidth
      r = n mod BitWidth
    b.data[q][r] = t
  
  proc `shl`*(a: SomeBitSet, n:int): auto =
    result = a.init()
    var r = int(n mod BitWidth)
    if r < 0: r += BitWidth
    let q = (n - r) div BitWidth
    let maskl = allSetBits[uint64](BitWidth - r)
    for i in 0..<a.data.len:
      let d = (a.data[i] and maskl) shl uint64(r)
      let i2 = i + q
      if 0 <= i2 and i2 < a.data.len: result.data[i2] = result.data[i2] or d
    if r != 0:
      let maskr = allSetBits[uint64](r) shl uint64(BitWidth - r)
      for i in 0..<a.data.len:
        let d = (a.data[i] and maskr) shr uint64(BitWidth - r)
        let i2 = i + q + 1
        if 0 <= i2 and i2 < a.data.len: result.data[i2] = result.data[i2] or d
    block:
      let r = a.getSize() mod BitWidth
      if r != 0:
        let mask = not (allSetBits[uint64](BitWidth - r) shl uint64(r))
        result.data[^1] = result.data[^1] and mask
  proc `shr`*(a: SomeBitSet, n:int): auto = a shl (-n)
