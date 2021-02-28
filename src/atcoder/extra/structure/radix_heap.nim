when not declared ATCODER_RADIX_HEAP_HPP:
  const ATCODER_RADIX_HEAP_HPP* = 1
  import std/bitops
  proc calcBit(key_t:typedesc[SomeInteger]):int {.compileTime.} = sizeof(key_t) * 8
  type RadixHeap*[key_t, val_t] = object
    sz:uint
    last:key_t
    vs:array[sizeof(key_t) * 8, seq[(key_t, val_t)]]

  proc initRadixHeap*[key_t, val_t]():RadixHeap[key_t, val_t] = RadixHeap[key_t, val_t](sz:0, last:key_t(0))

  proc empty*[T:RadixHeap](self:T):bool = self.sz == 0
  proc len*[T:RadixHeap](self:T):int = self.sz

  proc getbit*(self:RadixHeap, a:int32):int =
    const bit = calcBit(self.key_t)
    if a != 0: bit - countLeadingZeroBits(a) else: 0

  proc getbit*(self:RadixHeap, a:int or int64):int =
    const bit = calcBit(self.key_t)
    if a != 0: bit - countLeadingZeroBits(a) else: 0

  proc push*(self:var RadixHeap, key:self.key_t, val:self.val_t) =
    self.sz.inc
    self.vs[self.getbit(key xor self.last)].add((key, val))

  proc pop*(self:var RadixHeap):(self.key_t, self.val_t) =
    proc calc_min_key(v:seq[(self.key_t, self.val_t)]):self.key_t =
      result = v[0][0]
      for i in 1..<v.len:
        if result > v[i][0]: result = v[i][0]
    if self.vs[0].len == 0:
      var idx = 1
      while self.vs[idx].len == 0: idx.inc
      self.last = calc_min_key(self.vs[idx])
      for p in self.vs[idx]: self.vs[self.getbit(p[0] xor self.last)].add(p)
      self.vs[idx].setLen(0)
    self.sz.dec
    result = self.vs[0][^1]
    discard self.vs[0].pop()
