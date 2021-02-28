when not declared ATCODER_SPARSE_TABLE_HPP:
  const ATCODER_SPARSE_TABLE_HPP* = 1
  import std/sequtils

  {.push inline.}

  type SparseTable*[T] = object
    data: seq[seq[T]]
    lookup: seq[int]
    f: proc(a, b:T):T

  proc initSparseTable*[T](v:seq[T], f:proc(a, b:T):T):SparseTable[T] =
    var b = 0
    while (1 shl b) <= v.len: b += 1
    var data = newSeqWith(b, newSeq[T](1 shl b))
    for i in 0..<v.len: data[0][i] = v[i]
    for i in 1..<b:
      var j = 0
      while j + (1 shl i) <= (1 shl b):
        data[i][j] = f(data[i - 1][j], data[i - 1][j + (1 shl (i - 1))]);
        j += 1
    var lookup = newSeq[int](v.len + 1)
    for i in 2..<lookup.len: lookup[i] = lookup[i shr 1] + 1
    return SparseTable[T](data:data, lookup:lookup, f:f)

  proc prod*[T](self: SparseTable[T], s:Slice[int]):T =
    let b = self.lookup[s.b + 1 - s.a]
    return self.f(self.data[b][s.a], self.data[b][s.b + 1 - (1 shl b)])
  proc `[]`*[T](self: SparseTable[T], s:Slice[int]):T = self.prod(s)
  {.pop.}
