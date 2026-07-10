discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import std/algorithm
import atcoder/extra/string/palindromic_tree

test "PalindromicTree ababa":
  let pt = initPalindromicTree("ababa")

  check pt.distinctPalindromeCount == 5
  check pt.totalPalindromeOccurrences == 9
  check pt.longestPalindromeLength == 5
  check pt.longestPalindromeRange == (l: 0, r: 5)

  var ps = pt.palindromes()
  ps.sort()

  check ps == @["a", "aba", "ababa", "b", "bab"]

test "PalindromicTree repeated character":
  let pt = initPalindromicTree("aaaa")

  check pt.distinctPalindromeCount == 4
  check pt.totalPalindromeOccurrences == 10
  check pt.longestPalindromeLength == 4

  var counts: seq[(string, int)] = @[]

  for node in 2 ..< pt.nodes.len:
    counts.add((pt.palindrome(node), pt.nodes[node].occurrences))

  counts.sort(proc(a, b: (string, int)): int = cmp(a[0], b[0]))

  check counts == @[
    ("a", 4),
    ("aa", 3),
    ("aaa", 2),
    ("aaaa", 1),
  ]

test "PalindromicTree incremental construction":
  var pt = initPalindromicTree()

  pt.add("racecar")
  pt.buildOccurrences()

  check pt.distinctPalindromeCount == 7
  check pt.totalPalindromeOccurrences == 10
  check pt.longestPalindromeLength == 7

  let r = pt.longestPalindromeRange
  check r == (l: 0, r: 7)

test "PalindromicTree empty string":
  let pt = initPalindromicTree("")

  check pt.len == 2
  check pt.distinctPalindromeCount == 0
  check pt.totalPalindromeOccurrences == 0
  check pt.longestPalindromeRange == (l: 0, r: 0)
