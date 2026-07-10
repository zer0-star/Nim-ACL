# BinaryTrie

`BinaryTrie` is a data structure that stores integers as bit strings.

Unlike a normal trie for strings, `BinaryTrie` branches by the bits of an integer from high to low. This makes it possible to find an element `y` that maximizes or minimizes `x xor y`.

## Use cases

Typical use cases include:

- dynamic multiset queries: insert/delete integers and answer maximum `x xor y`
- minimum or maximum XOR queries over a set of integers
- bitwise greedy problems
- XOR minimization on non-negative integer arrays, such as `0 <= a_i < 2^30`

Codeforces 706D “Vasiliy's Multiset” and Library Checker `Set Xor-Min` are representative examples.

## Idea

Each integer is inserted from bit `maxLog` down to bit `0`.

For `maxXor(x)`, we greedily choose the opposite bit of `x` whenever possible. Higher bits have larger value, so this greedy choice gives the maximum XOR value.

For `minXor(x)`, we greedily choose the same bit as `x` whenever possible.

Each node stores `count`, the number of elements under the node. This supports duplicate values and lets queries avoid branches that became empty after deletion.

## Import

~~~nim
import atcoder/extra/structure/binary_trie
~~~

## Type

~~~nim
type BinaryTrie[T: SomeInteger]
~~~

`T` is an integer type, usually `int`, `int64`, or `uint64`.

## Constructor

~~~nim
proc initBinaryTrie[T: SomeInteger](maxLog: int = 60): BinaryTrie[T]
~~~

`maxLog` is the largest bit index inspected by the trie.

For example, if all values satisfy `0 <= x < 2^30`, use `maxLog = 29`, or `maxLog = 30` with a little extra room.

## Operations

~~~nim
proc len[T](tr: BinaryTrie[T]): int
proc empty[T](tr: BinaryTrie[T]): bool

proc insert[T](tr: var BinaryTrie[T], x: T)
proc add[T](tr: var BinaryTrie[T], x: T, c: int)
proc erase[T](tr: var BinaryTrie[T], x: T, c: int = 1)

proc count[T](tr: BinaryTrie[T], x: T): int
proc contains[T](tr: BinaryTrie[T], x: T): bool

proc minXor[T](tr: BinaryTrie[T], x: T): T
proc maxXor[T](tr: BinaryTrie[T], x: T): T

proc minElementXor[T](tr: BinaryTrie[T], x: T): T
proc maxElementXor[T](tr: BinaryTrie[T], x: T): T
~~~

- `insert(x)` inserts one copy of `x`.
- `add(x, c)` inserts `c` copies of `x`.
- `erase(x, c)` erases `c` copies of `x`.
- `count(x)` returns the multiplicity of `x`.
- `x in tr` checks whether `x` exists.
- `minXor(x)` returns the minimum value of `x xor y`.
- `maxXor(x)` returns the maximum value of `x xor y`.
- `minElementXor(x)` returns an element `y` minimizing `x xor y`.
- `maxElementXor(x)` returns an element `y` maximizing `x xor y`.

## Example

<!-- nim-line-numbers -->
~~~nim
var tr = initBinaryTrie[int](maxLog = 30)

tr.insert(0)
tr.insert(5)
tr.insert(7)
tr.insert(5)

doAssert tr.len == 4
doAssert 5 in tr
doAssert tr.count(5) == 2

doAssert tr.minXor(2) == 2  # 2 xor 0
doAssert tr.maxXor(2) == 7  # 2 xor 5

tr.erase(5)

doAssert tr.count(5) == 1
~~~

## Constraints

This implementation is mainly intended for non-negative integers satisfying `0 <= x < 2^(maxLog + 1)`.

If negative integers are inserted, their `uint64` representation is used. For competitive programming, non-negative values are recommended.

## Complexity

Let `B = maxLog + 1`.

- `insert`: `O(B)`
- `erase`: `O(B)`
- `count`: `O(B)`
- `minXor`, `maxXor`: `O(B)`
- memory: `O(B * distinct values)`

<!-- NIM_ACL_PROBLEM_EXAMPLES_V1 -->
## Practice problems

<details class="problem-examples">
<summary>Show problems that can use this library (may reveal the intended technique)</summary>
<ul>
  <li><a href="https://atcoder.jp/contests/abc308/tasks/abc308_g" target="_blank" rel="noopener">AtCoder Beginner Contest 308 G - Minimum Xor Pair Query</a></li>
  <li><a href="https://judge.yosupo.jp/problem/set_xor_min" target="_blank" rel="noopener">Library Checker - Set Xor-Min</a></li>
</ul>
</details>
<!-- /NIM_ACL_PROBLEM_EXAMPLES_V1 -->

## Related resources and libraries

- Library Checker: `Set Xor-Min`
- Nyaan Library: Binary Trie
- ei1333 Library: Binary Trie
- Codeforces 706D: Vasiliy's Multiset
