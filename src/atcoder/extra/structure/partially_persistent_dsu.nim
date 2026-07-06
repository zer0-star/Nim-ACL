
when not declared ATCODER_PARTIALLY_PERSISTENT_DSU_HPP:
  const ATCODER_PARTIALLY_PERSISTENT_DSU_HPP* = 1
  import std/sequtils
  import std/algorithm

  type PartiallyPersistentDSU* = object
    data*: seq[int]
    last*: seq[int]
    add*: seq[seq[(int, int)]]
    currentTime*: int

  proc initPartiallyPersistentDSU*(sz: int): PartiallyPersistentDSU =
    return PartiallyPersistentDSU(
      data: newSeqWith(sz, -1),
      last: newSeqWith(sz, int.high),
      add: newSeqWith(sz, @[(int.low, -1)]),
      currentTime: int.low
    )

  proc leader*(self: PartiallyPersistentDSU, t, x: int): int =
    assert 0 <= x and x < self.data.len

    if t < self.last[x]:
      return x

    return self.leader(t, self.data[x])

  proc merge*(self: var PartiallyPersistentDSU, t, x, y: int): bool =
    assert 0 <= x and x < self.data.len
    assert 0 <= y and y < self.data.len
    assert self.currentTime <= t

    self.currentTime = t

    var
      x = self.leader(t, x)
      y = self.leader(t, y)

    if x == y:
      return false

    if self.data[x] > self.data[y]:
      swap(x, y)

    self.data[x] += self.data[y]
    self.add[x].add((t, self.data[x]))
    self.data[y] = x
    self.last[y] = t

    return true

  proc same*(self: PartiallyPersistentDSU, t, x, y: int): bool =
    self.leader(t, x) == self.leader(t, y)

  proc size*(self: PartiallyPersistentDSU, t, x: int): int =
    let r = self.leader(t, x)
    let i = self.add[r].lowerBound((t, int.high))
    return -self.add[r][i - 1][1]
