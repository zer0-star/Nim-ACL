# WaveletMatrix

`WaveletMatrix` は、静的な整数列に対して、区間内の順位統計や出現回数を高速に求める data structure です。

座標圧縮版の `CompressedWaveletMatrix` も提供されています。

## import

~~~nim
import atcoder/extra/structure/wavelet_matrix
~~~

## 型

~~~nim
type WaveletMatrix[T, MAXLOG]
type CompressedWaveletMatrix[T, MAXLOG]
~~~

`MAXLOG` は扱う値の bit 幅です。

## コンストラクタ

~~~nim
proc initWaveletMatrix[T](v: seq[T], MAXLOG: static[int]): WaveletMatrix[T, MAXLOG]
proc initCompressedWaveletMatrix[T](v: seq[T], MAXLOG: static[int]): CompressedWaveletMatrix[T, MAXLOG]
~~~

## 操作

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

主な意味は次の通りです。

- `access(k)`: `v[k]`
- `rank(r, x)`: `v[0 ..< r]` に含まれる `x` の個数
- `kth_smallest(l, r, k)`: `v[l ..< r]` の `k` 番目に小さい値
- `kth_largest(l, r, k)`: `v[l ..< r]` の `k` 番目に大きい値
- `range_freq(l, r, upper)`: `v[l ..< r]` に含まれる `upper` 未満の個数
- `range_freq(l, r, lower, upper)`: `lower <= x < upper` を満たす個数

## 使用例

<!-- nim-line-numbers -->
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

値が大きい場合や、整数以外の順序付き値を扱いたい場合は `CompressedWaveletMatrix` を使います。

~~~nim
let v = @[100, 10, 100, 50]
let wm = initCompressedWaveletMatrix[int](v, 2)

doAssert wm.access(0) == 100
doAssert wm.rank(4, 100) == 2
~~~

## 計算量

列長を `n`、bit 幅を `MAXLOG` とすると、

- 構築: `O(n MAXLOG)`
- 各 query: `O(MAXLOG)`

です。
