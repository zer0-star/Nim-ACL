when not declared ATCODER_PARTIALLY_PERSISTENT_DSU_HPP:
  const ATCODER_PARTIALLY_PERSISTENT_DSU_HPP* = 1
  import std/sequtils, std/math, std/algorithm
  
  type PartiallyPersistentDSU* = object
    data, last: seq[int]
    add: seq[seq[(int,int)]]
  
  proc initPartiallyPersistentDSU*(sz:int):auto =
    return PartiallyPersistentDSU(
      data:newSeqWith(sz, -1), 
      last:newSeqWith(sz, 10^9), 
      add:newSeqWith(sz, @[(-1, -1)])
    )
  
  proc leader*(self: PartiallyPersistentDSU, t, x:int):int =
    if t < self.last[x]: return x
    return self.leader(t, self.data[x])
  
  proc merge*(self: var PartiallyPersistentDSU, t, x, y:int):bool =
    var
      x = self.leader(t, x)
      y = self.leader(t, y)
    if x == y: return false
    if self.data[x] > self.data[y]: swap(x, y)
    self.data[x] += self.data[y]
    self.add[x].add((t, self.data[x]))
    self.data[y] = x
    self.last[y] = t
    return true
  
  proc size*(self: PartiallyPersistentDSU, t, x:int):int =
    let x = self.leader(t, x)
    let i = self.add[x].lower_bound((t, 0))
    return -self.add[x][i - 1][1]
