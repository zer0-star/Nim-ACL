discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/string/kmp

test "prefix function":
  check prefixFunction("ababcabab") ==
    @[0, 0, 1, 2, 0, 1, 2, 3, 4]

  check prefixFunction("aaaa") ==
    @[0, 1, 2, 3]

test "KMP overlapping string matches":
  let matcher = initKMP("aba")

  check matcher.findAll("ababa") == @[0, 2]
  check matcher.findFirst("zzabazz") == 2
  check matcher.findFirst("xxxxx") == -1
  check matcher.countMatches("abababa") == 3

  check matcher.contains("xxabayy")
  check "xxabayy" in matcher
  check "xxxxx" notin matcher

test "KMP generic sequence":
  let matcher = initKMP(@[1, 2, 1])

  check matcher.findAll(@[1, 2, 1, 2, 1]) == @[0, 2]
  check matcher.findFirst(@[0, 1, 2, 1]) == 1
  check matcher.countMatches(@[1, 2, 1, 2, 1]) == 2

test "KMP one-character pattern":
  let matcher = initKMP("a")

  check matcher.findAll("banana") == @[1, 3, 5]
