when not declared ATCODER_FENWICKTREE_HPP:
  const ATCODER_FENWICKTREE_HPP* = 1
  import std/sequtils
  import atcoder/internal_type_traits

  # TODO
  #include <atcoder/internal_type_traits>

  # Reference: https://en.wikipedia.org/wiki/Fenwick_tree
  type fenwick_tree*[T, U] = object
    n:int
    data:seq[U]
  
  # TODO
  #  using U = internal::to_unsigned_t<T>;
  
  proc init_fenwick_tree*[T](n:int):auto =
    type U =
      (
      when T is int: uint
      elif T is int8: uint8
      elif T is int16: uint16
      elif T is int32: uint32
      elif T is int64: uint64
      else: T
      )
    return fenwick_tree[T, U](n:n, data:newSeqWith(n, U(0)))

  proc add*[T, U](self: var fenwick_tree[T, U], p:int, x:T) =
    type U = 
      (
      when T is int: uint
      elif T is int8: uint8
      elif T is int16: uint16
      elif T is int32: uint32
      elif T is int64: uint64
      else: T
      )

    assert p in 0..<self.n
    var p = p + 1
    while p <= self.n:
      self.data[p - 1] += U(x)
      p += p and -p
  proc sum[T, U](self: fenwick_tree[T, U], r:int):auto =
    type U = 
      (
      when T is int: uint
      elif T is int8: uint8
      elif T is int16: uint16
      elif T is int32: uint32
      elif T is int64: uint64
      else: T
      )
    result = U(0)
    var r = r
    while r > 0:
      result += self.data[r - 1]
      r -= r and -r
  proc sum*[T, U](self: fenwick_tree[T, U], p:Slice[int]):T =
    let (l, r) = (p.a, p.b + 1)
    assert 0 <= l and l <= r and r <= self.n
    return cast[T](self.sum(r) - self.sum(l))
