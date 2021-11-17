import sequtils

# DualCumulativeSum2D(imos) {{{
type DualCumulativeSum2D*[T] = object
  X, Y:int
  built: bool
  data: seq[seq[T]]

proc init*[T](self:var DualCumulativeSum2D[T], X, Y:int) =
  self.X = X
  self.Y = Y
  self.built = false
  if self.data.len < X + 1 or self.data[0].len < Y + 1:
    self.data = newSeqWith(X + 1, newSeqWith(Y + 1, T(0)))
  else:
    for x in 0..<X+1:
      for y in 0..<Y+1:
        self.data[x][y] = T(0)

proc initDualCumulativeSum2D*[T](X, Y:int):DualCumulativeSum2D[T] =
  result.init(X, Y)

#proc initDualCumulativeSum2D[T](data:seq[seq[T]]):CumulativeSum2D[T] =
#  result = initCumulativeSum2D[T](data.len, data[0].len)
#  for i in 0..<data.len:
#    for j in 0..<data[i].len:
#      result.add(i,j,data[i][j])
#  result.build()

proc add*[T](self:var DualCumulativeSum2D[T]; rx, ry: Slice[int], z:T) =
  assert not self.built
  let (gx, gy) = (rx.b + 1, ry.b + 1)
  let (sx, sy) = (rx.a, ry.a)
  self.data[gx][gy] += z
  self.data[sx][gy] -= z
  self.data[gx][sy] -= z
  self.data[sx][sy] += z

proc build*[T](self:var DualCumulativeSum2D[T]) =
  self.built = true
  for i in 1..<self.data.len:
    for j in 0..<self.data[0].len:
      self.data[i][j] += self.data[i - 1][j]
  for j in 1..<self.data[0].len:
    for i in 0..<self.data.len:
      self.data[i][j] += self.data[i][j - 1]

proc `[]`*[T](self: DualCumulativeSum2D[T], x:int, y:int):T =
  assert(self.built)
#  let (x, y) = (x + 1, y + 1)
  if x >= self.data.len or y >= self.data[0].len: return T(0)
  return self.data[x][y]

proc write*[T](self: DualCumulativeSum2D[T]) =
  assert(self.built)
  for i in 0..<self.X:
    for j in 0..<self.Y:
      stdout.write(self[i,j])
    echo ""
#}}}
