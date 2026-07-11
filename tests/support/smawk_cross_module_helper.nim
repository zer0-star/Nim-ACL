import atcoder/extra/dp/smawk

export smawk


proc buildCrossSmawkResult*():
    seq[int] =
  let value =
    proc(
        row,
        column: int,
    ): int =
      let centerTimesTwo =
        @[0, 1, 3, 6]

      let difference =
        2 * column - centerTimesTwo[row]

      difference * difference

  smawk[int](
    4,
    5,
    value,
  )
