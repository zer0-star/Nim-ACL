when not declared ATCODER_CHU_LIU_EDMONDS_HPP:
  const ATCODER_CHU_LIU_EDMONDS_HPP* = 1
  import sequtils, options, algorithm
  import atcoder/extra/graph/graph_template
  import atcoder/dsu
  import atcoder/extra/structure/skew_heap
  
  proc minimumSpanningTreeArborescence*[T](es:Edges[T], V:int, start:int):Option[(T, seq[int])] =
    proc g(a:(T,int), b:T):auto = (a[0] + b, a[1])
    proc h(a:T, b:T):auto = a + b
    var heap = initSkewHeap[(T,int), int](g, h)
    var heaps = newSeqWith(V, heap.makeheap())
    for i,e in es: heap.push(heaps[e.dst], (e.weight, i))
    var
      uf = initDSU(V)
      used = newSeqWith(V, -1)
    used[start] = start
  
    var
      ret = T(0)
      ei = newSeq[int]()
      leaf = newSeqWith(V, -1)
      cyc = 0
      ch = newSeq[int]()
      paredge = newSeq[int](es.len)
    for s in 0..<V:
      var path = newSeq[int]()
      var u = s
      while used[u] < 0:
        path.add(u)
        used[u] = s
        if heap.empty(heaps[u]): return result.T.none
        let (d, eid) = heap.top(heaps[u])
        ret += d
        heap.add(heaps[u], -d)
        heap.pop(heaps[u])
        ei.add(eid)
        if leaf[es[eid].dst] == -1: leaf[es[eid].dst] = eid
        while cyc > 0:
          paredge[ch[^1]] = eid
          discard ch.pop()
          cyc.dec
        ch.add(eid)
  
        let v = uf.leader(es[eid].src)
        if used[v] == s:
          var w:int
          var nextheap = heap.makeheap()
          while true:
            w = path.pop()
            nextheap = heap.merge(nextheap, heaps[w]);
            cyc.inc
            if uf.same(v, w): break
            else: uf.merge(v, w)
          heaps[uf.leader(v)] = nextheap
          used[uf.leader(v)] = -1
        u = uf.leader(v);
    ei.reverse()
    var
      parent = newSeqWith(V, start)
      usede = newSeqWith(es.len, false)
    for i in ei:
      if usede[i]: continue
      parent[es[i].dst]=es[i].src
      var x = leaf[es[i].dst]
      while x != i:
        usede[x] = true
        x = paredge[x]
    return (ret, parent).some
