# RadixHeap

`RadixHeap` is a priority queue for integer keys.

It can be used when keys popped from the queue are monotonically non-decreasing. It is useful for Dijkstra's algorithm with non-negative integer edge weights.

## Import

~~~nim
import atcoder/extra/structure/radix_heap
~~~

## Type

~~~nim
type RadixHeap[key_t, val_t]
~~~

`key_t` must be an integer type.

## Constructor

~~~nim
proc initRadixHeap[key_t, val_t](): RadixHeap[key_t, val_t]
~~~

Returns an empty radix heap.

## Operations

~~~nim
proc empty[key_t, val_t](h: RadixHeap[key_t, val_t]): bool
proc len[key_t, val_t](h: RadixHeap[key_t, val_t]): int

proc push[key_t, val_t](h: var RadixHeap[key_t, val_t], key: key_t, val: val_t)
proc pop[key_t, val_t](h: var RadixHeap[key_t, val_t]): (key_t, val_t)
~~~

- `push(h, key, val)` inserts `(key, val)`.
- `pop(h)` removes and returns an element with the minimum key.

## Example

<!-- nim-line-numbers -->
~~~nim
var h = initRadixHeap[int, string]()

h.push(0, "zero")
h.push(3, "three")
h.push(5, "five")

doAssert h.len == 3

let (k, v) = h.pop()

doAssert k == 0
doAssert v == "zero"
~~~

## Constraints

Every pushed key must be at least the last popped key.  
This is not a general-purpose priority queue for arbitrary key order.

## Complexity

Let `B` be the bit width of the key type.

- `push`: amortized `O(1)`
- `pop`: amortized `O(B)`
