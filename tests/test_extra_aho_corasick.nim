discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import std/algorithm
import atcoder/extra/string/aho_corasick

type MatchTuple = tuple[l, r, id: int]

proc toTuples(matches: seq[AhoCorasickMatch]): seq[MatchTuple] =
  for m in matches:
    result.add (l: m.l, r: m.r, id: m.patternId)

  result.sort(proc(a, b: MatchTuple): int =
    result = cmp(a.l, b.l)
    if result != 0: return

    result = cmp(a.r, b.r)
    if result != 0: return

    result = cmp(a.id, b.id)
  )

test "AhoCorasick basic multiple patterns":
  var ac = initAhoCorasick()

  let
    he = ac.addPattern("he")
    she = ac.addPattern("she")
    his = ac.addPattern("his")
    hers = ac.addPattern("hers")

  ac.build()

  check ac.patternCount == 4
  check ac.len >= 1

  let matches = ac.findAll("ushers").toTuples()

  check matches == @[
    (l: 1, r: 4, id: she),
    (l: 2, r: 4, id: he),
    (l: 2, r: 6, id: hers),
  ]

  check ac.countMatches("ushers") == 3
  check ac.matchCount("ushers") == 3
  check ac.contains("ushers")
  check "ushers" in ac
  check not ac.contains("abc")

  discard his

test "AhoCorasick overlapping matches":
  let ac = initAhoCorasick(@["a", "aa", "aaa"])

  let matches = ac.findAll("aaaa").toTuples()

  check matches == @[
    (l: 0, r: 1, id: 0),
    (l: 0, r: 2, id: 1),
    (l: 0, r: 3, id: 2),
    (l: 1, r: 2, id: 0),
    (l: 1, r: 3, id: 1),
    (l: 1, r: 4, id: 2),
    (l: 2, r: 3, id: 0),
    (l: 2, r: 4, id: 1),
    (l: 3, r: 4, id: 0),
  ]

  check ac.countMatches("aaaa") == 9

test "AhoCorasick constructor and transitions":
  let ac = initAhoCorasick(@["ab", "bc"])

  var state = 0
  state = ac.transition(state, 'a')
  state = ac.transition(state, 'b')

  check ac.nodes[state].`out` == @[0]

  state = ac.transition(state, 'c')

  check 1 in ac.nodes[state].`out`
  check ac.countMatches("abc") == 2
  check ac.contains("xxabyy")
  check not ac.contains("acac")

test "AhoCorasick suffix patterns":
  let ac = initAhoCorasick(@["abcd", "bcd", "cd", "d"])

  let matches = ac.findAll("abcd").toTuples()

  check matches == @[
    (l: 0, r: 4, id: 0),
    (l: 1, r: 4, id: 1),
    (l: 2, r: 4, id: 2),
    (l: 3, r: 4, id: 3),
  ]

  check ac.countMatches("abcd") == 4
