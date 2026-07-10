when not declared ATCODER_EXTRA_GRAPH_FUNCTIONAL_GRAPH_HPP:
  const ATCODER_EXTRA_GRAPH_FUNCTIONAL_GRAPH_HPP* = 1

  type
    Doubling* = object
      table*: seq[seq[int]]

    FunctionalGraph* = object
      to*: seq[int]
      doubling*: Doubling

  proc len*(db: Doubling): int {.inline.} =
    if db.table.len == 0: 0 else: db.table[0].len

  proc initDoubling*(to: openArray[int], maxLog: int = 60): Doubling =
    ## Builds a doubling table for a function `to`.
    ##
    ## `jump(v, k)` returns the result of applying `to` exactly `k` times.
    doAssert maxLog >= 0

    let n = to.len
    result.table = newSeq[seq[int]](maxLog + 1)
    result.table[0] = newSeq[int](n)

    for v in 0 ..< n:
      doAssert 0 <= to[v] and to[v] < n
      result.table[0][v] = to[v]

    for b in 0 ..< maxLog:
      result.table[b + 1] = newSeq[int](n)
      for v in 0 ..< n:
        result.table[b + 1][v] = result.table[b][result.table[b][v]]

  proc jump*[K: SomeInteger](db: Doubling, v: int, k: K): int =
    ## Applies the stored function `k` times to `v`.
    doAssert db.table.len > 0
    doAssert 0 <= v and v < db.len

    when K is SomeSignedInt:
      doAssert k >= 0

    let kk = uint64(k)

    if db.table.len < 64:
      doAssert (kk shr db.table.len) == 0'u64

    result = v

    for b in 0 ..< db.table.len:
      if ((kk shr b) and 1'u64) != 0'u64:
        result = db.table[b][result]

  proc `[]`*[K: SomeInteger](db: Doubling, q: tuple[v: int, k: K]): int =
    ## Sugar for `db.jump(v, k)`.
    db.jump(q.v, q.k)

  proc initFunctionalGraph*(to: openArray[int], maxLog: int = 60): FunctionalGraph =
    ## Builds a functional graph wrapper and its doubling table.
    result.to = @to
    result.doubling = initDoubling(to, maxLog)

  proc len*(fg: FunctionalGraph): int {.inline.} =
    fg.to.len

  proc jump*[K: SomeInteger](fg: FunctionalGraph, v: int, k: K): int =
    ## Applies the functional graph edge exactly `k` times from `v`.
    fg.doubling.jump(v, k)

  proc `[]`*[K: SomeInteger](fg: FunctionalGraph, q: tuple[v: int, k: K]): int =
    ## Sugar for `fg.jump(v, k)`.
    fg.jump(q.v, q.k)

  proc cycleInfo*(fg: FunctionalGraph, start: int): tuple[tail, period: int] =
    ## Returns `(tail, period)` for the orbit starting at `start`.
    ##
    ## The first `tail` vertices are outside the cycle.
    ## The cycle length is `period`.
    let n = fg.len
    doAssert 0 <= start and start < n

    var pos = newSeq[int](n)
    for i in 0 ..< n:
      pos[i] = -1

    var
      v = start
      step = 0

    while pos[v] < 0:
      pos[v] = step
      step.inc
      v = fg.to[v]

    result.tail = pos[v]
    result.period = step - pos[v]

  proc orbit*(fg: FunctionalGraph, start: int): tuple[prefix, cycle: seq[int]] =
    ## Returns the orbit from `start` split into a prefix and a cycle.
    let n = fg.len
    doAssert 0 <= start and start < n

    var pos = newSeq[int](n)
    for i in 0 ..< n:
      pos[i] = -1

    var
      order: seq[int] = @[]
      v = start

    while pos[v] < 0:
      pos[v] = order.len
      order.add v
      v = fg.to[v]

    let p = pos[v]
    result.prefix = order[0 ..< p]
    result.cycle = order[p ..< order.len]
