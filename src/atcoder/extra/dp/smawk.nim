when not declared ATCODER_EXTRA_DP_SMAWK_HPP:
  const
    ATCODER_EXTRA_DP_SMAWK_HPP* = 1

  proc smawk*[T](
      rowCount,
      columnCount: int,
      value: proc(
        row,
        column: int,
      ): T {.closure.},
  ): seq[int] =
    ## Returns the leftmost minimum column of every row of a
    ## totally monotone implicit matrix.

    if rowCount < 0:
      raise newException(
        ValueError,
        "rowCount must be nonnegative",
      )

    if columnCount < 0:
      raise newException(
        ValueError,
        "columnCount must be nonnegative",
      )

    if rowCount == 0:
      return @[]

    if columnCount == 0:
      raise newException(
        ValueError,
        "columnCount must be positive when rows exist",
      )

    result =
      newSeq[int](rowCount)

    proc solve(
        rows,
        columns: seq[int],
        answer: var seq[int],
    ) =
      if rows.len == 0:
        return

      var reduced =
        newSeqOfCap[int](
          min(
            rows.len,
            columns.len,
          )
        )

      for column in columns:
        while reduced.len > 0:
          let row =
            rows[reduced.len - 1]

          if value(
              row,
              column,
          ) < value(
              row,
              reduced[^1],
          ):
            discard reduced.pop()
          else:
            break

        if reduced.len < rows.len:
          reduced.add(column)

      var oddRows =
        newSeqOfCap[int](
          rows.len div 2
        )

      var rowPosition = 1

      while rowPosition < rows.len:
        oddRows.add(
          rows[rowPosition]
        )

        rowPosition += 2

      solve(
        oddRows,
        reduced,
        answer,
      )

      var leftPosition = 0

      rowPosition = 0

      while rowPosition < rows.len:
        let row =
          rows[rowPosition]

        var rightPosition =
          reduced.high

        if rowPosition + 1 < rows.len:
          let nextOddMinimum =
            answer[rows[rowPosition + 1]]

          rightPosition =
            leftPosition

          while reduced[rightPosition] != nextOddMinimum:
            inc rightPosition

        var bestPosition =
          leftPosition

        var columnPosition =
          leftPosition + 1

        while columnPosition <= rightPosition:
          if value(
              row,
              reduced[columnPosition],
          ) < value(
              row,
              reduced[bestPosition],
          ):
            bestPosition =
              columnPosition

          inc columnPosition

        answer[row] =
          reduced[bestPosition]

        if rowPosition + 1 < rows.len:
          leftPosition =
            rightPosition

        rowPosition += 2

    var
      rows =
        newSeq[int](rowCount)

      columns =
        newSeq[int](columnCount)

    for row in 0 ..< rowCount:
      rows[row] = row

    for column in 0 ..< columnCount:
      columns[column] = column

    solve(
      rows,
      columns,
      result,
    )
