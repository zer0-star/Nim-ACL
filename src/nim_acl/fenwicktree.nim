when not declared ATCODER_FENWICKTREE_HPP:
  const ATCODER_FENWICKTREE_HPP* = 1
  import std/sequtils

  # TODO
  #include <atcoder/internal_type_traits>

  # Reference: https://en.wikipedia.org/wiki/Fenwick_tree
  type fenwick_tree*[T] = object
    n:int
    data:seq[T]
  
  # TODO
  #  using U = internal::to_unsigned_t<T>;
  
  proc init_fenwick_tree*[T](n:int):auto
    = fenwick_tree[T](n:n, data:newSeqWith(n, T(0)))
  
  proc add*[T](self: var fenwick_tree[T], p:int, x:T) =
    assert p in 0..<self.n
    var p = p + 1
    while p <= self.n:
  # TODO
  #      self.data[p - 1] += U(x)
      self.data[p - 1] += x
      p += p and -p
  proc sum*[T](self: fenwick_tree[T], r:int):T =
    var
      s = T(0)
      r = r
    while r > 0:
      s += self.data[r - 1]
      r -= r and -r
    return s
  proc sum*[T](self: fenwick_tree[T], p:Slice[int]):T =
    let (l, r) = (p.a, p.b + 1)
    assert 0 <= l and l <= r and r <= self.n
    return self.sum(r) - self.sum(l)
  
#  U sum(int r) =
#    U s = 0;
#    while (r > 0) {
#      s += data[r - 1];
#      r -= r & -r;
#    }
#    return s;
#  }

