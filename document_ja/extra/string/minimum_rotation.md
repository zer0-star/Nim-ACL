# Minimum Rotation / Booth

`Minimum Rotation` は、文字列または sequence の巡回 shift のうち、辞書順最小のものを線形時間で求めます。

Booth's algorithm と呼ばれる方法を使います。

## 使いどころ

- necklace の標準形
- 巡回同値な文字列の正規化
- 最小巡回表現
- circular string の比較
- Library Checker の Minimum Representation

## 考え方

2つの開始位置 `i`, `j` の rotation を比較します。

最初に異なる位置が `k` だったとき、辞書順で負けた側について、`i` から `i+k` までの開始位置はすべて候補から除外できます。

このように候補をまとめて飛ばすため、全体が `O(n)` になります。

## import

~~~nim
import atcoder/extra/string/minimum_rotation
~~~

## API

~~~nim
proc minimumRotationIndex(s): int
proc minimalRotationIndex(s): int
proc maximumRotationIndex(s): int

proc minimumRotation(s): auto
proc maximumRotation(s): auto
proc rotated(s, start: int): seq
~~~

## 使用例

~~~nim
doAssert minimumRotationIndex("bbaaccaadd") == 2
doAssert minimumRotation("bbaaccaadd") == "aaccaaddbb"

doAssert maximumRotation("abac") == "caba"
~~~

一般の比較可能な sequence にも使えます。

~~~nim
doAssert minimumRotation(@[3, 1, 2, 1]) == @[1, 3, 1, 2]
~~~

## 計算量

- index 計算: `O(n)`
- rotation の生成: `O(n)`
- memory: index 計算 `O(1)`

## 関連資料・他言語ライブラリ

- [Library Checker: Minimum Representation](https://judge.yosupo.jp/problem/minimum_representation)
- KACTL: MinRotation
- cp-algorithms: Lyndon factorization 関連
