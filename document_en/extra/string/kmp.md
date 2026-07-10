# KMP / Prefix Function

KMP searches for a pattern in linear time by reusing previous match information through the prefix function.

## Import and API

~~~nim
import atcoder/extra/string/kmp

proc prefixFunction(s): seq[int]
proc initKMP(pattern): KMPMatcher
proc findAll(matcher, text): seq[int]
proc findFirst(matcher, text): int
proc countMatches(matcher, text): int
~~~

## Example

~~~nim
let matcher = initKMP("aba")

doAssert matcher.findAll("ababa") == @[0, 2]
doAssert matcher.findFirst("zzabazz") == 2
~~~

## Complexity

- preprocessing: `O(m)`
- search: `O(n)`
- memory: `O(m)`
