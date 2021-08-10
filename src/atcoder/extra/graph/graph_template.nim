when not declared ATCODER_GRAPH_TEMPLATE_HPP:
  const ATCODER_GRAPH_TEMPLATE_HPP* = 1
  import std/sequtils
  
  type ADJTYPE_SEQ = void
  type ADJTYPE_PROC = int8
  type ADJTYPE_ITER = int16
  type
#    Edge*[T] = ref object
    Edge*[T, U] = object
      src*,dst*:U
      weight*:T
      rev*:int
    Edges*[T, U] = seq[Edge[T, U]]
    Graph*[T, U, adjType] = object
      len*:int
      when adjType is ADJTYPE_SEQ:
        adj*: seq[seq[Edge[T, U]]]
      elif adjType is ADJTYPE_ITER:
        adj_iter*: iterator(u:U):tuple[dst:U, weight:T]
      elif adjType is ADJTYPE_PROC:
        adj*: proc(u:U):seq[tuple[dst:U, weight:T]]
      else:
        discard
      when U isnot int:
        id*:proc(u:U):int
    Matrix*[T] = seq[seq[T]]

  proc initEdge*[T, U](src,dst:U,weight:T = 1,rev:int = -1):Edge[T, U] =
    return Edge[T, U](src:src, dst:dst, weight:weight, rev:rev)
  proc `<`*[T, U](a, b:Edge[T, U]):bool = a.weight < b.weight
  
  proc initGraph*(n:int, T:typedesc = int, U:typedesc = int):Graph[T, U, ADJTYPE_SEQ] =
    return Graph[T, int, ADJTYPE_SEQ](len:n, adj:newSeqWith(n, newSeq[Edge[T, U]]()))
  proc initGraph*[U](n:int, id:proc(u:U):int, T:typedesc = int):Graph[T, U, ADJTYPE_SEQ] =
    return Graph[T, U, ADJTYPE_SEQ](len:n, adj:newSeqWith(n,newSeq[Edge[T, U]]()), id:id)
  proc initGraph*[T, U](n:int, id:proc(u:U):int, adj:proc(u:U):seq[(U, T)]):Graph[T, U, ADJTYPE_PROC] =
    return Graph[T, U, ADJTYPE_PROC](len:n, adj:adj, id:id)
  proc initGraph*[T, U](n:int, id:proc(u:U):int, adj_iter:iterator(u:U):(U, T)):Graph[T, U, ADJTYPE_ITER] =
    return Graph[T, U, ADJTYPE_ITER](len:n, adj_iter:adj_iter, id:id)

  template `[]`*[G:Graph](g:G, u:G.U):auto =
    when G.adjType is ADJTYPE_SEQ:
      when u is int: g.adj[u]
      else: g.adj[g.id(u)]
    else:
      g.adj(u)

  proc addBiEdge*[T, U](g:var Graph[T, U, ADJTYPE_SEQ],e:Edge[T, U]):void =
#    var e_rev = initEdge[T](e.src, e.dst, e.weight, e.rev)
    var e_rev = e
    swap(e_rev.src, e_rev.dst)
    let (r, s) = (g[e.src].len, g[e.dst].len)
    g[e.src].add(e)
    g[e.dst].add(e_rev)
    g[e.src][^1].rev = s
    g[e.dst][^1].rev = r

  proc addBiEdge*[T, U](g:var Graph[T, U, ADJTYPE_SEQ],src,dst:U,weight:T = 1):void =
    g.addBiEdge(initEdge(src, dst, weight))

  proc addEdge*[T, U](g:var Graph[T, U, ADJTYPE_SEQ], e:Edge[T, U]) = g[e.src].add(e)
  proc addEdge*[T, U](g:var Graph[T, U, ADJTYPE_SEQ], src, dst:U, weight:T = 1):void =
    g.addEdge(initEdge[T, U](src, dst, weight, -1))

  proc initUndirectedGraph*[T, U](n:int, a,b:seq[U], c:seq[T]):Graph[T, U, ADJTYPE_SEQ] =
    result = initGraph[T](n, U)
    for i in 0..<a.len: result.addBiEdge(a[i], b[i], c[i])
  proc initUndirectedGraph*[U](n:int, a,b:seq[U]):Graph[int, U, ADJTYPE_SEQ] =
    result = initGraph[int](n, U)
    for i in 0..<a.len: result.addBiEdge(a[i], b[i])
  proc initDirectedGraph*[T, U](n:int, a,b:seq[U],c:seq[T]):Graph[T, U, ADJTYPE_SEQ] =
    result = initGraph[T](n, U)
    for i in 0..<a.len: result.addEdge(a[i], b[i], c[i])
  proc initDirectedGraph*[U](n:int, a,b:seq[U]):Graph[int, U, ADJTYPE_SEQ] =
    result = initGraph[int](n, U)
    for i in 0..<a.len: result.addEdge(a[i], b[i])

  template id*[G:Graph](g:G, u:int):int = 
    when G.U is int: u
    else: g.id(u)

  iterator adj*[T, U](g:Graph[T, U, ADJTYPE_ITER], u:U):tuple[dst:U, weight:T] =
    var iter:type(g.adj_iter)
    iter.deepCopy(g.adj_iter)
    for e in iter(u):
      yield e

  iterator adj_by_id*[G:Graph](g:G, u:int):auto =
    when G.adjType is ADJTYPE_SEQ:
      for e in g.adj[u]: yield e
    else:
      for e in g.adj(u): yield e
