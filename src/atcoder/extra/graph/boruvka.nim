when not declared ATCODER_BORUVKA_HPP:
  const ATCODER_BORUVKA_HPP* = 1

  import std/sequtils
  import atcoder/dsu
  import atcoder/extra/other/inf

  type Boruvka*[T] = object
    V*: int
    inf*: T
    uf: DSU

  proc initBoruvka*[T](V: int, inf: T = T.inf): Boruvka[T] =
    Boruvka[T](V: V, inf: inf, uf: initDSU(V))

  proc find*[T](self: Boruvka[T], k: int): int =
    self.uf.leader(k)

  proc build*[T](self: Boruvka[T], update: proc(ret: var seq[(T, int)])): T =
    ## Runs Boruvka's algorithm.
    ##
    ## `update(best)` must set `best[leader]` to `(cost, otherLeader)` for each
    ## current component leader. If the graph is disconnected, `self.inf` is
    ## returned.
    result = T(0)
    var componentCount = self.V

    while componentCount > 1:
      var best = newSeqWith(self.V, (self.inf, -1))
      update(best)

      var merged = false

      for i in 0 ..< self.V:
        let j = best[i][1]
        if j < 0:
          continue

        let a = self.uf.leader(i)
        let b = self.uf.leader(j)

        if a == b:
          continue

        discard self.uf.merge(a, b)
        result += best[i][0]
        dec componentCount
        merged = true

      if not merged:
        return self.inf
