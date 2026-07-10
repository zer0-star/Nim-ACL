discard """
  cmd: "nim cpp -r $file"
"""

import std/[random, sets, unittest]

import atcoder/extra/string/suffix_automaton

proc randomString(
    rng: var Rand,
    length: int,
): string =
  result = newString(length)

  for i in 0 ..< length:
    result[i] = char(
      ord('a') + rand(rng, 0 .. 2)
    )

proc matchesAt(
    text: string,
    pattern: string,
    start: int,
): bool =
  if start < 0:
    return false

  if start + pattern.len > text.len:
    return false

  for i in 0 ..< pattern.len:
    if text[start + i] != pattern[i]:
      return false

  true

proc bruteContains(
    text: string,
    pattern: string,
): bool =
  if pattern.len == 0:
    return true

  if pattern.len > text.len:
    return false

  for start in 0 .. text.len - pattern.len:
    if matchesAt(text, pattern, start):
      return true

  false

proc bruteOccurrences(
    text: string,
    pattern: string,
): int =
  doAssert pattern.len > 0

  if pattern.len > text.len:
    return 0

  for start in 0 .. text.len - pattern.len:
    if matchesAt(text, pattern, start):
      result.inc

proc bruteDistinctSubstringCount(
    text: string,
): int64 =
  var found = initHashSet[string]()

  for l in 0 ..< text.len:
    for r in l + 1 .. text.len:
      found.incl(text[l ..< r])

  int64(found.len)

proc bruteLongestCommonSubstringLength(
    first: string,
    second: string,
): int =
  for l in 0 ..< second.len:
    for r in l + 1 .. second.len:
      let candidate = second[l ..< r]

      if (
        candidate.len > result and
        bruteContains(first, candidate)
      ):
        result = candidate.len

test "SuffixAutomaton randomized differential queries":
  var rng = initRand(0x53414D26)

  for caseId in 0 ..< 360:
    let text = randomString(
      rng,
      rand(rng, 0 .. 12),
    )

    let sam = initSuffixAutomaton(text)

    var incremental = initSuffixAutomaton()
    incremental.add(text)
    incremental.buildOccurrences()

    check sam.textLength == text.len
    check incremental.textLength == text.len

    check sam.distinctSubstringCount ==
      bruteDistinctSubstringCount(text)

    check incremental.distinctSubstringCount ==
      sam.distinctSubstringCount

    for queryId in 0 ..< 90:
      let pattern = randomString(
        rng,
        rand(rng, 0 .. 7),
      )

      let expectedContains = bruteContains(
        text,
        pattern,
      )

      check sam.contains(pattern) ==
        expectedContains

      check incremental.contains(pattern) ==
        expectedContains

      check (sam.stateFor(pattern) >= 0) ==
        expectedContains

      if pattern.len > 0:
        let expectedOccurrences =
          bruteOccurrences(
            text,
            pattern,
          )

        check sam.occurrenceCount(pattern) ==
          expectedOccurrences

        check incremental.occurrenceCount(
          pattern
        ) == expectedOccurrences

    let other = randomString(
      rng,
      rand(rng, 0 .. 14),
    )

    let expectedLength =
      bruteLongestCommonSubstringLength(
        text,
        other,
      )

    let answer = sam.longestCommonSubstring(
      other
    )

    check answer.length == expectedLength
    check answer.r - answer.l ==
      answer.length
    check 0 <= answer.l
    check answer.l <= answer.r
    check answer.r <= other.len

    if answer.length > 0:
      let common = other[
        answer.l ..< answer.r
      ]

      check bruteContains(text, common)
