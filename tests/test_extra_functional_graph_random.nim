discard """
  cmd: "nim cpp -r $file"
"""

import std/[random, unittest]

import atcoder/extra/graph/functional_graph

proc bruteJump(
    to: openArray[int],
    start: int,
    count: int,
): int =
  result = start

  for step in 0 ..< count:
    result = to[result]

proc bruteOrbit(
    to: openArray[int],
    start: int,
): tuple[prefix, cycle: seq[int]] =
  var position = newSeq[int](to.len)

  for i in 0 ..< position.len:
    position[i] = -1

  var order: seq[int] = @[]
  var vertex = start

  while position[vertex] < 0:
    position[vertex] = order.len
    order.add(vertex)
    vertex = to[vertex]

  let cycleStart = position[vertex]

  if cycleStart > 0:
    result.prefix = order[0 ..< cycleStart]
  else:
    result.prefix = @[]

  result.cycle = order[
    cycleStart ..< order.len
  ]

test "FunctionalGraph and Doubling randomized differential":
  var rng = initRand(0x46554726)

  for caseId in 0 ..< 300:
    let n = rand(rng, 1 .. 24)

    var to = newSeq[int](n)

    for vertex in 0 ..< n:
      to[vertex] = rand(rng, 0 .. n - 1)

    let doubling = initDoubling(
      to,
      maxLog = 12,
    )

    let graph = initFunctionalGraph(
      to,
      maxLog = 12,
    )

    check doubling.len == n
    check graph.len == n
    check graph.to == to

    for queryId in 0 ..< 180:
      let start = rand(rng, 0 .. n - 1)
      let count = rand(rng, 0 .. 5000)
      let expected = bruteJump(
        to,
        start,
        count,
      )

      check doubling.jump(start, count) ==
        expected

      check doubling[(start, count)] ==
        expected

      check graph.jump(start, count) ==
        expected

      check graph[(start, count)] ==
        expected

    for start in 0 ..< n:
      let expected = bruteOrbit(
        to,
        start,
      )

      let actual = graph.orbit(start)
      let info = graph.cycleInfo(start)

      check actual.prefix == expected.prefix
      check actual.cycle == expected.cycle
      check info.tail == expected.prefix.len
      check info.period == expected.cycle.len

      check expected.cycle.len >= 1

      let reducedCount =
        expected.prefix.len +
        rand(rng, 0 .. 100) *
          expected.cycle.len

      check graph.jump(start, reducedCount) ==
        bruteJump(to, start, reducedCount)
