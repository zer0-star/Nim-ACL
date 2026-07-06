# multi_dimensional_dijkustra {{{
when not declared ATCODER_DIJKSTRA_MULTI_DIMENSIONAL:
  const ATCODER_DIJKSTRA_MULTI_DIMENSIONAL* = 1

  import atcoder/extra/structure/internal_heapqueue
  import std/strformat, std/macros

  macro TupleSeq*(lens: tuple; init):untyped =
    var a = fmt"{init.repr}"
    for i in countdown(lens.len - 1, 0): a = fmt"newSeqWith({lens.repr}[{i.repr}], {a})"
    parseStmt(a)

  macro `[]`(a: untyped, p: tuple): untyped =
    var strBody = fmt"{a.repr}"
    for i, _ in p.getTypeImpl: strBody &= fmt"[{p.repr}[{i}]]"
    parseStmt(strBody)
  macro `[]=`(a: untyped, p: tuple, x: untyped): untyped =
    var strBody = fmt"{a.repr}"
    for i, _ in p.getTypeImpl: strBody &= fmt"[{p.repr}[{i}]]"
    strBody &= fmt" = {x.repr}"
    parseStmt(strBody)

  type GraphIterativeC = concept g, type G
    type W = G.Weight
    type P = G.P
    var x:P
    for p in adj(g, 1, x):
      discard

  type HasDim = concept g
    g.dim

  proc dijkstra*[G:GraphIterativeC](g:G, s:g.P or openArray[g.P], limit = G.Weight.inf):auto =
    when g is HasDim:
      const UseArray = true
    else:
      const UseArray = false
    type P = g.P
    type Weight = g.Weight

    type DP = object
      d:int
      p:P

    proc heapCmp(a, b:DP):bool = a.d < b.d

    when UseArray:
      var
        vis = TupleSeq(g.dim, false)
        dist = TupleSeq(g.dim, limit)
    else:
      var
        vis = initSet[P]()
        dist = initTable[P, Weight]()

    var Q = initHeapQueue(heapCmp)

    proc set_push(d:int, p:P) =
      when UseArray:
        if vis[p]: return
      else:
        if p in vis: return
        if p notin dist: dist[p] = limit
      if dist[p] <= d: return
      dist[p] = d
      Q.push(DP(d:d, p:p))

    when s isnot openArray:
      let s = [s]

    # initial
    for p in s:
      set_push(0, p)

    # iteration
    while Q.len > 0:
      let dp = Q.pop()
      let (d, p) = (dp.d, dp.p)
      when UseArray:
        if vis[p]: continue
        vis[p] = true
      else:
        if p in vis: continue
        vis.incl p
      for dp2 in g.adj(d, p):
        let (d2, p2) = dp2
        set_push(d2, p2)

    return dist
# }}}


