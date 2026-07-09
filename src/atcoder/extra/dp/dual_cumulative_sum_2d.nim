when not declared ATCODER_DUAL_CUMULATIVE_SUM_2D_HPP:
  const ATCODER_DUAL_CUMULATIVE_SUM_2D_HPP* = 1

  import std/sequtils

  type DualCumulativeSum2D*[T] = object
    X, Y: int
    built: bool
    data: seq[seq[T]]

  proc init*[T](self: var DualCumulativeSum2D[T], X, Y: int) =
    self.X = X
    self.Y = Y
    self.built = false
    self.data = newSeqWith(X + 1, newSeqWith(Y + 1, T(0)))

  proc initDualCumulativeSum2D*[T](X, Y: int): DualCumulativeSum2D[T] =
    result.init(X, Y)

  proc add*[T](self: var DualCumulativeSum2D[T]; rx, ry: Slice[int], z: T) =
    assert not self.built

    let gx = min(rx.b + 1, self.X)
    let gy = min(ry.b + 1, self.Y)
    let sx = max(rx.a, 0)
    let sy = max(ry.a, 0)

    if gx < 0 or gy < 0:
      return
    if sx >= self.X or sy >= self.Y:
      return
    if sx >= gx or sy >= gy:
      return

    self.data[sx][sy] += z
    self.data[gx][sy] -= z
    self.data[sx][gy] -= z
    self.data[gx][gy] += z

  proc add*[T](self: var DualCumulativeSum2D[T]; x, y: int, z: T) =
    self.add(x .. x, y .. y, z)

  proc build*[T](self: var DualCumulativeSum2D[T]) =
    if self.built:
      return

    self.built = true

    for x in 1 ..< self.data.len:
      for y in 0 ..< self.data[x].len:
        self.data[x][y] += self.data[x - 1][y]

    for y in 1 ..< self.data[0].len:
      for x in 0 ..< self.data.len:
        self.data[x][y] += self.data[x][y - 1]

  proc `[]`*[T](self: DualCumulativeSum2D[T], x, y: int): T =
    assert self.built

    if x < 0 or y < 0:
      return T(0)
    if x >= self.X or y >= self.Y:
      return T(0)

    return self.data[x][y]

  proc write*[T](self: DualCumulativeSum2D[T]) =
    assert self.built

    for x in 0 ..< self.X:
      for y in 0 ..< self.Y:
        stdout.write(self[x, y])
      echo ""
