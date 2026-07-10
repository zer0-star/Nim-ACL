# FunctionalGraph / Doubling

A `FunctionalGraph` is a directed graph where every vertex has exactly one outgoing edge.

Equivalently, it is a function `f: {0, ..., n-1} -> {0, ..., n-1}`.  
In competitive programming, it often appears in problems asking for the destination after applying `f` exactly `k` times.

`Doubling` is a technique for applying the same operation many times in `O(log k)` time.

## Use cases

Typical use cases include:

- applying a function when `k` is as large as `10^18`
- teleporter problems
- cycle detection in a functional graph
- ancestor queries on trees
- a building block for LCA / binary lifting

AtCoder ABC167 D “Teleporter” and ABC367 E “Permute K times” are representative examples.

## Idea

`Doubling` precomputes the following table:

- `table[0][v] = f(v)`
- `table[1][v] = f^2(v)`
- `table[2][v] = f^4(v)`
- `table[b][v] = f^(2^b)(v)`

Then decompose `k` in binary and apply only the tables corresponding to set bits.

For example, if `k = 13 = 8 + 4 + 1`, then `f^13(v)` is obtained by applying `f^8`, `f^4`, and `f^1`.

## Import

~~~nim
import atcoder/extra/graph/functional_graph
~~~

## Types

~~~nim
type Doubling
type FunctionalGraph
~~~

`Doubling` is a general function-iteration table.  
`FunctionalGraph` is a wrapper containing `to: seq[int]` and a `Doubling` table.

## Constructors

~~~nim
proc initDoubling(to: openArray[int], maxLog: int = 60): Doubling
proc initFunctionalGraph(to: openArray[int], maxLog: int = 60): FunctionalGraph
~~~

- `to[v]` is the next vertex after one move from `v`.
- `maxLog` is the largest bit to precompute.
- Queries with `k < 2^(maxLog + 1)` are supported.

## Operations

~~~nim
proc len(db: Doubling): int
proc jump[K: SomeInteger](db: Doubling, v: int, k: K): int
proc `[]`[K: SomeInteger](db: Doubling, q: tuple[v: int, k: K]): int

proc len(fg: FunctionalGraph): int
proc jump[K: SomeInteger](fg: FunctionalGraph, v: int, k: K): int
proc `[]`[K: SomeInteger](fg: FunctionalGraph, q: tuple[v: int, k: K]): int

proc cycleInfo(fg: FunctionalGraph, start: int): tuple[tail, period: int]
proc orbit(fg: FunctionalGraph, start: int): tuple[prefix, cycle: seq[int]]
~~~

- `jump(v, k)` returns the vertex reached after `k` moves from `v`.
- `db[(v, k)]` and `fg[(v, k)]` are sugar for the same query.
- `cycleInfo(start)` returns the tail length and the cycle length of the orbit from `start`.
- `orbit(start)` splits the visited sequence into `prefix` and `cycle`.

## Example

~~~nim
let to = @[1, 2, 0, 4, 4]
let fg = initFunctionalGraph(to, maxLog = 60)

doAssert fg.jump(0, 0) == 0
doAssert fg.jump(0, 1) == 1
doAssert fg.jump(0, 2) == 2
doAssert fg.jump(0, 3) == 0

doAssert fg.jump(3, 1000000000000000000'u64) == 4
~~~

Tuple-based sugar is also available.

~~~nim
doAssert fg[(0, 5)] == 2
doAssert fg[(3, 100)] == 4
~~~

## Cycle information

~~~nim
let fg = initFunctionalGraph(@[1, 2, 3, 1, 5, 5])

let info = fg.cycleInfo(0)

doAssert info.tail == 1
doAssert info.period == 3

let orb = fg.orbit(0)

doAssert orb.prefix == @[0]
doAssert orb.cycle == @[1, 2, 3]
~~~

## Nim-friendly usage

In Nim, tuple indexing can be used as `fg[(v, k)]`.

~~~nim
let ans = fg[(start, k)]
~~~

For readability, `fg.jump(start, k)` is also recommended.

## Complexity

Let `n` be the number of vertices and `B = maxLog + 1`.

- build: `O(nB)`
- `jump`: `O(B)`
- `cycleInfo`: `O(n)`
- `orbit`: `O(n)`
- memory: `O(nB)`

## Notes

- Each `to[v]` must satisfy `0 <= to[v] < n`.
- `jump(v, k)` requires `k < 2^(maxLog + 1)`.
- Use `uint64` for very large `k`.

## Related resources and libraries

- AtCoder ABC167 D: Teleporter
- AtCoder ABC367 E: Permute K times
- cp-algorithms: Lowest Common Ancestor - Binary Lifting
- KACTL: Binary Lifting / LCA related snippets
