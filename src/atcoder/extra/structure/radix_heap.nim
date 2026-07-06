
when not declared ATCODER_RADIX_HEAP_HPP:
  const ATCODER_RADIX_HEAP_HPP* = 1
  import std/bitops

  type RadixHeap*[key_t, val_t] = object
    sz: int
    last: key_t
    vs: array[sizeof(key_t) * 8 + 1, seq[(key_t, val_t)]]

  template bitWidth(T: typedesc): int = sizeof(T) * 8

  template valueMask(T: typedesc): uint64 =
    when sizeof(T) * 8 >= 64:
      uint64.high
    else:
      (1'u64 shl (sizeof(T) * 8)) - 1'u64

  proc keyCode[K: SomeInteger](x: K): uint64 {.inline.} =
    let masked = cast[uint64](x) and valueMask(K)
    when K is SomeSignedInt:
      masked xor (1'u64 shl (bitWidth(K) - 1))
    else:
      masked

  proc getbit*[key_t: SomeInteger, val_t](
      self: RadixHeap[key_t, val_t],
      a: key_t
  ): int {.inline.} =
    let d = keyCode(a) xor keyCode(self.last)
    if d == 0'u64:
      return 0
    return 64 - countLeadingZeroBits(d)

  proc initRadixHeap*[key_t: SomeInteger, val_t](): RadixHeap[key_t, val_t] =
    return RadixHeap[key_t, val_t](sz: 0, last: key_t.low)

  proc empty*[key_t, val_t](self: RadixHeap[key_t, val_t]): bool {.inline.} =
    self.sz == 0

  proc len*[key_t, val_t](self: RadixHeap[key_t, val_t]): int {.inline.} =
    self.sz

  proc push*[key_t: SomeInteger, val_t](
      self: var RadixHeap[key_t, val_t],
      key: key_t,
      val: val_t
  ) =
    assert key >= self.last
    self.sz.inc
    self.vs[self.getbit(key)].add((key, val))

  proc pop*[key_t: SomeInteger, val_t](
      self: var RadixHeap[key_t, val_t]
  ): (key_t, val_t) =
    assert self.sz > 0

    proc calcMinKey(v: seq[(key_t, val_t)]): key_t =
      result = v[0][0]
      for i in 1..<v.len:
        if v[i][0] < result:
          result = v[i][0]

    if self.vs[0].len == 0:
      var idx = 1
      while idx < self.vs.len and self.vs[idx].len == 0:
        idx.inc

      assert idx < self.vs.len

      self.last = calcMinKey(self.vs[idx])

      for p in self.vs[idx]:
        self.vs[self.getbit(p[0])].add(p)

      self.vs[idx].setLen(0)

    self.sz.dec
    result = self.vs[0][^1]
    discard self.vs[0].pop()
