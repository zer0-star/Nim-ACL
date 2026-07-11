discard """
  cmd: "nim cpp -r $file"
"""

import std/[random, unittest]

import atcoder/extra/dp/monotone_minima
import atcoder/extra/dp/divide_and_conquer_optimization

type
  IntMatrixValue = proc(
    row,
    column: int,
  ): int {.closure.}

proc bruteArgmin(
    rowCount,
    columnCount: int,
    value: IntMatrixValue,
): seq[int] =
  result = newSeq[int](
    rowCount
  )

  for row in 0 ..< rowCount:
    var
      bestColumn = 0
      bestValue = value(
        row,
        0,
      )

    for column in 1 ..< columnCount:
      let current = value(
        row,
        column,
      )

      if current < bestValue:
        bestValue = current
        bestColumn = column

    result[row] = bestColumn

proc bruteMinimum(
    rowCount,
    columnCount: int,
    value: IntMatrixValue,
): tuple[
    minimum: seq[int],
    argmin: seq[int],
] =
  result.argmin = bruteArgmin(
    rowCount,
    columnCount,
    value,
  )

  result.minimum = newSeq[int](
    rowCount
  )

  for row in 0 ..< rowCount:
    result.minimum[row] = value(
      row,
      result.argmin[row],
    )

test "Monotone Minima fixed matrix and tie policy":
  let centers = @[
    0,
    1,
    1,
    3,
    4,
  ]

  let value =
    proc(
        row,
        column: int,
    ): int =
      let distance =
        column - centers[row]

      distance * distance + row

  check monotoneMinima[
    int
  ](
    centers.len,
    6,
    value,
  ) == centers

  let allEqual =
    proc(
        row,
        column: int,
    ): int =
      discard row
      discard column
      0

  check monotoneMinima[
    int
  ](
    8,
    9,
    allEqual,
  ) == newSeq[int](8)

  check monotoneMinima[
    int
  ](
    0,
    0,
    allEqual,
  ).len == 0

test "Monotone Minima randomized differential":
  var rng = initRand(
    20260711
  )

  for caseId in 0 ..< 500:
    discard caseId

    let
      rowCount = rand(
        rng,
        0 .. 28,
      )
      columnCount = rand(
        rng,
        1 .. 28,
      )

    var
      centers = newSeq[int](
        rowCount
      )
      currentCenter = 0

    for row in 0 ..< rowCount:
      currentCenter = rand(
        rng,
        currentCenter .. columnCount - 1,
      )

      centers[row] = currentCenter

    let value =
      proc(
          row,
          column: int,
      ): int =
        let distance =
          column - centers[row]

        distance * distance +
          row * 3

    let expected = bruteMinimum(
      rowCount,
      columnCount,
      value,
    )

    let actual =
      divideAndConquerOptimization[
        int
      ](
        rowCount,
        columnCount,
        value,
      )

    check actual.argmin ==
      expected.argmin

    check actual.minimum ==
      expected.minimum

test "DP layer randomized differential on Monge costs":
  var rng = initRand(
    20260712
  )

  for caseId in 0 ..< 400:
    discard caseId

    let
      candidateCount = rand(
        rng,
        1 .. 24,
      )
      stateCount = rand(
        rng,
        0 .. 24,
      )

    var previous = newSeq[int](
      candidateCount
    )

    for candidate in 0 ..< candidateCount:
      previous[candidate] = rand(
        rng,
        -50 .. 50,
      )

    let cost =
      proc(
          candidate,
          state: int,
      ): int =
        let distance =
          candidate - state

        distance * distance

    let actual =
      divideAndConquerDpLayer[
        int
      ](
        previous,
        stateCount,
        cost,
      )

    var
      expectedMinimum = newSeq[int](
        stateCount
      )
      expectedArgmin = newSeq[int](
        stateCount
      )

    for state in 0 ..< stateCount:
      var
        bestCandidate = 0
        bestValue =
          previous[0] +
          cost(
            0,
            state,
          )

      for candidate in 1 ..< candidateCount:
        let current =
          previous[candidate] +
          cost(
            candidate,
            state,
          )

        if current < bestValue:
          bestValue = current
          bestCandidate = candidate

      expectedMinimum[state] =
        bestValue

      expectedArgmin[state] =
        bestCandidate

    check actual.minimum ==
      expectedMinimum

    check actual.argmin ==
      expectedArgmin

test "evaluation count remains subquadratic":
  const
    RowCount = 2048
    ColumnCount = 2048

  var calls = 0

  let value =
    proc(
        row,
        column: int,
    ): int =
      calls.inc

      let distance =
        column - row

      distance * distance

  let result = monotoneMinima[
    int
  ](
    RowCount,
    ColumnCount,
    value,
  )

  check result.len == RowCount
  check result[0] == 0
  check result[^1] == RowCount - 1

  check calls < 100_000
