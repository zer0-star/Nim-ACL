# DisjointSparseTable

`DisjointSparseTable` answers static range products in `O(1)` for any associative operation.

Unlike an ordinary Sparse Table, the operation does not need to be idempotent. Sums, concatenation, and matrix products are supported.

## Import and API

~~~nim
import atcoder/extra/structure/disjoint_sparse_table

proc initDisjointSparseTable[T](
  a: openArray[T],
  op: proc(a, b: T): T
): DisjointSparseTable[T]

proc prod[T](dst: DisjointSparseTable[T], l, r: int): T
~~~

Ranges are non-empty half-open intervals `[l, r)`.

## Complexity

- build: `O(n log n)`
- query: `O(1)`
- memory: `O(n log n)`
