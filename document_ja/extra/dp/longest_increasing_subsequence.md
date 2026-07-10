# Longest Increasing Subsequence

`longestIncreasingSubsequence` は、最長増加部分列、LIS を求めます。

デフォルトでは長さを返します。`return_type` を指定すると、添字列や値列も返せます。

## import

~~~nim
import atcoder/extra/dp/longest_increasing_subsequence
import atcoder/extra/other/return_type
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/dp/longest_increasing_subsequence
import atcoder/extra/other/return_type

let a = @[3, 1, 2, 1, 8, 5, 6]

doAssert longestIncreasingSubsequence(a) == 4

let lis = longestIncreasingSubsequence(a, return_type = Value)

doAssert lis.len == 4
~~~

## strict

~~~nim
longestIncreasingSubsequence(a, strict = true)
longestIncreasingSubsequence(a, strict = false)
~~~

`strict = true` では狭義増加、`strict = false` では広義増加として扱います。

~~~nim
doAssert longestIncreasingSubsequence(@[2, 2, 2], strict = true) == 1
doAssert longestIncreasingSubsequence(@[2, 2, 2], strict = false) == 3
~~~

## return_type

`return_type` には `ReturnType` を指定できます。

- `Length`: 長さ
- `Index`: LIS の添字列
- `Value`: LIS の値列
- `IndexAndValue`: 添字と値の組

## 計算量

列の長さを `n` とすると、

- `O(n log n)`

です。
