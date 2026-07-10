# Coordinate Compression

座標圧縮は、大きい値や飛び飛びの値を、大小関係を保ったまま `0, 1, ..., k-1` に置き換える technique です。

例えば、

```text
[100, -5, 100, 7]
```

は、異なる値を並べた

```text
[-5, 7, 100]
```

に対応させることで、

```text
[2, 0, 2, 1]
```

に圧縮できます。

## 使いどころ

- Fenwick Tree / Segment Tree の index に大きい座標を使いたい
- 値の大小関係だけが重要
- 頻度配列を作りたい
- sweep line
- offline query
- `10^9` 程度の座標が高々 `2×10^5` 個だけ現れる問題

## import

~~~nim
import atcoder/extra/algorithm/coordinate_compression
~~~

ローカル短縮 import も使えます。

~~~nim
import lib/algorithm/coordinate_compression
~~~

## API

~~~nim
proc initCoordinateCompression[T](
  a: openArray[T]
): CoordinateCompression[T]

proc len(cc): int
proc lowerBoundIndex(cc, x): int
proc upperBoundIndex(cc, x): int

proc indexOf(cc, x): int
proc encode(cc, x): int
proc decode(cc, index): T

proc compress(cc, a): seq[int]
proc restore(cc, indices): seq[T]
~~~

- `indexOf(x)` は未登録なら `-1`
- `encode(x)` は登録済みであることを要求
- `decode(i)` は元の値を返す
- `values` には sort・deduplicate 済みの元値が入る

## 使用例

~~~nim
let
  a = @[100, -5, 100, 7]
  cc = initCoordinateCompression(a)
  compressed = cc.compress(a)

doAssert cc.values == @[-5, 7, 100]
doAssert compressed == @[2, 0, 2, 1]

doAssert cc.encode(7) == 1
doAssert cc.decode(2) == 100
~~~

## 計算量

異なる値の個数を `k`、入力長を `n` とすると、

- 構築: `O(n log n)`
- `encode`, `indexOf`: `O(log k)`
- `decode`: `O(1)`
- sequence 全体の圧縮: `O(n log k)`
- memory: `O(k)`

## 関連資料

- AtCoder ABC の Fenwick Tree / sweep line 問題
- cp-algorithms: Coordinate Compression を用いる offline algorithm
