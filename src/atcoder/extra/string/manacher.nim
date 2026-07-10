when not declared ATCODER_EXTRA_STRING_MANACHER_HPP:
  const ATCODER_EXTRA_STRING_MANACHER_HPP* = 1

  type
    Manacher*[T] = object
      s*: seq[T]
      odd*: seq[int]
      even*: seq[int]

  proc toCharSeq(s: string): seq[char] =
    result = newSeq[char](s.len)
    for i in 0 ..< s.len:
      result[i] = s[i]

  proc manacherOdd*[T](s: openArray[T]): seq[int] =
    ## Returns odd palindrome radii.
    ##
    ## `result[i] = r` means `s[i-r+1 .. i+r-1]` is a palindrome.
    let n = s.len
    result = newSeq[int](n)

    var
      l = 0
      r = -1

    for i in 0 ..< n:
      var k =
        if i > r:
          1
        else:
          min(result[l + r - i], r - i + 1)

      while 0 <= i - k and i + k < n and s[i - k] == s[i + k]:
        k.inc

      result[i] = k

      if i + k - 1 > r:
        l = i - k + 1
        r = i + k - 1

  proc manacherOdd*(s: string): seq[int] =
    let a = toCharSeq(s)
    manacherOdd[char](a)

  proc manacherEven*[T](s: openArray[T]): seq[int] =
    ## Returns even palindrome radii.
    ##
    ## `result[i] = r` means `s[i-r .. i+r-1]` is a palindrome.
    ## The center is between `i-1` and `i`.
    let n = s.len
    result = newSeq[int](n)

    var
      l = 0
      r = -1

    for i in 0 ..< n:
      var k =
        if i > r:
          0
        else:
          min(result[l + r - i + 1], r - i + 1)

      while 0 <= i - k - 1 and i + k < n and s[i - k - 1] == s[i + k]:
        k.inc

      result[i] = k

      if i + k - 1 > r:
        l = i - k
        r = i + k - 1

  proc manacherEven*(s: string): seq[int] =
    let a = toCharSeq(s)
    manacherEven[char](a)

  proc palindromeRadii*[T](s: openArray[T]): tuple[odd, even: seq[int]] =
    ## Returns both odd and even palindrome radii.
    result.odd = manacherOdd(s)
    result.even = manacherEven(s)

  proc palindromeRadii*(s: string): tuple[odd, even: seq[int]] =
    let a = toCharSeq(s)
    palindromeRadii[char](a)

  proc initManacher*[T](s: openArray[T]): Manacher[T] =
    ## Builds Manacher radii for `s`.
    result.s = newSeq[T](s.len)

    for i in 0 ..< s.len:
      result.s[i] = s[i]

    result.odd = manacherOdd(s)
    result.even = manacherEven(s)

  proc initManacher*(s: string): Manacher[char] =
    let a = toCharSeq(s)
    initManacher[char](a)

  proc len*[T](m: Manacher[T]): int {.inline.} =
    m.s.len

  proc isPalindrome*[T](m: Manacher[T], l, r: int): bool =
    ## Returns whether `m.s[l ..< r]` is a palindrome.
    doAssert 0 <= l and l <= r and r <= m.len

    let n = r - l

    if n <= 1:
      return true

    if (n and 1) == 1:
      let center = (l + r - 1) div 2
      m.odd[center] >= (n + 1) div 2
    else:
      let center = (l + r) div 2
      m.even[center] >= n div 2

  proc longestPalindromeRange*[T](m: Manacher[T]): tuple[l, r: int] =
    ## Returns one longest palindromic substring as a half-open range `[l, r)`.
    result = (l: 0, r: 0)

    for i, radius in m.odd:
      let length = 2 * radius - 1

      if length > result.r - result.l:
        result = (l: i - radius + 1, r: i + radius)

    for i, radius in m.even:
      let length = 2 * radius

      if length > result.r - result.l:
        result = (l: i - radius, r: i + radius)

  proc longestPalindromeLength*[T](m: Manacher[T]): int =
    ## Returns the length of a longest palindromic substring.
    let r = m.longestPalindromeRange()
    r.r - r.l

  proc countPalindromicSubstrings*[T](m: Manacher[T]): int =
    ## Returns the number of palindromic substrings.
    for x in m.odd:
      result += x

    for x in m.even:
      result += x

  proc countPalindromes*[T](m: Manacher[T]): int =
    ## Alias of `countPalindromicSubstrings`.
    m.countPalindromicSubstrings()
