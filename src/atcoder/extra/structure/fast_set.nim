when not declared ATCODER_EXTRA_STRUCTURE_FAST_SET_HPP:
  const ATCODER_EXTRA_STRUCTURE_FAST_SET_HPP* = 1

  type
    FastSet* = object
      universeSize*: int
      countValue: int
      levels*: seq[seq[uint64]]

  proc trailingZero(x: uint64): int {.inline.} =
    doAssert x != 0'u64

    var y = x

    while (y and 1'u64) == 0'u64:
      result.inc
      y = y shr 1

  proc highestBit(x: uint64): int {.inline.} =
    doAssert x != 0'u64

    var y = x

    while (y shr 1) != 0'u64:
      result.inc
      y = y shr 1

  proc initFastSet*(n: int): FastSet =
    ## Creates an empty set over the universe `[0, n)`.
    doAssert n >= 0

    result.universeSize = n
    result.countValue = 0

    var size = n

    while size > 0:
      let words = (size + 63) div 64
      result.levels.add newSeq[uint64](words)
      size = words

  proc initFastSet*(n: int, values: openArray[int]): FastSet =
    ## Creates a set containing `values`.
    result = initFastSet(n)

    for x in values:
      discard result.insert(x)

  proc len*(s: FastSet): int {.inline.} =
    ## Returns the number of stored integers.
    s.countValue

  proc empty*(s: FastSet): bool {.inline.} =
    s.countValue == 0

  proc contains*(s: FastSet, x: int): bool {.inline.} =
    ## Returns whether `x` is present.
    if x < 0 or x >= s.universeSize or s.levels.len == 0:
      return false

    let
      word = x shr 6
      bit = x and 63

    ((s.levels[0][word] shr bit) and 1'u64) != 0'u64

  proc insert*(s: var FastSet, x: int): bool =
    ## Inserts `x`.
    ##
    ## Returns `true` iff `x` was newly inserted.
    doAssert 0 <= x and x < s.universeSize

    if x in s:
      return false

    var i = x

    for h in 0 ..< s.levels.len:
      let
        word = i shr 6
        bit = i and 63

      s.levels[h][word] =
        s.levels[h][word] or (1'u64 shl bit)

      i = word

    s.countValue.inc
    true

  proc incl*(s: var FastSet, x: int) =
    ## Set-like alias of `insert`.
    discard s.insert(x)

  proc erase*(s: var FastSet, x: int): bool =
    ## Erases `x`.
    ##
    ## Returns `true` iff `x` existed.
    if x notin s:
      return false

    var i = x

    for h in 0 ..< s.levels.len:
      let
        word = i shr 6
        bit = i and 63

      s.levels[h][word] =
        s.levels[h][word] and not (1'u64 shl bit)

      if s.levels[h][word] != 0'u64:
        break

      i = word

    s.countValue.dec
    true

  proc excl*(s: var FastSet, x: int) =
    ## Set-like alias of `erase`.
    discard s.erase(x)

  proc nextGE*(s: FastSet, x: int): int =
    ## Returns the minimum stored value `>= x`, or `-1` if absent.
    if s.empty or x >= s.universeSize:
      return -1

    var i = max(0, x)

    for h in 0 ..< s.levels.len:
      let word = i shr 6

      if word >= s.levels[h].len:
        return -1

      let
        shift = i and 63
        candidates = s.levels[h][word] shr shift

      if candidates == 0'u64:
        i = word + 1
        continue

      i += trailingZero(candidates)

      if h > 0:
        for g in countdown(h - 1, 0):
          let bits = s.levels[g][i]

          doAssert bits != 0'u64

          i = i * 64 + trailingZero(bits)

      if i < s.universeSize:
        return i

      return -1

    -1

  proc lowerBound*(s: FastSet, x: int): int =
    ## Alias of `nextGE`.
    s.nextGE(x)

  proc upperBound*(s: FastSet, x: int): int =
    ## Returns the minimum stored value `> x`, or `-1`.
    if x >= s.universeSize - 1:
      return -1

    s.nextGE(x + 1)

  proc prevLE*(s: FastSet, x: int): int =
    ## Returns the maximum stored value `<= x`, or `-1` if absent.
    if s.empty or x < 0:
      return -1

    var i = min(x, s.universeSize - 1)

    for h in 0 ..< s.levels.len:
      if i < 0:
        return -1

      let
        word = i shr 6
        shift = i and 63

      if word >= s.levels[h].len:
        i = s.levels[h].len - 1

      let
        actualWord = i shr 6
        actualShift = i and 63
        mask =
          if actualShift == 63:
            high(uint64)
          else:
            (1'u64 shl (actualShift + 1)) - 1'u64
        candidates = s.levels[h][actualWord] and mask

      if candidates == 0'u64:
        i = actualWord - 1
        continue

      i = actualWord * 64 + highestBit(candidates)

      if h > 0:
        for g in countdown(h - 1, 0):
          let bits = s.levels[g][i]

          doAssert bits != 0'u64

          i = i * 64 + highestBit(bits)

      if i < s.universeSize:
        return i

      return -1

    -1

  proc prevLT*(s: FastSet, x: int): int =
    ## Returns the maximum stored value `< x`, or `-1`.
    if x <= 0:
      return -1

    s.prevLE(x - 1)

  proc minValue*(s: FastSet): int =
    ## Returns the minimum value, or `-1` for an empty set.
    s.nextGE(0)

  proc maxValue*(s: FastSet): int =
    ## Returns the maximum value, or `-1` for an empty set.
    s.prevLE(s.universeSize - 1)

  iterator items*(s: FastSet): int =
    ## Iterates through values in ascending order.
    var x = s.nextGE(0)

    while x >= 0:
      yield x

      if x + 1 >= s.universeSize:
        break

      x = s.nextGE(x + 1)
