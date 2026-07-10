# Edit Distance

`editDistance(S, T)` computes the edit distance between two strings.

The allowed operations are insertion, deletion, and substitution of one character.

## Import

~~~nim
import atcoder/extra/dp/edit_distance
~~~

## Example

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/dp/edit_distance

doAssert editDistance("kitten", "sitting") == 3
doAssert editDistance("abc", "abc") == 0
doAssert editDistance("abc", "") == 3
~~~

## Complexity

Let `S.len = n` and `T.len = m`.

- Time: `O(nm)`
- Memory: `O(m)`
