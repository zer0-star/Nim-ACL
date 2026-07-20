when not declared ATCODER_DUAL_CUMULATIVE_SUM_2D_HPP:
  const ATCODER_DUAL_CUMULATIVE_SUM_2D_HPP* = 1

  import std/sequtils

  type
    DualCumulativeSum2D*[T] = object
      heightValue: int
      widthValue: int
      built: bool
      data: seq[seq[T]]

  proc init*[T](
      self: var DualCumulativeSum2D[T],
      height,
      width: int,
  ) =
    ## Initializes an H x W row-major difference grid.

    assert height >= 0
    assert width >= 0

    self.heightValue = height
    self.widthValue = width
    self.built = false

    self.data = newSeqWith(
      height + 1,
      newSeqWith(
        width + 1,
        T(0),
      ),
    )

  proc initDualCumulativeSum2D*[T](
      height,
      width: int,
  ): DualCumulativeSum2D[T] =
    result.init(
      height,
      width,
    )

  proc add*[T](
      self: var DualCumulativeSum2D[T],
      rowRange,
      colRange: Slice[int],
      value: T,
  ) =
    ## Adds value to the inclusive rectangle
    ## rowRange x colRange, clipped to the grid.

    assert not self.built

    let
      rowEnd =
        min(
          rowRange.b + 1,
          self.heightValue,
        )
      colEnd =
        min(
          colRange.b + 1,
          self.widthValue,
        )
      rowBegin =
        max(
          rowRange.a,
          0,
        )
      colBegin =
        max(
          colRange.a,
          0,
        )

    if rowEnd < 0 or colEnd < 0:
      return

    if rowBegin >= self.heightValue or
        colBegin >= self.widthValue:
      return

    if rowBegin >= rowEnd or
        colBegin >= colEnd:
      return

    self.data[rowBegin][colBegin] += value
    self.data[rowEnd][colBegin] -= value
    self.data[rowBegin][colEnd] -= value
    self.data[rowEnd][colEnd] += value

  proc add*[T](
      self: var DualCumulativeSum2D[T],
      row,
      col: int,
      value: T,
  ) =
    ## Adds value to one cell.

    self.add(
      row .. row,
      col .. col,
      value,
    )

  proc build*[T](
      self: var DualCumulativeSum2D[T],
  ) =
    ## Builds the row-major two-dimensional difference grid.

    if self.built:
      return

    self.built = true

    for row in 1 ..< self.data.len:
      for col in 0 ..< self.data[row].len:
        self.data[row][col] +=
          self.data[row - 1][col]

    for col in 1 ..< self.data[0].len:
      for row in 0 ..< self.data.len:
        self.data[row][col] +=
          self.data[row][col - 1]

  proc `[]`*[T](
      self: DualCumulativeSum2D[T],
      row,
      col: int,
  ): T =
    assert self.built

    if row < 0 or col < 0:
      return T(0)

    if row >= self.heightValue or
        col >= self.widthValue:
      return T(0)

    self.data[row][col]

  proc write*[T](
      self: DualCumulativeSum2D[T],
  ) =
    ## Writes rows outermost and columns innermost.

    assert self.built

    for row in 0 ..< self.heightValue:
      for col in 0 ..< self.widthValue:
        stdout.write(
          self[row, col],
        )

      echo ""

  proc add*[T](
      self: var DualCumulativeSum2D[T],
      rowBegin,
      rowEnd,
      colBegin,
      colEnd: int,
      value: T,
  ) =
    ## Adds value to the half-open rectangle
    ## [rowBegin, rowEnd) x [colBegin, colEnd).

    assert 0 <= rowBegin
    assert rowBegin <= rowEnd
    assert rowEnd <= self.heightValue
    assert 0 <= colBegin
    assert colBegin <= colEnd
    assert colEnd <= self.widthValue

    if rowBegin == rowEnd or
        colBegin == colEnd:
      return

    self.add(
      rowBegin .. rowEnd - 1,
      colBegin .. colEnd - 1,
      value,
    )

  proc get*[T](
      self: DualCumulativeSum2D[T],
      row,
      col: int,
  ): T {.inline.} =
    self[
      row,
      col,
    ]
