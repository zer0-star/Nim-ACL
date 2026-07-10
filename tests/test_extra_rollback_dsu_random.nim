discard """
  cmd: "nim cpp -r $file"
"""

import std/[random, unittest]

import atcoder/extra/structure/rollback_dsu

type
  Edge = tuple[a, b: int]

proc copyEdges(edges: openArray[Edge]): seq[Edge] =
  result = newSeq[Edge](edges.len)

  for i, edge in edges:
    result[i] = edge

proc componentIds(n: int, edges: openArray[Edge]): seq[int] =
  result = newSeq[int](n)

  for i in 0 ..< n:
    result[i] = -1

  var component = 0

  for start in 0 ..< n:
    if result[start] >= 0:
      continue

    result[start] = component

    var queue = @[start]
    var head = 0

    while head < queue.len:
      let vertex = queue[head]
      head.inc

      for edge in edges:
        var to = -1

        if edge.a == vertex:
          to = edge.b
        elif edge.b == vertex:
          to = edge.a

        if to >= 0 and result[to] < 0:
          result[to] = component
          queue.add(to)

    component.inc

proc validate(
    dsu: RollbackDSU,
    n: int,
    edges: openArray[Edge],
) =
  let ids = componentIds(n, edges)

  var componentCount = 0
  var sizes = newSeq[int](n)

  for i in 0 ..< n:
    componentCount = max(componentCount, ids[i] + 1)
    sizes[ids[i]].inc

  check dsu.componentCount == componentCount

  for i in 0 ..< n:
    check dsu.size(i) == sizes[ids[i]]

    for j in 0 ..< n:
      check dsu.same(i, j) == (ids[i] == ids[j])

test "RollbackDSU randomized differential history":
  var rng = initRand(0x44535526)

  for caseId in 0 ..< 100:
    let n = rand(rng, 1 .. 12)

    var dsu = initRollbackDSU(n)
    var states: seq[seq[Edge]] = @[@[]]

    validate(dsu, n, states[^1])

    for operationId in 0 ..< 220:
      let operation = rand(rng, 0 .. 99)

      if operation < 62:
        let a = rand(rng, 0 ..< n)
        let b = rand(rng, 0 ..< n)
        let ids = componentIds(n, states[^1])
        let expectedMerged = ids[a] != ids[b]

        var nextEdges = copyEdges(states[^1])

        if expectedMerged:
          nextEdges.add((a: a, b: b))

        check dsu.merge(a, b) == expectedMerged

        states.add(nextEdges)

      elif operation < 86:
        let snapshot = rand(rng, 0 .. dsu.snapshot)

        dsu.rollback(snapshot)
        states.setLen(snapshot + 1)

      elif dsu.snapshot > 0:
        let expectedMerged =
          states[^1].len != states[^2].len

        check dsu.undo() == expectedMerged
        states.setLen(states.len - 1)

      check dsu.snapshot == states.len - 1
      check dsu.time == states.len - 1

      validate(dsu, n, states[^1])
