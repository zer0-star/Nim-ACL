when not declared ATCODER_CUMULATIVE_SUM_2D_HPP:
  const ATCODER_CUMULATIVE_SUM_2D_HPP* = 1
  import std/sequtils
  
  type CumulativeSum2D*[T] = object
    built: bool
    data: seq[seq[T]]
  
  proc initCumulativeSum2D*[T](W, H:int):CumulativeSum2D[T] = CumulativeSum2D[T](data: newSeqWith(W + 1, newSeqWith(H + 1, T(0))), built:false)
  proc initCumulativeSum2D*[T](data:seq[seq[T]]):CumulativeSum2D[T] =
    result = initCumulativeSum2D[T](data.len, data[0].len)
    for i in 0..<data.len:
      for j in 0..<data[i].len:
        result.add(i,j,data[i][j])
    result.build()
  
  proc add*[T](self:var CumulativeSum2D[T]; x, y:int, z:T) =
    let (x, y) = (x + 1, y + 1)
    if x >= self.data.len or y >= self.data[0].len: return
    self.data[x][y] += z
  
  proc build*[T](self:var CumulativeSum2D[T]) =
    self.built = true
    for i in 1..<self.data.len:
      for j in 1..<self.data[i].len:
        self.data[i][j] += self.data[i][j - 1] + self.data[i - 1][j] - self.data[i - 1][j - 1]
  
  proc `[]`*[T](self: CumulativeSum2D[T], rx, ry:Slice[int]):T =
    assert(self.built)
    let (gx, gy) = (rx.b+1, ry.b+1)
    let (sx, sy) = (rx.a, ry.a)
    return self.data[gx][gy] - self.data[sx][gy] - self.data[gx][sy] + self.data[sx][sy]
