# Aho-Corasick

`Aho-Corasick` is an algorithm for matching many patterns at once.

It inserts all patterns into a trie and adds failure links.  
Then a text can be scanned once to find occurrences of all registered patterns.

## Use cases

Typical use cases include:

- checking whether a text contains any forbidden string
- listing all occurrences of many patterns
- multiple pattern matching
- string DP with forbidden patterns
- cases where running KMP for each pattern is too slow

## Idea

First, insert all patterns into a trie.  
A trie node represents the current longest pattern prefix matched by the text suffix.

When there is no trie edge for the next character, we move to the longest suffix that is also a pattern prefix.  
This fallback pointer is called a failure link.

With failure links, each text character advances the automaton state once.  
If the state has pattern outputs, those patterns occur ending at the current position.

## Import

~~~nim
import atcoder/extra/string/aho_corasick
~~~

## Types

~~~nim
type AhoCorasick
type AhoCorasickNode
type AhoCorasickMatch
~~~

`AhoCorasickMatch` has these fields:

~~~nim
l: int
r: int
patternId: int
~~~

The match interval is half-open `[l, r)`.

## Constructors

~~~nim
proc initAhoCorasick(): AhoCorasick
proc initAhoCorasick(patterns: openArray[string]): AhoCorasick
~~~

You can either build an empty automaton and add patterns, or build directly from a pattern list.

## Add patterns and build

~~~nim
proc addPattern(ac: var AhoCorasick, pattern: string): int
proc build(ac: var AhoCorasick)
~~~

- `addPattern(pattern)` adds a pattern and returns its pattern id.
- Empty patterns are not allowed.
- Call `build()` after adding all patterns.
- Adding patterns after `build()` is not intended.

## Operations

~~~nim
proc len(ac: AhoCorasick): int
proc patternCount(ac: AhoCorasick): int

proc nextState(ac: AhoCorasick, state: int, ch: char): int
proc transition(ac: AhoCorasick, state: int, ch: char): int

proc findAll(ac: AhoCorasick, text: string): seq[AhoCorasickMatch]
proc countMatches(ac: AhoCorasick, text: string): int
proc matchCount(ac: AhoCorasick, text: string): int
proc contains(ac: AhoCorasick, text: string): bool
~~~

- `findAll(text)` returns all matches.
- `countMatches(text)` returns the number of matches.
- `contains(text)` checks whether at least one pattern occurs in the text.
- `text in ac` is also available.
- `transition` is an alias of `nextState`.

## Example

~~~nim
var ac = initAhoCorasick()

let
  he = ac.addPattern("he")
  she = ac.addPattern("she")
  hers = ac.addPattern("hers")

ac.build()

let matches = ac.findAll("ushers")

for m in matches:
  echo "pattern ", m.patternId, " appears at [", m.l, ", ", m.r, ")"

doAssert ac.countMatches("ushers") == 3
doAssert ac.contains("ushers")
~~~

You can also build directly from a list.

~~~nim
let ac = initAhoCorasick(@["a", "aa", "aaa"])

doAssert ac.countMatches("aaaa") == 9
~~~

## Nim-friendly usage

Since `contains` is defined, matching can be written with `in`.

~~~nim
if text in ac:
  echo "matched"
~~~

`transition` is useful when using the automaton as a DP state.

~~~nim
var state = 0

for ch in text:
  state = ac.transition(state, ch)
~~~

## Complexity

Let `M` be the total pattern length, `N` be the text length, and `Z` be the number of matches.

- build: close to `O(M * alphabet + M)`. This implementation builds a full transition table for 256 char values.
- `findAll`: `O(N + Z)`
- `countMatches`: `O(N)`
- memory: `O(states * 256 + total output)`

## Notes

- This implementation is for `char` / `string`.
- The alphabet size is fixed to 256.
- Unicode grapheme-cluster matching is not supported.
- Match intervals are half-open `[l, r)`.
- Adding patterns after `build()` is not allowed.

## Related resources and libraries

- cp-algorithms: Aho-Corasick algorithm
- Nyaan Library: Aho-Corasick
- ei1333 Library: Aho-Corasick
- KACTL: Aho-Corasick
- Library Checker: multiple pattern matching / string problems
