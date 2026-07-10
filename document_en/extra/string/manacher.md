# Manacher

`Manacher` computes all palindrome radii in a string in linear time.

After preprocessing, palindrome checks for arbitrary substrings can be answered in `O(1)`.

## Use cases

Typical use cases include:

- longest palindromic substring
- counting palindromic substrings
- many queries asking whether `s[l ..< r]` is a palindrome
- speeding up DP involving palindromes
- problems based on symmetry in strings

## Idea

A naive approach expands around every center and can take `O(n^2)` time.

Manacher reuses an already known palindrome interval `[l, r]`.  
If the current position `i` is inside that interval, the radius of the mirrored position `l + r - i` gives a lower bound.  
Then it only compares characters outside the already known region.

Each character is newly compared only a constant number of times in total, so the whole algorithm runs in `O(n)`.

## Odd and even radii

This module stores odd-length and even-length palindromes separately.

```nim
odd[i] = r
```

means that the odd palindrome centered at `i`

```text
s[i-r+1 .. i+r-1]
```

exists. Its length is `2*r - 1`.

```nim
even[i] = r
```

means that the even palindrome centered between `i-1` and `i`

```text
s[i-r .. i+r-1]
```

exists. Its length is `2*r`.

## Import

~~~nim
import atcoder/extra/string/manacher
~~~

## Type

~~~nim
type Manacher[T]
~~~

For `string`, `Manacher[char]` is constructed.  
It also works for general sequences such as `seq[int]`.

## Constructors

~~~nim
proc initManacher[T](s: openArray[T]): Manacher[T]
proc initManacher(s: string): Manacher[char]
~~~

## Radius helpers

~~~nim
proc manacherOdd[T](s: openArray[T]): seq[int]
proc manacherOdd(s: string): seq[int]

proc manacherEven[T](s: openArray[T]): seq[int]
proc manacherEven(s: string): seq[int]

proc palindromeRadii[T](s: openArray[T]): tuple[odd, even: seq[int]]
proc palindromeRadii(s: string): tuple[odd, even: seq[int]]
~~~

## Operations

~~~nim
proc len[T](m: Manacher[T]): int

proc isPalindrome[T](m: Manacher[T], l, r: int): bool
proc longestPalindromeRange[T](m: Manacher[T]): tuple[l, r: int]
proc longestPalindromeLength[T](m: Manacher[T]): int

proc countPalindromicSubstrings[T](m: Manacher[T]): int
proc countPalindromes[T](m: Manacher[T]): int
~~~

- `isPalindrome(l, r)` checks whether `s[l ..< r]` is a palindrome.
- `longestPalindromeRange()` returns a half-open range `[l, r)` of one longest palindromic substring.
- `longestPalindromeLength()` returns the longest palindromic substring length.
- `countPalindromicSubstrings()` returns the number of palindromic substrings.

## Example

<!-- nim-line-numbers -->
~~~nim
let m = initManacher("ababa")

doAssert m.odd == @[1, 2, 3, 2, 1]
doAssert m.even == @[0, 0, 0, 0, 0]

doAssert m.isPalindrome(0, 5)
doAssert m.isPalindrome(1, 4)
doAssert not m.isPalindrome(0, 4)

doAssert m.longestPalindromeLength == 5
doAssert m.longestPalindromeRange == (l: 0, r: 5)

doAssert m.countPalindromicSubstrings == 9
~~~

Even-length palindromes are also supported.

<!-- nim-line-numbers -->
~~~nim
let m = initManacher("abba")

doAssert m.odd == @[1, 1, 1, 1]
doAssert m.even == @[0, 0, 2, 0]

doAssert m.isPalindrome(0, 4)
doAssert m.longestPalindromeLength == 4
~~~

## Nim-friendly usage

`Manacher` works not only for strings but also for comparable sequences.

~~~nim
let m = initManacher(@[1, 2, 1, 2, 1])

doAssert m.isPalindrome(0, 5)
doAssert m.longestPalindromeLength == 5
~~~

UFCS makes queries readable.

~~~nim
if m.isPalindrome(l, r):
  echo "palindrome"
~~~

## Complexity

For string length `n`:

- build: `O(n)`
- `isPalindrome`: `O(1)`
- `longestPalindromeLength`: `O(n)`
- `longestPalindromeRange`: `O(n)`
- `countPalindromicSubstrings`: `O(n)`
- memory: `O(n)`

## Notes

- All ranges are half-open ranges `[l, r)`.
- Be careful that `odd` and `even` radii have different meanings.
- `countPalindromicSubstrings` can be `O(n^2)` in value. The return type is `int`.

## Related resources and libraries

- cp-algorithms: Manacher's Algorithm
- Library Checker: palindrome / string problems
- Nyaan Library: Manacher
- ei1333 Library: Manacher
