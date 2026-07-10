when not declared ATCODER_EXTRA_ALGORITHM_MO_HPP:
  const ATCODER_EXTRA_ALGORITHM_MO_HPP* = 1

  import std/algorithm
  import std/math

  type
    MoQuery* = object
      l*, r*, id*: int

    Mo* = object
      n*: int
      queries*: seq[MoQuery]
      blockSize*: int

  proc initMo*(n: int, blockSize = 0): Mo =
    ## Creates a Mo's algorithm query container.
    doAssert n >= 0
    doAssert blockSize >= 0

    result.n = n
    result.queries = @[]

    if blockSize > 0:
      result.blockSize = blockSize
    else:
      result.blockSize = max(1, int(sqrt(float(max(1, n)))))

  proc len*(mo: Mo): int {.inline.} =
    ## Returns the number of registered queries.
    mo.queries.len

  proc addQuery*(mo: var Mo, l, r: int): int =
    ## Adds the half-open query `[l, r)` and returns its query id.
    doAssert 0 <= l and l <= r and r <= mo.n

    result = mo.queries.len
    mo.queries.add MoQuery(l: l, r: r, id: result)

  proc orderedQueries*(mo: Mo): seq[MoQuery] =
    ## Returns queries in Mo order.
    result = mo.queries

    let blockSize = mo.blockSize

    result.sort(proc(a, b: MoQuery): int =
      let
        blockA = a.l div blockSize
        blockB = b.l div blockSize

      if blockA != blockB:
        return cmp(blockA, blockB)

      if (blockA and 1) == 0:
        cmp(a.r, b.r)
      else:
        cmp(b.r, a.r)
    )

  proc run*(
    mo: Mo,
    addLeft: proc(index: int) {.closure.},
    addRight: proc(index: int) {.closure.},
    removeLeft: proc(index: int) {.closure.},
    removeRight: proc(index: int) {.closure.},
    answer: proc(queryId: int) {.closure.}
  ) =
    ## Runs registered range queries in Mo order.
    var
      currentL = 0
      currentR = 0

    for query in mo.orderedQueries():
      while currentL > query.l:
        currentL.dec
        addLeft(currentL)

      while currentR < query.r:
        addRight(currentR)
        currentR.inc

      while currentL < query.l:
        removeLeft(currentL)
        currentL.inc

      while currentR > query.r:
        currentR.dec
        removeRight(currentR)

      answer(query.id)

  proc run*(
    mo: Mo,
    add: proc(index: int) {.closure.},
    remove: proc(index: int) {.closure.},
    answer: proc(queryId: int) {.closure.}
  ) =
    ## Runs Mo when adding/removing is symmetric on both ends.
    mo.run(add, add, remove, remove, answer)
