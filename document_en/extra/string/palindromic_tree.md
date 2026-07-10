# PalindromicTree / Eertree

`PalindromicTree`, also called `Eertree`, stores each distinct palindromic substring as a state.

Manacher computes palindrome radii around centers, while a Palindromic Tree represents distinct palindromes and their suffix relations.

## Use cases

- counting distinct palindromic substrings
- occurrence counts of each palindrome
- maintaining palindromes while appending characters
- DP over palindromic suffixes
- longest palindromic substring

## Import and construction

~~~nim
import atcoder/extra/string/palindromic_tree

proc initPalindromicTree(): PalindromicTree
proc initPalindromicTree(s: string): PalindromicTree
proc add(pt: var PalindromicTree, ch: char): int
proc buildOccurrences(pt: var PalindromicTree)
~~~

## Operations

~~~nim
proc distinctPalindromeCount(pt: PalindromicTree): int
proc totalPalindromeOccurrences(pt: PalindromicTree): int
proc palindromes(pt: PalindromicTree): seq[string]
proc longestPalindromeRange(pt: PalindromicTree): tuple[l, r: int]
proc longestPalindromeLength(pt: PalindromicTree): int
~~~

## Example

<!-- nim-line-numbers -->
~~~nim
let pt = initPalindromicTree("ababa")

doAssert pt.distinctPalindromeCount == 5
doAssert pt.totalPalindromeOccurrences == 9
doAssert pt.longestPalindromeLength == 5
~~~

## Manacher or Palindromic Tree?

- palindrome radii and range checks: `Manacher`
- distinct palindromes, counts, suffix relations: `PalindromicTree`

## Complexity

- build: expected `O(n)`
- nodes: at most `n+2`
- memory: `O(n)`
