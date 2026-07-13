# Min-Plus Convolution

第1引数が凸列である場合のmin-plus convolutionを計算します。

長さ`n`の列`convex`と長さ`m`の列`arbitrary`に対し、
長さ`n + m - 1`の列`result`を返します。

各index`k`について、範囲内の`i`を用いて次を計算します。

~~~text
result[k] = min(convex[k - i] + arbitrary[i])
~~~

## 一般形

~~~nim
minPlusConvolutionConvexArbitrary(
  convex: openArray[int64],
  arbitrary: openArray[int64],
): seq[int64]
~~~

### 引数

- `convex: openArray[int64]`:
  隣接差分が広義単調増加する凸列です。
- `arbitrary: openArray[int64]`:
  任意の`int64`列です。

両方の入力列は変更されません。

### 返り値

- `seq[int64]`:
  min-plus convolutionの結果を新しい列として返します。

どちらかの入力が空の場合は空列を返します。

### 例外

`convex`が凸列でない場合は`ValueError`を送出します。

### 制約

- `convex[i] + arbitrary[j]`が`int64`の範囲に収まる
- `convex`の隣接差分が広義単調増加する

### 計算量

`n = convex.len`、`m = arbitrary.len`とします。

現在のdivide-and-conquer monotone optimization実装では、

- 時間: `O((n + m) log(n + m))`
- 追加メモリ: `O(n + m)`

です。

## 使用例

~~~nim
import atcoder/extra/math/min_plus_convolution

let convex =
  @[0'i64, 1, 4]

let arbitrary =
  @[3'i64, 0]

doAssert minPlusConvolutionConvexArbitrary(
  convex,
  arbitrary,
) == @[3'i64, 0, 1, 4]
~~~

## import方法

~~~nim
import atcoder/extra/math/min_plus_convolution
~~~

## 主なAPI

- `minPlusConvolutionConvexArbitrary`
