import std/[
  algorithm,
  unittest,
]

import atcoder/extra/dp/smawk


proc naiveRowMinima[T](
    rowCount,
    columnCount: int,
    value: proc(
      row,
      column: int,
    ): T {.closure.},
): seq[int] =
  result =
    newSeq[int](rowCount)

  for row in 0 ..< rowCount:
    var bestColumn = 0

    for column in 1 ..< columnCount:
      if value(
          row,
          column,
      ) < value(
          row,
          bestColumn,
      ):
        bestColumn = column

    result[row] =
      bestColumn


proc nextRandom(
    state: var uint64,
): uint64 {.inline.} =
  state = state xor (state shl 7)
  state = state xor (state shr 9)
  state = state xor (state shl 8)
  state


suite "smawk":
  test "zero rows":
    var called = false

    let value =
      proc(
          row,
          column: int,
      ): int =
        called = true
        row + column

    check smawk[int](
      0,
      0,
      value,
    ).len == 0

    check not called

  test "invalid dimensions":
    let value =
      proc(
          row,
          column: int,
      ): int =
        row + column

    expect ValueError:
      discard smawk[int](
        -1,
        1,
        value,
      )

    expect ValueError:
      discard smawk[int](
        1,
        -1,
        value,
      )

    expect ValueError:
      discard smawk[int](
        1,
        0,
        value,
      )

  test "leftmost minimum wins ties":
    let value =
      proc(
          row,
          column: int,
      ): int =
        discard row

        if column == 2 or column == 3:
          0
        else:
          10 + column

    check smawk[int](
      1,
      6,
      value,
    ) == @[2]

  test "known rectangular matrix":
    let
      centerTimesTwo =
        @[0, 1, 3, 6]

      value =
        proc(
            row,
            column: int,
        ): int =
          let difference =
            2 * column - centerTimesTwo[row]

          difference * difference

    check smawk[int](
      centerTimesTwo.len,
      5,
      value,
    ) == @[0, 0, 1, 3]

  test "randomized totally monotone differential":
    var state =
      0xc6a3_179d_52e8_b04f'u64

    for rowCount in 1 .. 36:
      for columnCount in 1 .. 36:
        for _ in 0 ..< 8:
          var
            centerTimesTwo =
              newSeq[int](rowCount)

            rowBias =
              newSeq[int](rowCount)

          for row in 0 ..< rowCount:
            centerTimesTwo[row] =
              int(
                nextRandom(state) mod uint64(
                  2 * columnCount
                )
              )

            rowBias[row] =
              int(
                nextRandom(state) mod 101'u64
              )

          centerTimesTwo.sort()

          let value =
            proc(
                row,
                column: int,
            ): int =
              let difference =
                2 * column - centerTimesTwo[row]

              difference * difference + rowBias[row]

          check smawk[int](
            rowCount,
            columnCount,
            value,
          ) == naiveRowMinima[int](
            rowCount,
            columnCount,
            value,
          )

  test "value evaluations remain linear":
    const
      RowCount = 127
      ColumnCount = 193

    var evaluationCount = 0

    let value =
      proc(
          row,
          column: int,
      ): int =
        inc evaluationCount

        let
          centerTimesTwo =
            row * (2 * ColumnCount - 1) div (RowCount - 1)

          difference =
            2 * column - centerTimesTwo

        difference * difference

    discard smawk[int](
      RowCount,
      ColumnCount,
      value,
    )

    check evaluationCount <=
      16 * (RowCount + ColumnCount + 1)
