when not declared ATCODER_EXTRA_STRING_KMP_HPP:
  const ATCODER_EXTRA_STRING_KMP_HPP* = 1

  type
    KMPMatcher*[T] = object
      pattern*: seq[T]
      prefix*: seq[int]

  proc toCharSeq(s: string): seq[char] =
    result = newSeq[char](s.len)

    for i in 0 ..< s.len:
      result[i] = s[i]

  proc prefixFunction*[T](s: openArray[T]): seq[int] =
    ## Returns the prefix-function array.
    ##
    ## `result[i]` is the length of the longest proper prefix of
    ## `s[0 .. i]` that is also a suffix.
    result = newSeq[int](s.len)

    for i in 1 ..< s.len:
      var j = result[i - 1]

      while j > 0 and s[i] != s[j]:
        j = result[j - 1]

      if s[i] == s[j]:
        j.inc

      result[i] = j

  proc prefixFunction*(s: string): seq[int] =
    let a = toCharSeq(s)
    prefixFunction[char](a)

  proc initKMP*[T](pattern: openArray[T]): KMPMatcher[T] =
    ## Builds a KMP matcher for a non-empty pattern.
    doAssert pattern.len > 0

    result.pattern = newSeq[T](pattern.len)

    for i in 0 ..< pattern.len:
      result.pattern[i] = pattern[i]

    result.prefix = prefixFunction(pattern)

  proc initKMP*(pattern: string): KMPMatcher[char] =
    let a = toCharSeq(pattern)
    initKMP[char](a)

  proc findAll*[T](
    matcher: KMPMatcher[T],
    text: openArray[T]
  ): seq[int] =
    ## Returns all starting positions, including overlapping matches.
    let m = matcher.pattern.len

    doAssert m > 0

    var j = 0

    for i in 0 ..< text.len:
      while j > 0 and text[i] != matcher.pattern[j]:
        j = matcher.prefix[j - 1]

      if text[i] == matcher.pattern[j]:
        j.inc

      if j == m:
        result.add i - m + 1
        j = matcher.prefix[j - 1]

  proc findAll*(
    matcher: KMPMatcher[char],
    text: string
  ): seq[int] =
    let a = toCharSeq(text)
    matcher.findAll(a)

  proc findFirst*[T](
    matcher: KMPMatcher[T],
    text: openArray[T]
  ): int =
    ## Returns the first starting position, or `-1`.
    let matches = matcher.findAll(text)

    if matches.len == 0:
      -1
    else:
      matches[0]

  proc findFirst*(
    matcher: KMPMatcher[char],
    text: string
  ): int =
    let a = toCharSeq(text)
    matcher.findFirst(a)

  proc countMatches*[T](
    matcher: KMPMatcher[T],
    text: openArray[T]
  ): int =
    ## Returns the number of occurrences, including overlaps.
    matcher.findAll(text).len

  proc countMatches*(
    matcher: KMPMatcher[char],
    text: string
  ): int =
    let a = toCharSeq(text)
    matcher.countMatches(a)

  proc contains*[T](
    matcher: KMPMatcher[T],
    text: openArray[T]
  ): bool =
    matcher.findFirst(text) >= 0

  proc contains*(
    matcher: KMPMatcher[char],
    text: string
  ): bool =
    matcher.findFirst(text) >= 0
