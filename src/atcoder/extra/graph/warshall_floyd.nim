when not declared ATCODER_WARSHALL_FLOYD_HPP:
  const ATCODER_WARSHALL_FLOYD_HPP* = 1
  proc warshallFloyd*[T](dist: seq[seq[T]]): seq[seq[T]] =
    let N = dist.len
    var dist = dist
    for k in 0..<N:
      for i in 0..<N:
        for j in 0..<N:
          if dist[i][k] == T.inf or dist[k][j] == T.inf: continue
          let d = dist[i][k] + dist[k][j]
          if dist[i][j] > d: dist[i][j] = d
    return dist
