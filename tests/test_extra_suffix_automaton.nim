discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/string/suffix_automaton

test "SuffixAutomaton substring and occurrence queries":
  let sam = initSuffixAutomaton("ababa")

  check sam.contains("")
  check sam.contains("a")
  check sam.contains("aba")
  check sam.contains("baba")
  check not sam.contains("abb")

  check "ababa" in sam
  check "xyz" notin sam

  check sam.occurrenceCount("a") == 3
  check sam.occurrenceCount("b") == 2
  check sam.occurrenceCount("aba") == 2
  check sam.occurrenceCount("ababa") == 1
  check sam.occurrenceCount("xyz") == 0

  check sam.distinctSubstringCount == 9

test "SuffixAutomaton incremental construction":
  var sam = initSuffixAutomaton()

  for ch in "banana":
    discard sam.extend(ch)

  sam.buildOccurrences()

  check sam.textLength == 6
  check sam.contains("ana")
  check sam.contains("nana")
  check not sam.contains("apple")

  check sam.occurrenceCount("ana") == 2
  check sam.occurrenceCount("na") == 2
  check sam.occurrenceCount("banana") == 1

test "SuffixAutomaton longest common substring":
  let sam = initSuffixAutomaton("ababa")
  let ans = sam.longestCommonSubstring("zzbabc")

  check ans.length == 3
  check ans.l == 2
  check ans.r == 5
  check "zzbabc"[ans.l ..< ans.r] == "bab"

test "SuffixAutomaton distinct substrings":
  check initSuffixAutomaton("").distinctSubstringCount == 0
  check initSuffixAutomaton("aaa").distinctSubstringCount == 3
  check initSuffixAutomaton("abc").distinctSubstringCount == 6
