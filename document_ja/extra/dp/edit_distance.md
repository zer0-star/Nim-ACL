# Edit Distance

`editDistance(S, T)` は、文字列 `S` を `T` に変換するための編集距離を求めます。

許される操作は、1 文字の挿入・削除・置換です。

## import

~~~nim
import atcoder/extra/dp/edit_distance
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/dp/edit_distance

doAssert editDistance("kitten", "sitting") == 3
doAssert editDistance("abc", "abc") == 0
doAssert editDistance("abc", "") == 3
~~~

## 計算量

`S.len = n`, `T.len = m` とすると、

- 時間計算量: `O(nm)`
- メモリ: `O(m)`

です。
