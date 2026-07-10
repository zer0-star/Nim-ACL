discard """
  cmd: "nim cpp -r $file"
"""

import std/[random, unittest]

import atcoder/extra/string/kmp

proc randomString(rng: var Rand, n: int): string =
  result = newString(n)

  for i in 0 ..< n:
    result[i] = char(ord('a') + rand(rng, 0 .. 2))

proc randomIntSequence(rng: var Rand, n: int): seq[int] =
  result = newSeq[int](n)

  for i in 0 ..< n:
    result[i] = rand(rng, 0 .. 3)

proc bruteFindAll[T](
    text: openArray[T],
    pattern: openArray[T],
): seq[int] =
  doAssert pattern.len > 0

  if pattern.len > text.len:
    return

  for start in 0 .. text.len - pattern.len:
    var matches = true

    for i in 0 ..< pattern.len:
      if text[start + i] != pattern[i]:
        matches = false
        break

    if matches:
      result.add(start)

proc brutePrefixFunction[T](values: openArray[T]): seq[int] =
  result = newSeq[int](values.len)

  for i in 0 ..< values.len:
    for length in 1 .. i:
      var matches = true

      for j in 0 ..< length:
        if values[j] != values[i - length + 1 + j]:
          matches = false
          break

      if matches:
        result[i] = length

test "KMP randomized differential strings":
  var rng = initRand(0x4B4D5026)

  for caseId in 0 ..< 500:
    let text = randomString(rng, rand(rng, 0 .. 32))
    let pattern = randomString(rng, rand(rng, 1 .. 9))
    let expected = bruteFindAll(text, pattern)
    let matcher = initKMP(pattern)

    check matcher.findAll(text) == expected
    check matcher.countMatches(text) == expected.len
    check matcher.findFirst(text) == (
      if expected.len == 0:
        -1
      else:
        expected[0]
    )
    check matcher.contains(text) == (expected.len > 0)
    check prefixFunction(text) == brutePrefixFunction(text)

test "KMP randomized differential generic integer sequences":
  var rng = initRand(0x53455126)

  for caseId in 0 ..< 320:
    let text = randomIntSequence(rng, rand(rng, 0 .. 28))
    let pattern = randomIntSequence(rng, rand(rng, 1 .. 8))
    let expected = bruteFindAll(text, pattern)
    let matcher = initKMP(pattern)

    check matcher.findAll(text) == expected
    check matcher.countMatches(text) == expected.len
    check matcher.findFirst(text) == (
      if expected.len == 0:
        -1
      else:
        expected[0]
    )
    check prefixFunction(text) == brutePrefixFunction(text)
