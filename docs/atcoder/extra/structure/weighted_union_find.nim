import sequtils

type WeightedUnionFind[T] = object
  data:seq[int]
  ws:seq[T]

proc initWeightedUnionFind[T](sz:int):WeightedUnionFind[T] =
  WeightedUnionFind[T](data:newSeqWith(sz, -1), ws:newSeq[T](sz))

proc root[T](self:var WeightedUnionFind[T], k:int):int{.discardable.} =
  if self.data[k] < 0: return k
  let par = self.root(self.data[k])
  self.ws[k] += self.ws[self.data[k]]
  self.data[k] = par
  return self.data[k]

proc weight[T](self:var WeightedUnionFind[T], t:int):T =
  self.root(t)
  return self.ws[t]

proc unionSet[T](self:var WeightedUnionFind[T], x,y:int, w:T):bool{.discardable.} =
  var w = w
  w += self.weight(x)
  w -= self.weight(y)
  var
    x = self.root(x)
    y = self.root(y)
  if x == y: return false
  if self.data[x] > self.data[y]:
    swap(x, y)
    w *= -1
  self.data[x] += self.data[y]
  self.data[y] = x
  self.ws[y] = w
  return true

proc diff[T](self:var WeightedUnionFind[T], x,y:int):T =
  return self.weight(y) - self.weight(x)

proc groups[T](self: var WeightedUnionFind[T]): seq[seq[int]] =
  var
    leaderBuf = newSeq[int](self.data.len)
    groupSize = newSeq[int](self.data.len)
  for i in 0..<self.data.len:
    leaderBuf[i] = self.root(i)
    groupSize[leaderBuf[i]].inc
  result = (0..<self.data.len).mapIt(newSeqOfCap[int](groupSize[it]))
  for i, ldr in leaderBuf:
    result[ldr].add i
  result.keepItIf(it.len > 0)
