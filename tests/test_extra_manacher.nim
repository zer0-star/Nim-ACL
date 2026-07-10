discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/string/manacher

test "Manacher odd and even radii":
  let m = initManacher("ababa")

  check m.len == 5
  check m.odd == @[1, 2, 3, 2, 1]
  check m.even == @[0, 0, 0, 0, 0]

  check m.isPalindrome(0, 5)
  check m.isPalindrome(1, 4)
  check m.isPalindrome(0, 1)
  check m.isPalindrome(0, 0)
  check not m.isPalindrome(0, 4)

  check m.longestPalindromeLength == 5
  check m.longestPalindromeRange == (l: 0, r: 5)
  check m.countPalindromicSubstrings == 9
  check m.countPalindromes == 9

test "Manacher even palindrome":
  let m = initManacher("abba")

  check m.odd == @[1, 1, 1, 1]
  check m.even == @[0, 0, 2, 0]

  check m.isPalindrome(0, 4)
  check m.isPalindrome(1, 3)
  check not m.isPalindrome(0, 3)

  check m.longestPalindromeLength == 4
  check m.longestPalindromeRange == (l: 0, r: 4)
  check m.countPalindromicSubstrings == 6

test "Manacher all same characters":
  let m = initManacher("aaaa")

  check m.odd == @[1, 2, 2, 1]
  check m.even == @[0, 1, 2, 1]

  for l in 0 .. 4:
    for r in l .. 4:
      check m.isPalindrome(l, r)

  check m.longestPalindromeLength == 4
  check m.countPalindromicSubstrings == 10

test "Manacher generic sequence":
  let m = initManacher(@[1, 2, 1, 2, 1, 3])

  check m.odd[2] == 3
  check m.isPalindrome(0, 5)
  check not m.isPalindrome(0, 6)
  check m.longestPalindromeLength == 5

test "palindromeRadii helpers":
  let r1 = palindromeRadii("abba")

  check r1.odd == @[1, 1, 1, 1]
  check r1.even == @[0, 0, 2, 0]

  let r2 = palindromeRadii(@[1, 1, 1])

  check r2.odd == @[1, 2, 1]
  check r2.even == @[0, 1, 1]

test "manacherOdd and manacherEven helpers":
  check manacherOdd("abcba") == @[1, 1, 3, 1, 1]
  check manacherEven("abcba") == @[0, 0, 0, 0, 0]

  check manacherOdd("aabbaa") == @[1, 1, 1, 1, 1, 1]
  check manacherEven("aabbaa") == @[0, 1, 0, 3, 0, 1]
