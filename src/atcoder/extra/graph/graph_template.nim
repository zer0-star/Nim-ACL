when not declared ATCODER_GRAPH_TEMPLATE_HPP:
  const ATCODER_GRAPH_TEMPLATE_HPP* = 1
  import std/sequtils, std/tables

  type
    ADJTYPE_SEQ* = object
    ADJTYPE_TABLE* = object
    ADJTYPE_PROC* = object
    ADJTYPE_ITER* = object
    USEID_TRUE* = object
    USEID_FALSE* = object
#    Edge*[T] = ref object
    Edge*[T, U] = object
      src*,dst*:U
      weight*:T
      rev*:int
    Edges*[T, U] = seq[Edge[T, U]]
    Graph*[T, U, adjType, useId] = object
      len*:int
      when adjType is ADJTYPE_SEQ:
        adj*: seq[seq[Edge[T, U]]]
      elif adjType is ADJTYPE_TABLE:
        adj*: Table[U, seq[Edge[T, U]]]
      elif adjType is ADJTYPE_ITER:
        adj_iter*: iterator(u:U):tuple[dst:U, weight:T]
      elif adjType is ADJTYPE_PROC:
        adj*: proc(u:U):seq[tuple[dst:U, weight:T]]
      else:
        discard
      when useId is USEID_TRUE:
        id*:proc(u:U):int
    Matrix*[T] = seq[seq[T]]

  proc initEdge*[T, U](src,dst:U,weight:T = 1,rev:int = -1):Edge[T, U] =
    return Edge[T, U](src:src, dst:dst, weight:weight, rev:rev)
  proc `<`*[T, U](a, b:Edge[T, U]):bool = a.weight < b.weight
  
  proc initGraph*(n:int, T:typedesc = int, U:typedesc[int] = int):Graph[T, U, ADJTYPE_SEQ, USEID_FALSE] =
    return Graph[T, int, ADJTYPE_SEQ, USEID_FALSE](len:n, adj:newSeqWith(n, newSeq[Edge[T, U]]()))
  proc initGraph*(T:typedesc = int, U:typedesc = int):Graph[T, U, ADJTYPE_TABLE, USEID_FALSE] =
    return Graph[T, U, ADJTYPE_TABLE, USEID_FALSE](len: 0, adj:initTable[U, seq[Edge[T, U]]]())

  proc initGraph*[U](n:int, id:proc(u:U):int, T:typedesc = int):Graph[T, U, ADJTYPE_SEQ, USEID_TRUE] =
    return Graph[T, U, ADJTYPE_SEQ, USEID_TRUE](len:n, adj:newSeqWith(n,newSeq[Edge[T, U]]()), id:id)
  proc initGraph*[T, U](n:int, id:proc(u:U):int, adj:proc(u:U):seq[(U, T)]):Graph[T, U, ADJTYPE_PROC, USEID_TRUE] =
    return Graph[T, U, ADJTYPE_PROC, USEID_TRUE](len:n, adj:adj, id:id)
  proc initGraph*[T, U](n:int, id:proc(u:U):int, adj_iter:iterator(u:U):(U, T)):Graph[T, U, ADJTYPE_ITER, USEID_TRUE] =
    return Graph[T, U, ADJTYPE_ITER, USEID_TRUE](len:n, adj_iter:adj_iter, id:id)
  proc initGraph*[T, U](adj:proc(u:U):seq[(U, T)]):auto =
    return Graph[T, U, ADJTYPE_PROC, USEID_FALSE](len:0, adj:adj)
  proc initGraph*[T, U](adj_iter:iterator(u:U):(U, T)):auto =
    return Graph[T, U, ADJTYPE_ITER, USEID_FALSE](len:0, adj_iter:adj_iter)

  template `[]`*[G:Graph](g:G, u:G.U):auto =
    when G.adjType is ADJTYPE_SEQ:
      when u is int: g.adj[u]
      else: g.adj[g.id(u)]
    elif G.adjType is ADJTYPE_TABLE:
      if u notin g.adj:
        g.adj[u] = newSeq[Edge[G.T, G.U]]()
      g.adj[u]
    else:
      g.adj(u)

  proc addBiEdge*[T, U, adjType, useId](g:var Graph[T, U, adjType, useId], e:Edge[T, U]):void =
    when adjType is ADJTYPE_SEQ | ADJTYPE_TABLE:
