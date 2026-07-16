when not declared ATCODER_EXTRA_DP_MONOTONE_MINIMA_HPP:
  const ATCODER_EXTRA_DP_MONOTONE_MINIMA_HPP* = 1

  proc monotoneMinima*[T](
      rowCount,
      columnCount: int,
      value: proc(
        row,
        column: int,
      ): T {.closure.},
  ): seq[int] =
    ## Finds the leftmost minimum column of each row.
    ##
    ## The caller must guarantee that the selected minimum
    ## columns are monotonically nondecreasing by row.
    ##
    ## The matrix is accessed lazily through `value`.
    ##
    ## Time:
    ## `O((rowCount + columnCount) * log(rowCount + 1))`
    ## value evaluations.
    ##
    ## Space:
    ## `O(rowCount)` for the result and recursion.

    doAssert rowCount >= 0
    doAssert columnCount >= 0

    if rowCount == 0:
      return @[]

    doAssert columnCount > 0

    var answer = newSeq[int](rowCount)

    proc solve(
        rowLeft,
        rowRight,
        columnLeft,
        columnRight: int,
    ) =
      if rowLeft >= rowRight:
        return

      let row =
        (rowLeft + rowRight) shr 1

      var
        bestColumn = columnLeft
        bestValue = value(
          row,
          columnLeft,
        )
        column = columnLeft + 1

      while column <= columnRight:
        let current = value(
          row,
          column,
        )

        if current < bestValue:
          bestValue = current
          bestColumn = column

        column.inc

      answer[row] = bestColumn

      solve(
        rowLeft,
        row,
        columnLeft,
        bestColumn,
      )

      solve(
        row + 1,
        rowRight,
        bestColumn,
        columnRight,
      )

    solve(
      0,
      rowCount,
      0,
      columnCount - 1,
    )

    result = answer

  proc divideAndConquerOptimization*[T](
      rowCount,
      columnCount: int,
      value: proc(
        row,
        column: int,
      ): T {.closure.},
  ): tuple[
      minimum: seq[T],
      argmin: seq[int],
  ] =
    ## Returns the minimum value and its leftmost column
    ## for every row of a monotone-minima matrix.
    ##
    ## This is the usual divide-and-conquer optimization
    ## kernel for a DP transition matrix whose optimum
    ## positions are monotonically nondecreasing.

    result.argmin = monotoneMinima[
      T
    ](
      rowCount,
      columnCount,
      value,
    )

    result.minimum = newSeq[T](
      rowCount
    )

    for row in 0 ..< rowCount:
      result.minimum[row] = value(
        row,
        result.argmin[row],
      )

  proc divideAndConquerDpLayer*[T](
      previous: openArray[T],
      stateCount: int,
      cost: proc(
        candidate,
        state: int,
      ): T {.closure.},
  ): tuple[
      minimum: seq[T],
      argmin: seq[int],
  ] =
    ## Computes one DP layer:
    ##
    ## `current[state] = min_candidate(
    ##    previous[candidate] + cost(candidate, state)
    ##  )`
    ##
    ## The caller must guarantee that the leftmost optimum
    ## candidate is monotonically nondecreasing by `state`.
    ##
    ## Invalid candidates may be represented by a sufficiently
    ## large value returned from `cost`.

    doAssert stateCount >= 0

    if stateCount > 0:
      doAssert previous.len > 0

    let previousOwned = @previous
    let transitionValue =
      proc(
          state,
          candidate: int,
      ): T =
        previousOwned[candidate] +
          cost(
            candidate,
            state,
          )

    result = divideAndConquerOptimization[
      T
    ](
      stateCount,
      previous.len,
      transitionValue,
    )
