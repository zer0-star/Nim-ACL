
discard """
  cmd: "nim cpp -r $file"
"""

import atcoder/extra/structure/convex_hull_trick_add_monotone

proc bruteMin(lines: seq[(int, int)], x: int): int =
  result = int.high
  for (a, b) in lines:
    result = min(result, a * x + b)

proc bruteMax(lines: seq[(int, int)], x: int): int =
  result = int.low
  for (a, b) in lines:
    result = max(result, a * x + b)

block:
  let lines = @[(0, 5), (1, 1), (2, 0)]
  var cht = initConvexHullTrickAddMonotone[int](true)

  for (a, b) in lines:
    cht.add(a, b)

  for x in -5..5:
    doAssert cht.query(x) == bruteMin(lines, x)

block:
  let lines = @[(0, 5), (1, 1), (2, 0)]
  var cht = initConvexHullTrickAddMonotone[int](true)

  for (a, b) in lines:
    cht.add(a, b)

  for x in -5..5:
    doAssert cht.query_monotone_inc(x) == bruteMin(lines, x)

block:
  let lines = @[(0, 5), (1, 1), (2, 0)]
  var cht = initConvexHullTrickAddMonotone[int](true)

  for (a, b) in lines:
    cht.add(a, b)

  for x in countdown(5, -5):
    doAssert cht.query_monotone_dec(x) == bruteMin(lines, x)

block:
  let lines = @[(0, 5), (1, 1), (2, 0)]
  var cht = initConvexHullTrickAddMonotone[int](false)

  for (a, b) in lines:
    cht.add(a, b)

  for x in -5..5:
    doAssert cht.query(x) == bruteMax(lines, x)
