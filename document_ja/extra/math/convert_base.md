# Convert Base

`toSeq` と `toInt` は、整数と基数 `b` 表現の digit 列を相互変換します。

digit 列は **下位桁から順に並ぶ little-endian** です。

## import

~~~nim
import atcoder/extra/math/convert_base
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/math/convert_base

doAssert toSeq(12345, 10) == @[5, 4, 3, 2, 1]
doAssert toInt(@[5, 4, 3, 2, 1], 10) == 12345

doAssert toSeq(13, 2) == @[1, 0, 1, 1]
doAssert toInt(@[1, 0, 1, 1], 2) == 13
~~~

## min_digit

`toSeq(n, b, min_digit)` とすると、少なくとも `min_digit` 桁になるように `0` で埋めます。

~~~nim
doAssert toSeq(0, 10, 4) == @[0, 0, 0, 0]
~~~

## 計算量

桁数を `d` とすると、

- `toSeq`: `O(d)`
- `toInt`: `O(d)`

です。