#    var e_rev = initEdge[T](e.src, e.dst, e.weight, e.rev)
      var e_rev = e
      swap(e_rev.src, e_rev.dst)
      let (r, s) = (g[e.src].len, g[e.dst].len)
      g[e.src].add(e)
      g[e.dst].add(e_rev)
      g[e.src][^1].rev = s
      g[e.dst][^1].rev = r
    else:
      static_assert false

  proc addBiEdge*[T, U, adjType, useId](g:var Graph[T, U, adjType, useId],src,dst:U,weight:T = 1):void =
    g.addBiEdge(initEdge(src, dst, weight))

  proc addEdge*[T, U, adjType, useId](g:var Graph[T, U, adjType, useId], e:Edge[T, U]) = g[e.src].add(e)
  proc addEdge*[T, U, adjType, useId](g:var Graph[T, U, adjType, useId], src, dst:U, weight:T = 1):void =
    g.addEdge(initEdge[T, U](src, dst, weight, -1))

  proc initUndirectedGraph*[T, U](n:int, a,b:seq[U], c:seq[T]):Graph[T, U, ADJTYPE_SEQ, USEID_FALSE] =
    result = initGraph[T](n, U)
    for i in 0..<a.len: result.addBiEdge(a[i], b[i], c[i])
  proc initUndirectedGraph*[U](n:int, a,b:seq[U]):Graph[int, U, ADJTYPE_SEQ, USEID_FALSE] =
    result = initGraph[int](n, U)
    for i in 0..<a.len: result.addBiEdge(a[i], b[i])
  proc initDirectedGraph*[T, U](n:int, a,b:seq[U],c:seq[T]):Graph[T, U, ADJTYPE_SEQ, USEID_FALSE] =
    result = initGraph[T](n, U)
    for i in 0..<a.len: result.addEdge(a[i], b[i], c[i])
  proc initDirectedGraph*[U](n:int, a,b:seq[U]):Graph[int, U, ADJTYPE_SEQ, USEID_FALSE] =
    result = initGraph[int](n, U)
    for i in 0..<a.len: result.addEdge(a[i], b[i])

  template id*[G:Graph](g:G, u:int):int = 
    when G.U is int: u
    else: g.id(u)

  iterator adj*[T, U, useID](g:Graph[T, U, ADJTYPE_ITER, useID], u:U):tuple[dst:U, weight:T] =
    var iter:type(g.adj_iter)
    iter.deepCopy(g.adj_iter)
    for e in iter(u):
      yield e

  iterator adj_by_id*[G:Graph](g:G, u:int):auto =
    when G.adjType is ADJTYPE_SEQ:
      for e in g.adj[u]: yield e
    else:
      for e in g.adj(u): yield e

  type NodeArray*[U, VAL, useId] = object
    default_val:VAL
    when useId is USEID_TRUE:
      id*: proc(u:U):int
    when useId is USEID_TRUE or U is int:
      v:seq[VAL]
    else:
      v:Table[U, VAL]

  proc initNodeArray*[VAL](g:Graph, default_val:VAL, len = 0):auto =
    result = NodeArray[g.U, VAL, g.useId](default_val:default_val)
    when g.useId is USEID_TRUE or g.U is int:
      if len > 0:
        result.v = newSeqWith(len, default_val)
    when g.useId is USEID_TRUE:
      result.id = g.id

  proc `[]`*[U, useId, VAL](a:var NodeArray[U, VAL, useId], u:U):ptr[VAL] =
    when useId is USEID_TRUE or U is int:
      when U is int:
        var i = u
      else:
        var i = a.id(u)
      while i >= a.v.len:
        a.v.add a.default_val
      a.v[i].addr
    else:
      if u notin a.v:
        (a.v)[u] = a.default_val
      a.v[u].addr
