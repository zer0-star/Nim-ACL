# Sqrt Tree

`SqrtTree` recursively applies square-root decomposition to a static monoid sequence.

This Nim-ACL implementation favors a clear recursive structure:

- preprocessing: `O(n log log n)`
- query: `O(log log n)`
- memory: `O(n log log n)`

The optimized level-selection variant can reduce queries to `O(1)`.

## Import and API

~~~nim
import atcoder/extra/structure/sqrt_tree

proc initSqrtTree[T](
  data: openArray[T],
  identity: T,
  op: proc(a, b: T): T
): SqrtTree[T]

proc prod(tree: SqrtTree[T], l, r: int): T
~~~

## Example

~~~nim
proc add(a, b: int): int = a + b

let tree = initSqrtTree(
  @[1, 2, 3, 4, 5],
  identity = 0,
  op = add,
)

doAssert tree.prod(1, 4) == 9
~~~

## Notes

The array is static, and `op` must be associative.
