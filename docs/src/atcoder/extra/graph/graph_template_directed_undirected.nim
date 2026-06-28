# グラフ作るするときに最初から有向、無向グラフ指定するようにしたけど、割と不便なので採用するか考え中
when not declared ATCODER_GRAPH_TEMPLATE_HPP:
  const ATCODER_GRAPH_TEMPLATE_HPP* = 1
  import std/sequtils

  type
    UNDIRECTED = void
    DIRECTED = int
    Edge*[T; isDirected] = object
      src*,dst*:int
      weight*:T
      when isDirected is UNDIRECTED: # void: directed int: undirected
        rev*:int
    Edges*[T; directed] = seq[Edge[T, directed]]
    Graph*[T; directed] = seq[seq[Edge[T, directed]]]
    Matrix*[T] = seq[seq[T]]
  
  proc initEdge*[T; isDirected](src,dst:int,weight:T = 1,rev:int = -1):Edge[T, isDirected] =
    var e = Edge[T, isDirected](src:src, dst:dst, weight:weight)
    when isDirected is UNDIRECTED:
      e.rev = rev
    return e
  
  proc initUndirectedGraph*[T](n:int):Graph[T, void] = newSeqWith(n,newSeq[Edge[T, void]]())
  proc initDirectedGraph*[T](n:int):Graph[T, int] = newSeqWith(n,newSeq[Edge[T, int]]())

  proc addEdge*[T; isDirected](g:var Graph[T, isDirected], e:Edge[T, isDirected]):void =
    g[e.src].add(e)
    when isDirected is UNDIRECTED:
      var e_rev = e
      swap(e_rev.src, e_rev.dst)
      let (r, s) = (g[e.src].len, g[e.dst].len)
      g[e.dst].add(e_rev)
      g[e.src][^1].rev = s
      g[e.dst][^1].rev = r
  proc addEdge*[T; isDirected](g:var Graph[T, isDirected],src,dst:int,weight:T = 1):void =
    g.addEdge(initEdge[T, isDirected](src, dst, weight))
  
  proc initUndirectedGraph*[T](n:int, a,b,c:seq[T]):Graph[T, void] =
    result = initUndirectedGraph[T, void](n)
    for i in 0..<a.len: result.addEdge(a[i], b[i], c[i])
  proc initUndirectedGraph*[T](n:int, a,b:seq[T]):Graph[T, void] =
    result = initUndirectedGraph[T, void](n)
    for i in 0..<a.len: result.addEdge(a[i], b[i])
  proc initDirectedGraph*[T](n:int, a,b:seq[int],c:seq[T]):Graph[T, int] =
    result = initDirectedGraph[T](n)
    for i in 0..<a.len: result.addEdge(a[i], b[i], c[i])
  proc initDirectedGraph*[T](n:int, a,b:seq[int]):Graph[T, int] =
    result = initDirectedGraph[T](n)
    for i in 0..<a.len: result.addEdge(a[i], b[i])

#  proc addEdge*[T;directed](g:var Graph[T, directed],e:Edge[T, directed]):void =
#    g[e.src].add(e)
#  proc addEdge*[T;directed](g:var Graph[T, directed],src,dst:int,weight:T = T(1)):void =
#    g.addEdge(initEdge[T, directed](src, dst, weight, -1))
  
  proc `<`*[T; isDirected](l,r:Edge[T, isDirected]):bool = l.weight < r.weight


var g = initDirectedGraph[int](10)
g.addEdge(0, 2, 3)
g.addEdge(0, 3, 2)
var g2 = initUnDirectedGraph[int](10)
g2.addEdge(0, 2)
g2.addEdge(2, 3)
