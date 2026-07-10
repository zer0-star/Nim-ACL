# SuffixAutomaton

`SuffixAutomaton` is the minimal DFA accepting all substrings of one string.

For a string of length `n`, it has at most `2n-1` states and supports substring membership, occurrence counts, distinct-substring counting, and longest common substring queries.

## Use cases

- checking whether a pattern is a substring
- counting pattern occurrences
- counting distinct substrings
- longest common substring of two strings
- DP over substring states

## Idea

Each state represents substrings sharing the same set of end positions.

A suffix link points to the state corresponding to the longest proper suffix. When a character is appended, states and suffix links are updated, with cloning when necessary.

The number of new substrings represented by state `v` is:

```text
len[v] - len[link[v]]
```

## Import and construction

~~~nim
import atcoder/extra/string/suffix_automaton

proc initSuffixAutomaton(): SuffixAutomaton
proc initSuffixAutomaton(s: string): SuffixAutomaton
proc extend(sam: var SuffixAutomaton, ch: char): int
proc add(sam: var SuffixAutomaton, s: string)
proc buildOccurrences(sam: var SuffixAutomaton)
~~~

## Operations

~~~nim
proc contains(sam: SuffixAutomaton, pattern: string): bool
proc occurrenceCount(sam: SuffixAutomaton, pattern: string): int
proc distinctSubstringCount(sam: SuffixAutomaton): int64

proc longestCommonSubstring(
  sam: SuffixAutomaton,
  text: string
): tuple[length, l, r: int]
~~~

## Example

<!-- nim-line-numbers -->
~~~nim
let sam = initSuffixAutomaton("ababa")

doAssert "aba" in sam
doAssert sam.occurrenceCount("aba") == 2
doAssert sam.distinctSubstringCount == 9
~~~

## Complexity

- build: `O(n)`
- membership/count query: `O(|pattern|)`
- longest common substring: `O(|text|)`
- states: at most `2n-1`

## Related resources and libraries

- [cp-algorithms: Suffix Automaton](https://cp-algorithms.com/string/suffix-automaton.html)
- Nyaan Library: Suffix Automaton
- ei1333 Library: Suffix Automaton
