when not declared ATCODER_GRAPH_TEMPLATE_HPP:
  const ATCODER_GRAPH_TEMPLATE_HPP* = 1
  import std/sequtils
  
  type
    Edge*[T] = object
      src*,dst*:int
      weight*:T
      rev*:int
    Edges*[T] = seq[Edge[T]]
    Graph*[T] = seq[seq[Edge[T]]]
    Matrix*[T] = seq[seq[T]]
  
  proc initEdge*[T](src,dst:int,weight:T = 1,rev:int = -1):Edge[T] =
    var e:Edge[T]
    e.src = src
    e.dst = dst
    e.weight = weight
    e.rev = rev
    return e
  
  proc initGraph*[T](n:int):Graph[T] =
    return newSeqWith(n,newSeq[Edge[T]]())
  
  proc addBiEdge*[T](g:var Graph[T],e:Edge[T]):void =
    var e_rev = e
    swap(e_rev.src, e_rev.dst)
    let (r, s) = (g[e.src].len, g[e.dst].len)
    g[e.src].add(e)
    g[e.dst].add(e_rev)
    g[e.src][^1].rev = s
    g[e.dst][^1].rev = r
  proc addBiEdge*[T](g:var Graph[T],src,dst:int,weight:T = 1):void =
    g.addBiEdge(initEdge(src, dst, weight))
  
  proc initUndirectedGraph*[T](n:int, a,b,c:seq[T]):Graph[T] =
    result = initGraph[T](n)
    for i in 0..<a.len: result.addBiEdge(a[i], b[i], c[i])
  proc initUndirectedGraph*[T](n:int, a,b:seq[T]):Graph[T] =
    result = initGraph[T](n)
    for i in 0..<a.len: result.addBiEdge(a[i], b[i])
  proc initGraph*[T](n:int, a,b:seq[int],c:seq[T]):Graph[T] =
    result = initGraph[T](n)
    for i in 0..<a.len: result.addEdge(a[i], b[i], c[i])
  proc initGraph*[T](n:int, a,b:seq[int]):Graph[T] =
    result = initGraph[T](n)
    for i in 0..<a.len: result.addEdge(a[i], b[i])

  proc addEdge*[T](g:var Graph[T],e:Edge[T]):void =
    g[e.src].add(e)
  proc addEdge*[T](g:var Graph[T],src,dst:int,weight:T = T(1)):void =
    g.addEdge(initEdge(src, dst, weight, -1))
  
  proc `<`*[T](l,r:Edge[T]):bool = l.weight < r.weight
