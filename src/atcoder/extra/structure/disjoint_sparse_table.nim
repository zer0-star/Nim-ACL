when not declared ATCODER_EXTRA_STRUCTURE_DISJOINT_SPARSE_TABLE_HPP:
  const ATCODER_EXTRA_STRUCTURE_DISJOINT_SPARSE_TABLE_HPP* = 1

  type
    DisjointSparseTable*[T] = object
      data*: seq[T]
      table*: seq[seq[T]]
      op*: proc(a, b: T): T {.closure.}

  proc highestBitIndex(x: int): int {.inline.} =
    doAssert x > 0

    var y = x

    while (y shr 1) > 0:
      result.inc
      y = y shr 1

  proc initDisjointSparseTable*[T](
    a: openArray[T],
    op: proc(a, b: T): T {.closure.}
  ): DisjointSparseTable[T] =
    ## Builds a Disjoint Sparse Table.
    ##
    ## `op` must be associative. It does not need to be idempotent.
    result.data = @a
    result.op = op

    let n = a.len

    var
      levels = 0
      span = 1

    while span < n:
      levels.inc
      span = span shl 1

    result.table = newSeq[seq[T]](levels)

    for k in 0 ..< levels:
      result.table[k] = newSeq[T](n)

      let
        half = 1 shl k
        blockSize = half shl 1

      var blockStart = 0

      while blockStart < n:
        let
          middle = min(blockStart + half, n)
          blockEnd = min(blockStart + blockSize, n)

        if middle > blockStart:
          result.table[k][middle - 1] = a[middle - 1]

          if middle - 2 >= blockStart:
            for i in countdown(middle - 2, blockStart):
              result.table[k][i] =
                op(a[i], result.table[k][i + 1])

        if middle < blockEnd:
          result.table[k][middle] = a[middle]

          for i in middle + 1 ..< blockEnd:
            result.table[k][i] =
              op(result.table[k][i - 1], a[i])

        blockStart += blockSize

  proc len*[T](dst: DisjointSparseTable[T]): int {.inline.} =
    dst.data.len

  proc prod*[T](dst: DisjointSparseTable[T], l, r: int): T =
    ## Returns `op(a[l], ..., a[r-1])`.
    ##
    ## The range is half-open and must be non-empty.
    doAssert 0 <= l and l < r and r <= dst.len

    if r - l == 1:
      return dst.data[l]

    let k = highestBitIndex(l xor (r - 1))

    dst.op(dst.table[k][l], dst.table[k][r - 1])

  proc `[]`*[T](
    dst: DisjointSparseTable[T],
    range: tuple[l, r: int]
  ): T =
    ## Sugar for `prod(range.l, range.r)`.
    dst.prod(range.l, range.r)
