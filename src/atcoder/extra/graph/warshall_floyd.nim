when not declared ATCODER_WARSHALL_FLOYD_HPP:
  const ATCODER_WARSHALL_FLOYD_HPP* = 1
  import std/sequtils
  type WarshallFloydType*[T] = object
    dist:seq[seq[T]]
    inter:seq[seq[int]]
  proc warshallFloyd*[T](dist: seq[seq[T]]): WarshallFloydType[T] =
    let N = dist.len
    var dist = dist
    var inter = newSeqWith(N, newSeqWith(N, -1))
    for k in 0..<N:
      for i in 0..<N:
        for j in 0..<N:
          if dist[i][k] == T.inf or dist[k][j] == T.inf: continue
          let d = dist[i][k] + dist[k][j]
          if dist[i][j] > d:
            dist[i][j] = d
            inter[i][j] = k
    result.dist = dist
    result.inter = inter

  proc path*[T](self: WarshallFloydType[T], s, t:int):seq[int] =
    var path = newSeq[int]()
    proc buildPath(s, t:int) =
      let u = self.inter[s][t]
      if u < 0: path.add(s)
      else: buildPath(s, u);buildPath(u, t)
    buildPath(s, t)
    path.add(t)
    return path

  proc `[]`*[T](self: WarshallFloydType[T], u:int):seq[T] = self.dist[u]
  proc `[]`*[T](self: WarshallFloydType[T], s, t:int):T = self.dist[s][t]
