when not declared ATCODER_PERSISTENT_DSU_HPP:
  const ATCODER_PERSISTENT_DSU_HPP* = 1
  import std/sequtils
  import atcoder/extra/structure/persistent_array
  type PersistentDSU* = object
    data: PersistentArray[int]
  
  proc initPersistentDSU*(sz:int):PersistentDSU =
    PersistentDSU(data:initPersistentArray[int](newSeqWith(sz, -1)))
  
  proc leader*(self:PersistentDSU, k:int):int =
    let p = self.data[k]
    return if p >= 0: self.leader(p) else: k
  
  proc size*(self:PersistentDSU, k:int):int = -self.data[self.leader(k)]
  
  proc merge*(self:PersistentDSU, x, y:int):PersistentDSU =
    let
      x = self.leader(x)
      y = self.leader(y)
    if x == y: return self
    var self = self
    let
      u = self.data[x]
      v = self.data[y]
    if u < v:
      self.data[x] = u + v
      self.data[y] = x
    else:
      self.data[y] = u + v
      self.data[x] = y
    return self
