when not declared ATCODER_EXTRA_STRING_MINIMUM_ROTATION_HPP:
  const ATCODER_EXTRA_STRING_MINIMUM_ROTATION_HPP* = 1

  proc rotationIndexImpl[T](
    s: openArray[T],
    maximize: bool
  ): int =
    let n = s.len

    if n == 0:
      return 0

    var
      i = 0
      j = 1
      k = 0

    while i < n and j < n and k < n:
      let
        a = s[(i + k) mod n]
        b = s[(j + k) mod n]

      if a == b:
        k.inc
        continue

      var iLoses: bool

      if maximize:
        iLoses = a < b
      else:
        iLoses = b < a

      if iLoses:
        i += k + 1

        if i == j:
          i.inc
      else:
        j += k + 1

        if i == j:
          j.inc

      k = 0

    min(i, j)

  proc minimumRotationIndex*[T](
    s: openArray[T]
  ): int =
    ## Returns the starting index of the lexicographically minimum rotation.
    rotationIndexImpl(s, false)

  proc minimalRotationIndex*[T](
    s: openArray[T]
  ): int =
    ## Alias of `minimumRotationIndex`.
    minimumRotationIndex(s)

  proc maximumRotationIndex*[T](
    s: openArray[T]
  ): int =
    ## Returns the starting index of the lexicographically maximum rotation.
    rotationIndexImpl(s, true)

  proc rotated*[T](
    s: openArray[T],
    start: int
  ): seq[T] =
    ## Returns the rotation starting at `start`.
    let n = s.len

    if n == 0:
      return @[]

    doAssert 0 <= start and start < n

    result = newSeq[T](n)

    for i in 0 ..< n:
      result[i] = s[(start + i) mod n]

  proc minimumRotation*[T](
    s: openArray[T]
  ): seq[T] =
    ## Returns the lexicographically minimum rotation.
    s.rotated(s.minimumRotationIndex())

  proc maximumRotation*[T](
    s: openArray[T]
  ): seq[T] =
    ## Returns the lexicographically maximum rotation.
    s.rotated(s.maximumRotationIndex())

  proc minimumRotationIndex*(s: string): int =
    ## String overload.
    var a = newSeq[char](s.len)

    for i in 0 ..< s.len:
      a[i] = s[i]

    minimumRotationIndex[char](a)

  proc minimalRotationIndex*(s: string): int =
    ## String alias.
    minimumRotationIndex(s)

  proc maximumRotationIndex*(s: string): int =
    ## String overload.
    var a = newSeq[char](s.len)

    for i in 0 ..< s.len:
      a[i] = s[i]

    maximumRotationIndex[char](a)

  proc rotateString(s: string, start: int): string =
    if s.len == 0:
      return ""

    result = newString(s.len)

    for i in 0 ..< s.len:
      result[i] = s[(start + i) mod s.len]

  proc minimumRotation*(s: string): string =
    ## Returns the lexicographically minimum string rotation.
    s.rotateString(s.minimumRotationIndex())

  proc maximumRotation*(s: string): string =
    ## Returns the lexicographically maximum string rotation.
    s.rotateString(s.maximumRotationIndex())
