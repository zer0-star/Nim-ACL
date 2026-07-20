# verify-helper: PROBLEM https://yukicoder.me/problems/no/1490

import atcoder/header
import atcoder/extra/dp/dual_cumulative_sum_2d
import atcoder/extra/dp/cumulative_sum_2d

let height, width, queryCount, sourceCount = nextInt()

var
  rowBegin = newSeq[int](queryCount)
  rowEnd = newSeq[int](queryCount)
  colBegin = newSeq[int](queryCount)
  colEnd = newSeq[int](queryCount)
  threshold = newSeq[int](queryCount)

for index in 0 ..< queryCount:
  rowBegin[index] = nextInt() - 1
  rowEnd[index] = nextInt() - 1
  colBegin[index] = nextInt() - 1
  colEnd[index] = nextInt() - 1
  threshold[index] = nextInt()

var difference =
  initDualCumulativeSum2D[int](
    height,
    width,
  )

for _ in 0 ..< sourceCount:
  var
    row = nextInt() - 1
    col = nextInt() - 1
    radius = nextInt()
    value = nextInt()

  let
    firstRow = max(
      row - radius,
      0,
    )
    firstCol = max(
      col - radius,
      0,
    )
    lastRow = min(
      row + radius,
      height - 1,
    )
    lastCol = min(
      col + radius,
      width - 1,
    )

  difference.add(
    firstRow .. lastRow,
    firstCol .. lastCol,
    value,
  )

difference.build()

var cumulative =
  initCumulativeSum2D[int](
    height,
    width,
  )

for row in 0 ..< height:
  for col in 0 ..< width:
    cumulative.add(
      row,
      col,
      difference[row, col],
    )

cumulative.build()

var answer = 0

for index in 0 ..< queryCount:
  let value = cumulative[
    rowBegin[index] .. rowEnd[index],
    colBegin[index] .. colEnd[index],
  ]

  if value < threshold[index]:
    answer.inc

echo answer
