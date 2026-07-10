when not declared ATCODER_EXTRA_STRUCTURE_ROLLBACK_DSU_HPP:
  const ATCODER_EXTRA_STRUCTURE_ROLLBACK_DSU_HPP* = 1

  type
    RollbackDSUHistory* = object
      x*, oldX*, y*, oldY*: int
      merged*: bool

    RollbackDSU* = object
      parentOrSize*: seq[int]
      history*: seq[RollbackDSUHistory]
      components*: int

  proc initRollbackDSU*(n: int): RollbackDSU =
    ## Creates a rollback-capable DSU with `n` vertices.
    doAssert n >= 0

    result.parentOrSize = newSeq[int](n)
    for i in 0 ..< n:
      result.parentOrSize[i] = -1

    result.history = @[]
    result.components = n

  proc len*(uf: RollbackDSU): int {.inline.} =
    uf.parentOrSize.len

  proc componentCount*(uf: RollbackDSU): int {.inline.} =
    ## Returns the current number of connected components.
    uf.components

  proc snapshot*(uf: RollbackDSU): int {.inline.} =
    ## Returns the current rollback point.
    uf.history.len

  proc time*(uf: RollbackDSU): int {.inline.} =
    ## Alias of `snapshot`.
    uf.snapshot

  proc leader*(uf: RollbackDSU, a: int): int =
    ## Returns the leader of `a`.
    ##
    ## Path compression is intentionally not used because it is hard to roll back.
    doAssert 0 <= a and a < uf.len

    result = a

    while uf.parentOrSize[result] >= 0:
      result = uf.parentOrSize[result]

  proc size*(uf: RollbackDSU, a: int): int =
    ## Returns the size of the component containing `a`.
    let r = uf.leader(a)
    -uf.parentOrSize[r]

  proc same*(uf: RollbackDSU, a, b: int): bool =
    ## Returns whether `a` and `b` are in the same component.
    uf.leader(a) == uf.leader(b)

  proc merge*(uf: var RollbackDSU, a, b: int): bool =
    ## Merges the components of `a` and `b`.
    ##
    ## Returns `true` if the components were different.
    var
      x = uf.leader(a)
      y = uf.leader(b)

    if x == y:
      uf.history.add RollbackDSUHistory(
        x: x,
        oldX: uf.parentOrSize[x],
        y: y,
        oldY: uf.parentOrSize[y],
        merged: false,
      )
      return false

    if -uf.parentOrSize[x] < -uf.parentOrSize[y]:
      swap(x, y)

    uf.history.add RollbackDSUHistory(
      x: x,
      oldX: uf.parentOrSize[x],
      y: y,
      oldY: uf.parentOrSize[y],
      merged: true,
    )

    uf.parentOrSize[x] += uf.parentOrSize[y]
    uf.parentOrSize[y] = x
    uf.components.dec

    true

  proc undo*(uf: var RollbackDSU): bool =
    ## Undoes one `merge` operation.
    ##
    ## Returns whether the undone operation actually merged two components.
    doAssert uf.history.len > 0

    let h = uf.history[^1]
    uf.history.setLen(uf.history.len - 1)

    uf.parentOrSize[h.x] = h.oldX
    uf.parentOrSize[h.y] = h.oldY

    if h.merged:
      uf.components.inc

    h.merged

  proc rollback*(uf: var RollbackDSU): bool =
    ## Alias of `undo`.
    uf.undo()

  proc rollback*(uf: var RollbackDSU, snap: int) =
    ## Rolls back to a previous snapshot.
    doAssert 0 <= snap and snap <= uf.history.len

    while uf.history.len > snap:
      discard uf.undo()

  proc groups*(uf: RollbackDSU): seq[seq[int]] =
    ## Returns all current connected components.
    let n = uf.len

    var
      leaderBuf = newSeq[int](n)
      id = newSeq[int](n)

    for i in 0 ..< n:
      leaderBuf[i] = uf.leader(i)
      id[i] = -1

    for i in 0 ..< n:
      let r = leaderBuf[i]

      if id[r] < 0:
        id[r] = result.len
        result.add @[]

      result[id[r]].add i
