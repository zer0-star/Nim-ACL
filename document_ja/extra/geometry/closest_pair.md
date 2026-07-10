# Closest Pair

`closest_pair(ps)` は、二次元点集合の最近点対距離を求めます。

## import

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/closest_pair
~~~

## 定義

~~~nim
proc closest_pair[Real](ps: seq[Point[Real]]): Real
~~~

点列 `ps` の中から、異なる 2 点の距離の最小値を返します。

## 使用例

<!-- nim-line-numbers -->
~~~nim
let ps = @[
  initPoint[float](0.0, 0.0),
  initPoint[float](3.0, 4.0),
  initPoint[float](2.0, 0.0),
  initPoint[float](2.0, 1.0),
]

doAssert closest_pair(ps) == 1.0
~~~

## 制約

- `ps.len >= 2`
- 同じ座標の点が複数ある場合、最近距離は `0` になります。

## 計算量

点数を `n` とすると、

- `O(n log n)`

です。
