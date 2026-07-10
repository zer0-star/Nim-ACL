discard """
  cmd: "nim cpp -r $file"
"""

import std/[algorithm, random, unittest]

import atcoder/extra/string/aho_corasick

type
  MatchTuple = tuple[
    l: int,
    r: int,
    id: int,
  ]

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

proc bruteMatches(
    patterns: openArray[string],
    text: string,
): seq[MatchTuple] =
  for id, pattern in patterns:
    if pattern.len > text.len:
      continue

    for start in 0 .. text.len - pattern.len:
      if matchesAt(text, pattern, start):
        result.add(
          (
            l: start,
            r: start + pattern.len,
            id: id,
          )
        )

  result.sort(
    proc(
        a: MatchTuple,
        b: MatchTuple,
    ): int =
      result = cmp(a.l, b.l)

      if result != 0:
        return

      result = cmp(a.r, b.r)

      if result != 0:
        return

      result = cmp(a.id, b.id)
  )

proc normalized(
    matches: openArray[AhoCorasickMatch],
): seq[MatchTuple] =
  for item in matches:
    result.add(
      (
        l: item.l,
        r: item.r,
        id: item.patternId,
      )
    )

  result.sort(
    proc(
        a: MatchTuple,
        b: MatchTuple,
    ): int =
      result = cmp(a.l, b.l)

      if result != 0:
        return

      result = cmp(a.r, b.r)

      if result != 0:
        return

      result = cmp(a.id, b.id)
  )

test "AhoCorasick randomized differential matching":
  var rng = initRand(0x41484F26)

  for caseId in 0 ..< 360:
    let patternCount = rand(rng, 1 .. 7)

    var patterns = newSeq[string](
      patternCount
    )

    for id in 0 ..< patternCount:
      patterns[id] = randomString(
        rng,
        rand(rng, 1 .. 6),
      )

    let text = randomString(
      rng,
      rand(rng, 0 .. 32),
    )

    let expected = bruteMatches(
      patterns,
      text,
    )

    let automatic = initAhoCorasick(
      patterns
    )

    var manual = initAhoCorasick()

    for pattern in patterns:
      discard manual.addPattern(pattern)

    manual.build()

    check automatic.patternCount ==
      patterns.len

    check manual.patternCount ==
      patterns.len

    check automatic.len == manual.len

    check automatic.findAll(text).normalized ==
      expected

    check manual.findAll(text).normalized ==
      expected

    check automatic.countMatches(text) ==
      expected.len

    check automatic.matchCount(text) ==
      expected.len

    check manual.countMatches(text) ==
      expected.len

    check automatic.contains(text) ==
      (expected.len > 0)

    check manual.contains(text) ==
      (expected.len > 0)

    var state = 0

    for ch in text:
      let byNext = automatic.nextState(
        state,
        ch,
      )

      let byAlias = automatic.transition(
        state,
        ch,
      )

      check byNext == byAlias
      state = byNext

    for item in automatic.findAll(text):
      check 0 <= item.patternId
      check item.patternId < patterns.len
      check item.r - item.l ==
        patterns[item.patternId].len

      check matchesAt(
        text,
        patterns[item.patternId],
        item.l,
      )
