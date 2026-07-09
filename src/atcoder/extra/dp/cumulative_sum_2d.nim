when not declared ATCODER_CUMULATIVE_SUM_2D_HPP:
  const ATCODER_CUMULATIVE_SUM_2D_HPP* = 1

  import std/sequtils

  type CumulativeSum2D*[T] = object
    built: bool
    data: seq[seq[T]]

  proc initCumulativeSum2D*[T](W, H: int): CumulativeSum2D[T] =
    CumulativeSum2D[T](
      built: false,
      data: newSeqWith(W + 1, newSeqWith(H + 1, T(0)))
    )

  proc initCumulativeSum2D*[T](data: seq[seq[T]]): CumulativeSum2D[T] =
    let W = data.len
    let H = if W == 0: 0 else: data[0].len

    result = initCumulativeSum2D[T](W, H)

    for x in 0 ..< data.len:
      assert data[x].len == H
      for y in 0 ..< data[x].len:
        result.add(x, y, data[x][y])

    result.build()

  proc add*[T](self: var CumulativeSum2D[T]; x, y: int, z: T) =
    assert not self.built
    let nx = x + 1
    let ny = y + 1

    if nx <= 0 or ny <= 0:
      return
    if nx >= self.data.len or ny >= self.data[0].len:
      return

    self.data[nx][ny] += z

  proc build*[T](self: var CumulativeSum2D[T]) =
    if self.built:
      return

    self.built = true

    for x in 1 ..< self.data.len:
      for y in 1 ..< self.data[x].len:
        self.data[x][y] += self.data[x][y - 1] + self.data[x - 1][y] - self.data[x - 1][y - 1]

  proc `[]`*[T](self: CumulativeSum2D[T], rx, ry: Slice[int]): T =
    assert self.built

    let gx = rx.b + 1
    let gy = ry.b + 1
    let sx = rx.a
    let sy = ry.a

    return self.data[gx][gy] - self.data[sx][gy] - self.data[gx][sy] + self.data[sx][sy]
