when not declared ATCODER_CUMULATIVE_SUM_2D_HPP:
  const ATCODER_CUMULATIVE_SUM_2D_HPP* = 1

  import std/sequtils

  type
    CumulativeSum2D*[T] = object
      built: bool
      data: seq[seq[T]]

  proc initCumulativeSum2D*[T](
      height,
      width: int,
  ): CumulativeSum2D[T] =
    ## Constructs an initially zero H x W grid.
    ##
    ## The first coordinate is row and the second is column.

    assert height >= 0
    assert width >= 0

    CumulativeSum2D[T](
      built: false,
      data: newSeqWith(
        height + 1,
        newSeqWith(
          width + 1,
          T(0),
        ),
      ),
    )

  proc initCumulativeSum2D*[T](
      data: seq[seq[T]],
  ): CumulativeSum2D[T] =
    ## Constructs a prefix-sum grid from data[row][col].

    let
      height = data.len
      width =
        if height == 0:
          0
        else:
          data[0].len

    result =
      initCumulativeSum2D[T](
        height,
        width,
      )

    for row in 0 ..< height:
      assert data[row].len == width

      for col in 0 ..< width:
        result.add(
          row,
          col,
          data[row][col],
        )

    result.build()

  proc add*[T](
      self: var CumulativeSum2D[T],
      row,
      col: int,
      value: T,
  ) =
    ## Adds value to data[row][col] before build().
    ##
    ## Coordinates outside the grid are ignored, matching the
    ## historical behavior of this module.

    assert not self.built

    let
      rowIndex = row + 1
      colIndex = col + 1

    if rowIndex <= 0 or colIndex <= 0:
      return

    if rowIndex >= self.data.len or
        colIndex >= self.data[0].len:
      return

    self.data[rowIndex][colIndex] += value

  proc build*[T](
      self: var CumulativeSum2D[T],
  ) =
    ## Builds row-major two-dimensional prefix sums.

    if self.built:
      return

    self.built = true

    for row in 1 ..< self.data.len:
      for col in 1 ..< self.data[row].len:
        self.data[row][col] +=
          self.data[row - 1][col] +
          self.data[row][col - 1] -
          self.data[row - 1][col - 1]

  proc `[]`*[T](
      self: CumulativeSum2D[T],
      rowRange,
      colRange: Slice[int],
  ): T =
    ## Returns the sum over the inclusive rectangle
    ## rowRange x colRange.

    assert self.built

    let
      rowEnd = rowRange.b + 1
      colEnd = colRange.b + 1
      rowBegin = rowRange.a
      colBegin = colRange.a

    self.data[rowEnd][colEnd] -
    self.data[rowBegin][colEnd] -
    self.data[rowEnd][colBegin] +
    self.data[rowBegin][colBegin]

  proc height*[T](
      self: CumulativeSum2D[T],
  ): int {.inline.} =
    if self.data.len == 0:
      0
    else:
      self.data.len - 1

  proc width*[T](
      self: CumulativeSum2D[T],
  ): int {.inline.} =
    if self.data.len == 0 or
        self.data[0].len == 0:
      0
    else:
      self.data[0].len - 1

  proc sum*[T](
      self: CumulativeSum2D[T],
      rowBegin,
      rowEnd,
      colBegin,
      colEnd: int,
  ): T =
    ## Returns the sum over the half-open rectangle
    ## [rowBegin, rowEnd) x [colBegin, colEnd).

    assert self.built
    assert 0 <= rowBegin
    assert rowBegin <= rowEnd
    assert rowEnd <= self.height
    assert 0 <= colBegin
    assert colBegin <= colEnd
    assert colEnd <= self.width

    if rowBegin == rowEnd or
        colBegin == colEnd:
      return T(0)

    self[
      rowBegin .. rowEnd - 1,
      colBegin .. colEnd - 1,
    ]

  proc allSum*[T](
      self: CumulativeSum2D[T],
  ): T {.inline.} =
    self.sum(
      0,
      self.height,
      0,
      self.width,
    )
