# WaveletMatrix

`WaveletMatrix` is a static data structure for rank/select-like queries and order statistics on integer sequences.

`CompressedWaveletMatrix` is also provided for coordinate-compressed values.

## Import

~~~nim
import atcoder/extra/structure/wavelet_matrix
~~~

## Types

~~~nim
type WaveletMatrix[T, MAXLOG]
type CompressedWaveletMatrix[T, MAXLOG]
~~~

`MAXLOG` is the bit width of values.

## Constructor

~~~nim
proc initWaveletMatrix[T](v: seq[T], MAXLOG: static[int]): WaveletMatrix[T, MAXLOG]
proc initCompressedWaveletMatrix[T](v: seq[T], MAXLOG: static[int]): CompressedWaveletMatrix[T, MAXLOG]
~~~

## Operations

~~~nim
proc access(wm, k): T
proc rank(wm, r, x): int

proc kth_smallest(wm, l, r, k): T
proc kth_largest(wm, l, r, k): T

proc range_freq(wm, l, r, upper): int
proc range_freq(wm, l, r, lower, upper): int

proc prev_value(wm, l, r, upper): T
proc next_value(wm, l, r, lower): T
~~~

Main meanings:

- `access(k)`: returns `v[k]`
- `rank(r, x)`: counts `x` in `v[0 ..< r]`
- `kth_smallest(l, r, k)`: the `k`-th smallest value in `v[l ..< r]`
- `kth_largest(l, r, k)`: the `k`-th largest value in `v[l ..< r]`
- `range_freq(l, r, upper)`: counts values `< upper` in `v[l ..< r]`
- `range_freq(l, r, lower, upper)`: counts values `lower <= x < upper`

## Example

~~~nim
let v = @[3, 1, 4, 1, 5, 9, 2, 6]
let wm = initWaveletMatrix[int](v, 4)

doAssert wm.access(0) == 3
doAssert wm.rank(4, 1) == 2
doAssert wm.kth_smallest(0, 8, 0) == 1
doAssert wm.kth_largest(0, 8, 0) == 9
doAssert wm.range_freq(0, 8, 5) == 5
~~~

## CompressedWaveletMatrix

Use `CompressedWaveletMatrix` when values are large or when you want to handle arbitrary ordered values through coordinate compression.

~~~nim
let v = @[100, 10, 100, 50]
let wm = initCompressedWaveletMatrix[int](v, 2)

doAssert wm.access(0) == 100
doAssert wm.rank(4, 100) == 2
~~~

## Complexity

For sequence length `n` and bit width `MAXLOG`:

- build: `O(n MAXLOG)`
- each query: `O(MAXLOG)`
