when not declared ATCODER_SPARSE_TABLE_HPP:
  const ATCODER_SPARSE_TABLE_HPP* = 1
  import std/sequtils
  import atcoder/rangeutils

  {.push inline.}

  type SparseTable*[T] = object
    len: int
    data: seq[seq[T]]
    lookup: seq[int]
    op: proc(a, b:T):T
    e: proc():T

  proc initSparseTable*[T](v:seq[T], op:proc(a, b:T):T, e:proc():T):SparseTable[T] =
    var b = 0
    while (1 shl b) <= v.len: b += 1
    var data = newSeqWith(b, newSeq[T](1 shl b))
    for i in 0..<v.len: data[0][i] = v[i]
    for i in 1..<b:
      var j = 0
      while j + (1 shl i) <= (1 shl b):
        data[i][j] = op(data[i - 1][j], data[i - 1][j + (1 shl (i - 1))]);
        j += 1
    var lookup = newSeq[int](v.len + 1)
    for i in 2..<lookup.len: lookup[i] = lookup[i shr 1] + 1
    return SparseTable[T](len: v.len, data:data, lookup:lookup, op:op, e:e)

  proc prod*[T](self: SparseTable[T], s:RangeType):T =
    let (l, r) = self.halfOpenEndpoints(s)
    if l >= r: return self.e()
    let b = self.lookup[r - l]
    return self.op(self.data[b][l], self.data[b][r - (1 shl b)])
  proc `[]`*[T](self: SparseTable[T], s:RangeType):T = self.prod(s)
  {.pop.}
