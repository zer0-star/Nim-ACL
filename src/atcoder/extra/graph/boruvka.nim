when not declared ATCODER_BORUVKA_HPP:
  const ATCODER_BORUVKA_HPP* = 1
  import atcoder/dsu
  import sequtils

  type Boruvka*[T] = object
    V:int
    inf:T
    uf:DSU

  proc initBoruvka*[T](V:int, inf = -1):Boruvka[T] =
    let inf = if inf == -1: T.inf else: inf
    Boruvka[T](V:V, inf:inf, uf:initDSU(V))

  proc find*[T](self:Boruvka[T], k:int):int = self.uf.leader(k)

  proc build*[T](self:Boruvka[T], update:proc(ret:var seq[(int,int)])):T =
    result = T(0)
    while self.uf.size(0) < self.V:
      var v = newSeqWith(self.V, (self.inf, -1))
      update(v)
      var con = false
      for i in 0..<self.V:
        if v[i][1] >= 0 and not self.uf.same(i, v[i][1]):
          self.uf.merge(i, v[i][1])
          result += v[i][0]
          con = true
      if not con: return self.inf
