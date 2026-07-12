# Min-plus convolution where the first input is convex.
#
# The convexity precondition is checked by the current public facade.
# Both inputs are preserved and a newly allocated sequence is returned.

proc isConvex(
    values: openArray[int64],
): bool =
  if values.len <= 2:
    return true

  var previousDifference =
    values[1] -
    values[0]

  for index in 2 ..< values.len:
    let difference =
      values[index] -
      values[index - 1]

    if difference <
        previousDifference:
      return false

    previousDifference =
      difference

  true


proc solveRows(
    convex,
    arbitrary: openArray[int64],
    answer: var seq[int64],
    leftRow,
    rightRow,
    optionLeft,
    optionRight: int,
) =
  if leftRow > rightRow:
    return

  let middle =
    (leftRow + rightRow) div 2

  let minimumOption =
    max(
      optionLeft,
      max(
        0,
        middle - (convex.len - 1),
      ),
    )

  let maximumOption =
    min(
      optionRight,
      min(
        arbitrary.high,
        middle,
      ),
    )

  doAssert minimumOption <=
    maximumOption

  var bestOption =
    minimumOption

  var bestValue =
    convex[
      middle - minimumOption
    ] +
    arbitrary[minimumOption]

  for option in minimumOption + 1 ..
      maximumOption:
    let candidate =
      convex[middle - option] +
      arbitrary[option]

    if candidate < bestValue:
      bestValue =
        candidate

      bestOption =
        option

  answer[middle] =
    bestValue

  solveRows(
    convex,
    arbitrary,
    answer,
    leftRow,
    middle - 1,
    optionLeft,
    bestOption,
  )

  solveRows(
    convex,
    arbitrary,
    answer,
    middle + 1,
    rightRow,
    bestOption,
    optionRight,
  )


proc minPlusConvolutionConvexArbitrary*(
    convex,
    arbitrary: openArray[int64],
): seq[int64] =
  if convex.len == 0 or
      arbitrary.len == 0:
    return newSeq[int64]()

  if not isConvex(convex):
    raise newException(
      ValueError,
      "the first sequence must be convex",
    )

  result =
    newSeq[int64](
      convex.len +
      arbitrary.len -
      1
    )

  solveRows(
    convex,
    arbitrary,
    result,
    0,
    result.high,
    0,
    arbitrary.high,
  )
