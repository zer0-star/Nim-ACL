# Closest Pair

`closest_pair(ps)` は、二次元点集合の最近点対距離を求めます。

## import

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/closest_pair
~~~

## 使用例

~~~nim
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/closest_pair

let ps = @[
  initPoint[float](0.0, 0.0),
  initPoint[float](3.0, 4.0),
  initPoint[float](2.0, 0.0),
  initPoint[float](2.0, 1.0),
]

doAssert closest_pair(ps) == 1.0
~~~

## API

~~~nim
closest_pair(ps)
~~~

点列 `ps` の中から、異なる 2 点の距離の最小値を返します。

## 注意

- `ps.len >= 2` を仮定します。
- 同じ座標の点が複数ある場合、最近距離は `0` になります。
- 浮動小数点比較には `geometry_template` / `floatutils` の許容誤差付き比較が使われます。

## 計算量

点数を `n` とすると、

- `O(n log n)`

です。
