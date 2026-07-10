when not declared ATCODER_EXTRA_STRUCTURE_FAST_SET_HPP:
  const ATCODER_EXTRA_STRUCTURE_FAST_SET_HPP* = 1

  type
    FastSet* = object
      universeSize*: int
      countValue: int
      levels*: seq[seq[uint64]]

  proc trailingZero(x: uint64): int {.inline.} =
    doAssert x != 0'u64

    var value = x

    while (value and 1'u64) == 0'u64:
      result.inc
      value = value shr 1

  proc highestBit(x: uint64): int {.inline.} =
    doAssert x != 0'u64

    var value = x

    while (value shr 1) != 0'u64:
      result.inc
      value = value shr 1

  proc initFastSet*(n: int): FastSet =
    ## Creates an empty set over the universe `[0, n)`.

    doAssert n >= 0

    result.universeSize = n
    result.countValue = 0

    var size = n

    while size > 0:
      let words = (size + 63) div 64

      result.levels.add(
        newSeq[uint64](words)
      )

      if words == 1:
        break

      size = words

  proc len*(s: FastSet): int {.inline.} =
    ## Returns the number of stored integers.

    s.countValue

  proc empty*(s: FastSet): bool {.inline.} =
    ## Returns whether the set is empty.

    s.countValue == 0

  proc contains*(
      s: FastSet,
      x: int,
  ): bool {.inline.} =
    ## Returns whether `x` is present.

    if (
      x < 0 or
      x >= s.universeSize or
      s.levels.len == 0
    ):
      return false

    let
      word = x shr 6
      bit = x and 63

    (
      (
        s.levels[0][word] shr bit
      ) and 1'u64
    ) != 0'u64

  proc insert*(
      s: var FastSet,
      x: int,
  ): bool =
    ## Inserts `x`.
    ##
    ## Returns `true` iff `x` was newly inserted.

    doAssert 0 <= x and x < s.universeSize

    if x in s:
      return false

    var index = x

    for level in 0 ..< s.levels.len:
      let
        word = index shr 6
        bit = index and 63

      s.levels[level][word] =
        s.levels[level][word] or
        (1'u64 shl bit)

      index = word

    s.countValue.inc
    result = true

  proc initFastSet*(
      n: int,
      values: openArray[int],
  ): FastSet =
    ## Creates a set containing `values`.

    result = initFastSet(n)

    for x in values:
      discard result.insert(x)

  proc incl*(
      s: var FastSet,
      x: int,
  ) =
    ## Set-like alias of `insert`.

    discard s.insert(x)

  proc erase*(
      s: var FastSet,
      x: int,
  ): bool =
    ## Erases `x`.
    ##
    ## Returns `true` iff `x` existed.

    if x notin s:
      return false

    var index = x

    for level in 0 ..< s.levels.len:
      let
        word = index shr 6
        bit = index and 63

      s.levels[level][word] =
        s.levels[level][word] and
        not (1'u64 shl bit)

      if s.levels[level][word] != 0'u64:
        break

      index = word

    s.countValue.dec
    result = true

  proc excl*(
      s: var FastSet,
      x: int,
  ) =
    ## Set-like alias of `erase`.

    discard s.erase(x)

  proc nextGE*(
      s: FastSet,
      x: int,
  ): int =
    ## Returns the minimum stored value `>= x`,
    ## or `-1` if absent.

    if (
      s.empty or
      x >= s.universeSize
    ):
      return -1

    var index = max(0, x)

    for level in 0 ..< s.levels.len:
      let word = index shr 6

      if word >= s.levels[level].len:
        return -1

      let
        shift = index and 63
        candidates =
          s.levels[level][word] shr shift

      if candidates == 0'u64:
        index = word + 1
        continue

      index += trailingZero(candidates)

      if level > 0:
        for lowerLevel in countdown(
          level - 1,
          0,
        ):
          let bits =
            s.levels[lowerLevel][index]

          doAssert bits != 0'u64

          index =
            index * 64 +
            trailingZero(bits)

      if index < s.universeSize:
        return index

      return -1

    -1

  proc lowerBound*(
      s: FastSet,
      x: int,
  ): int =
    ## Alias of `nextGE`.

    s.nextGE(x)

  proc upperBound*(
      s: FastSet,
      x: int,
  ): int =
    ## Returns the minimum stored value `> x`,
    ## or `-1`.

    if x >= s.universeSize - 1:
      return -1

    s.nextGE(x + 1)

  proc prevLE*(
      s: FastSet,
      x: int,
  ): int =
    ## Returns the maximum stored value `<= x`,
    ## or `-1` if absent.

    if (
      s.empty or
      x < 0
    ):
      return -1

    var index = min(
      x,
      s.universeSize - 1,
    )

    for level in 0 ..< s.levels.len:
      if index < 0:
        return -1

      var word = index shr 6

      if word >= s.levels[level].len:
        index =
          s.levels[level].len * 64 - 1

        word = index shr 6

      let
        shift = index and 63

        mask =
          if shift == 63:
            high(uint64)
          else:
            (
              1'u64 shl (shift + 1)
            ) - 1'u64

        candidates =
          s.levels[level][word] and mask

      if candidates == 0'u64:
        index = word - 1
        continue

      index =
        word * 64 +
        highestBit(candidates)

      if level > 0:
        for lowerLevel in countdown(
          level - 1,
          0,
        ):
          let bits =
            s.levels[lowerLevel][index]

          doAssert bits != 0'u64

          index =
            index * 64 +
            highestBit(bits)

      if index < s.universeSize:
        return index

      return -1

    -1

  proc prevLT*(
      s: FastSet,
      x: int,
  ): int =
    ## Returns the maximum stored value `< x`,
    ## or `-1`.

    if x <= 0:
      return -1

    s.prevLE(x - 1)

  proc minValue*(s: FastSet): int =
    ## Returns the minimum value,
    ## or `-1` for an empty set.

    s.nextGE(0)

  proc maxValue*(s: FastSet): int =
    ## Returns the maximum value,
    ## or `-1` for an empty set.

    s.prevLE(s.universeSize - 1)

  iterator items*(s: FastSet): int =
    ## Iterates through values in ascending order.

    var value = s.nextGE(0)

    while value >= 0:
      yield value

      if value + 1 >= s.universeSize:
        break

      value = s.nextGE(value + 1)
