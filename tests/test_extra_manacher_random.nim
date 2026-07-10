discard """
  cmd: "nim cpp -r $file"
"""

import std/[random, unittest]

import atcoder/extra/string/manacher

proc randomString(rng: var Rand, n: int): string =
  result = newString(n)

  for i in 0 ..< n:
    result[i] = char(ord('a') + rand(rng, 0 .. 3))

proc randomIntSequence(rng: var Rand, n: int): seq[int] =
  result = newSeq[int](n)

  for i in 0 ..< n:
    result[i] = rand(rng, 0 .. 3)

proc bruteIsPalindrome[T](
    values: openArray[T],
    l: int,
    r: int,
): bool =
  var left = l
  var right = r - 1

  while left < right:
    if values[left] != values[right]:
      return false

    left.inc
    right.dec

  true

proc bruteOddRadii[T](values: openArray[T]): seq[int] =
  result = newSeq[int](values.len)

  for center in 0 ..< values.len:
    var radius = 1

    while (
      center - radius >= 0 and
      center + radius < values.len and
      values[center - radius] == values[center + radius]
    ):
      radius.inc

    result[center] = radius

proc bruteEvenRadii[T](values: openArray[T]): seq[int] =
  result = newSeq[int](values.len)

  for center in 0 ..< values.len:
    var radius = 0

    while (
      center - radius - 1 >= 0 and
      center + radius < values.len and
      values[center - radius - 1] == values[center + radius]
    ):
      radius.inc

    result[center] = radius

proc brutePalindromeStatistics[T](
    values: openArray[T],
): tuple[count: int, longest: int] =
  for l in 0 ..< values.len:
    for r in l + 1 .. values.len:
      if bruteIsPalindrome(values, l, r):
        result.count.inc
        result.longest = max(result.longest, r - l)

test "Manacher randomized differential strings":
  var rng = initRand(0x4D414E26)

  for caseId in 0 ..< 420:
    let text = randomString(rng, rand(rng, 0 .. 28))
    let manacher = initManacher(text)
    let statistics = brutePalindromeStatistics(text)

    check manacher.odd == bruteOddRadii(text)
    check manacher.even == bruteEvenRadii(text)
    check manacherOdd(text) == bruteOddRadii(text)
    check manacherEven(text) == bruteEvenRadii(text)
    check manacher.countPalindromicSubstrings == statistics.count
    check manacher.countPalindromes == statistics.count
    check manacher.longestPalindromeLength == statistics.longest

    for l in 0 .. text.len:
      for r in l .. text.len:
        check manacher.isPalindrome(l, r) ==
          bruteIsPalindrome(text, l, r)

test "Manacher randomized differential generic integer sequences":
  var rng = initRand(0x494E5426)

  for caseId in 0 ..< 260:
    let values = randomIntSequence(rng, rand(rng, 0 .. 24))
    let manacher = initManacher(values)
    let statistics = brutePalindromeStatistics(values)

    check manacher.odd == bruteOddRadii(values)
    check manacher.even == bruteEvenRadii(values)
    check manacher.countPalindromicSubstrings == statistics.count
    check manacher.longestPalindromeLength == statistics.longest

    for l in 0 .. values.len:
      for r in l .. values.len:
        check manacher.isPalindrome(l, r) ==
          bruteIsPalindrome(values, l, r)
