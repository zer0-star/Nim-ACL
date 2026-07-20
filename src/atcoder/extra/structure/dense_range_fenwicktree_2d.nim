when not declared ATCODER_EXTRA_STRUCTURE_DENSE_RANGE_FENWICKTREE_2D_HPP:
  const ATCODER_EXTRA_STRUCTURE_DENSE_RANGE_FENWICKTREE_2D_HPP = 1

  import atcoder/extra/structure/dense_fenwicktree_2d

  type
    DenseRangeFenwickTree2D*[T] = object
      heightValue, widthValue: int
      b00, b10, b01, b11: DenseFenwickTree2D[T]

  proc initDenseRangeFenwickTree2D*[T](
      height, width: int,
  ): DenseRangeFenwickTree2D[T] =
    assert height >= 0
    assert width >= 0
    result.heightValue = height
    result.widthValue = width
    result.b00 = initDenseFenwickTree2D[T](width, height)
    result.b10 = initDenseFenwickTree2D[T](width, height)
    result.b01 = initDenseFenwickTree2D[T](width, height)
    result.b11 = initDenseFenwickTree2D[T](width, height)

  proc addCorner[T](
      self: var DenseRangeFenwickTree2D[T],
      y, x: int,
      delta: T,
  ) =
    mixin `*`
    assert 0 <= y and y <= self.heightValue
    assert 0 <= x and x <= self.widthValue
    if y == self.heightValue or x == self.widthValue:
      return
    let ty = T(y)
    let tx = T(x)
    self.b00.add(x, y, delta)
    self.b10.add(x, y, delta * ty)
    self.b01.add(x, y, delta * tx)
    self.b11.add(x, y, delta * ty * tx)

  proc prefixSum[T](
      self: DenseRangeFenwickTree2D[T],
      yRight, xRight: int,
  ): T =
    mixin `+`, `-`, `*`
    assert 0 <= yRight and yRight <= self.heightValue
    assert 0 <= xRight and xRight <= self.widthValue
    let ty = T(yRight)
    let tx = T(xRight)
    let q00 = self.b00.prefixSum(xRight, yRight)
    let q10 = self.b10.prefixSum(xRight, yRight)
    let q01 = self.b01.prefixSum(xRight, yRight)
    let q11 = self.b11.prefixSum(xRight, yRight)
    result = ty * tx * q00 - tx * q10 - ty * q01 + q11

  proc add*[T](
      self: var DenseRangeFenwickTree2D[T],
      y1, y2, x1, x2: int,
      delta: T,
  ) =
    mixin `-`
    assert 0 <= y1 and y1 <= y2 and y2 <= self.heightValue
    assert 0 <= x1 and x1 <= x2 and x2 <= self.widthValue
    if y1 == y2 or x1 == x2:
      return
    self.addCorner(y1, x1, delta)
    self.addCorner(y1, x2, -delta)
    self.addCorner(y2, x1, -delta)
    self.addCorner(y2, x2, delta)

  proc sum*[T](
      self: DenseRangeFenwickTree2D[T],
      y1, y2, x1, x2: int,
  ): T =
    mixin `+`, `-`
    assert 0 <= y1 and y1 <= y2 and y2 <= self.heightValue
    assert 0 <= x1 and x1 <= x2 and x2 <= self.widthValue
    if y1 == y2 or x1 == x2:
      return T(0)
    result =
      self.prefixSum(y2, x2) -
      self.prefixSum(y1, x2) -
      self.prefixSum(y2, x1) +
      self.prefixSum(y1, x1)

  proc get*[T](
      self: DenseRangeFenwickTree2D[T],
      y, x: int,
  ): T {.inline.} =
    assert 0 <= y and y < self.heightValue
    assert 0 <= x and x < self.widthValue
    self.sum(y, y + 1, x, x + 1)
