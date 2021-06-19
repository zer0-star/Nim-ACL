when not declared ATCODER_GRAPH_TEMPLATE_HPP:
  const ATCODER_GRAPH_TEMPLATE_HPP* = 1
  import std/sequtils
  
  type TRUE = int
  type FALSE = void
  type
#    Edge*[T] = ref object
    Edge*[T, U] = object
      src*,dst*:U
      weight*:T
      rev*:int
    Edges*[T, U] = seq[Edge[T, U]]
    Graph*[T, U, useSeq] = object
      len*:int
      when useSeq isnot void:
        adj*: seq[seq[Edge[T, U]]]
      else:
        adj*: proc(u:U):seq[tuple[dst:U, weight:T]]
      when U isnot int:
        id*:proc(u:U):int
    Matrix*[T] = seq[seq[T]]

  proc initEdge*[T, U](src,dst:U,weight:T = 1,rev:int = -1):Edge[T, U] =
    return Edge[T, U](src:src, dst:dst, weight:weight, rev:rev)
  proc `<`*[T, U](a, b:Edge[T, U]):bool = a.weight < b.weight
  
  proc initGraph*(n:int, T:typedesc = int, U:typedesc = int):Graph[T, U, TRUE] =
    return Graph[T, int, TRUE](len:n, adj:newSeqWith(n, newSeq[Edge[T, U]]()))
  proc initGraph*[T, U](n:int, id:proc(u:U):int):Graph[T, U, TRUE] =
    return Graph[T, U, TRUE](len:n, adj:newSeqWith(n,newSeq[Edge[T, U]]()), id:id)
  proc initGraphProc*[T, U](n:int, id:proc(u:U):int, adj:proc(u:U):seq[(U, T)]):Graph[T, U, FALSE] =
    return Graph[T, U, FALSE](len:n, adj:adj, id:id)

  template `[]`*[G:Graph](g:G, u:G.U):auto =
    when G.useSeq is TRUE:
      when u is int: g.adj[u]
      else: g.adj[g.id(u)]
    else:
      g.adj(u)

  proc addBiEdge*[T, U](g:var Graph[T, U, TRUE],e:Edge[T, U]):void =
#    var e_rev = initEdge[T](e.src, e.dst, e.weight, e.rev)
    var e_rev = e
    swap(e_rev.src, e_rev.dst)
    let (r, s) = (g[e.src].len, g[e.dst].len)
    g[e.src].add(e)
    g[e.dst].add(e_rev)
    g[e.src][^1].rev = s
    g[e.dst][^1].rev = r

  proc addBiEdge*[T, U](g:var Graph[T, U, TRUE],src,dst:U,weight:T = 1):void =
    g.addBiEdge(initEdge(src, dst, weight))

  proc addEdge*[T, U](g:var Graph[T, U, TRUE], e:Edge[T, U]) = g[e.src].add(e)
  proc addEdge*[T, U](g:var Graph[T, U, TRUE], src, dst:U, weight:T = 1):void =
    g.addEdge(initEdge[T, U](src, dst, weight, -1))

  proc initUndirectedGraph*[T, U](n:int, a,b:seq[U], c:seq[T]):Graph[T, U, TRUE] =
    result = initGraph[T](n, U)
    for i in 0..<a.len: result.addBiEdge(a[i], b[i], c[i])
  proc initUndirectedGraph*[U](n:int, a,b:seq[U]):Graph[int, U, TRUE] =
    result = initGraph[int](n, U)
    for i in 0..<a.len: result.addBiEdge(a[i], b[i])
  proc initDirectedGraph*[T, U](n:int, a,b:seq[U],c:seq[T]):Graph[T, U, TRUE] =
    result = initGraph[T](n, U)
    for i in 0..<a.len: result.addEdge(a[i], b[i], c[i])
  proc initDirectedGraph*[U](n:int, a,b:seq[U]):Graph[int, U, TRUE] =
    result = initGraph[int](n, U)
    for i in 0..<a.len: result.addEdge(a[i], b[i])

  template id*[G:Graph](g:G, u:int):int = 
    when G.U is int: u
    else: g.id(u)
