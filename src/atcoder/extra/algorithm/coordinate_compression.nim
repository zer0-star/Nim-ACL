when not declared ATCODER_EXTRA_ALGORITHM_COORDINATE_COMPRESSION_HPP:
  const ATCODER_EXTRA_ALGORITHM_COORDINATE_COMPRESSION_HPP* = 1

  import std/algorithm

  type
    CoordinateCompression*[T] = object
      values*: seq[T]

  proc initCoordinateCompression*[T](
    a: openArray[T]
  ): CoordinateCompression[T] =
    ## Sorts and deduplicates all candidate coordinates.
    var sortedValues = @a

    sortedValues.sort()

    for x in sortedValues:
      if result.values.len == 0 or result.values[^1] != x:
        result.values.add x

  proc len*[T](
    cc: CoordinateCompression[T]
  ): int {.inline.} =
    cc.values.len

  proc empty*[T](
    cc: CoordinateCompression[T]
  ): bool {.inline.} =
    cc.values.len == 0

  proc lowerBoundIndex*[T](
    cc: CoordinateCompression[T],
    x: T
  ): int =
    ## Returns the first index whose value is `>= x`.
    var
      l = 0
      r = cc.values.len

    while l < r:
      let m = (l + r) div 2

      if cc.values[m] < x:
        l = m + 1
      else:
        r = m

    l

  proc upperBoundIndex*[T](
    cc: CoordinateCompression[T],
    x: T
  ): int =
    ## Returns the first index whose value is `> x`.
    var
      l = 0
      r = cc.values.len

    while l < r:
      let m = (l + r) div 2

      if x < cc.values[m]:
        r = m
      else:
        l = m + 1

    l

  proc indexOf*[T](
    cc: CoordinateCompression[T],
    x: T
  ): int =
    ## Returns the compressed index, or `-1` when `x` was not registered.
    let i = cc.lowerBoundIndex(x)

    if i < cc.values.len and cc.values[i] == x:
      i
    else:
      -1

  proc contains*[T](
    cc: CoordinateCompression[T],
    x: T
  ): bool =
    cc.indexOf(x) >= 0

  proc encode*[T](
    cc: CoordinateCompression[T],
    x: T
  ): int =
    ## Returns the compressed index.
    ##
    ## `x` must have been included during construction.
    result = cc.indexOf(x)

    doAssert result >= 0

  proc compress*[T](
    cc: CoordinateCompression[T],
    a: openArray[T]
  ): seq[int] =
    ## Compresses every value in `a`.
    result = newSeq[int](a.len)

    for i in 0 ..< a.len:
      result[i] = cc.encode(a[i])

  proc decode*[T](
    cc: CoordinateCompression[T],
    index: int
  ): T =
    ## Restores the original value at a compressed index.
    doAssert 0 <= index and index < cc.values.len

    cc.values[index]

  proc restore*[T](
    cc: CoordinateCompression[T],
    indices: openArray[int]
  ): seq[T] =
    ## Restores a sequence of compressed indices.
    result = newSeq[T](indices.len)

    for i in 0 ..< indices.len:
      result[i] = cc.decode(indices[i])
