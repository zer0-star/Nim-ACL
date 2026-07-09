# Longest Increasing Subsequence

`longestIncreasingSubsequence` computes a longest increasing subsequence, LIS.

By default it returns the length. By setting `return_type`, it can also return indices or values.

## Import

~~~nim
import atcoder/extra/dp/longest_increasing_subsequence
import atcoder/extra/other/return_type
~~~

## Example

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

With `strict = true`, the subsequence must be strictly increasing. With `strict = false`, non-decreasing subsequences are allowed.

~~~nim
doAssert longestIncreasingSubsequence(@[2, 2, 2], strict = true) == 1
doAssert longestIncreasingSubsequence(@[2, 2, 2], strict = false) == 3
~~~

## return_type

`return_type` can be a `ReturnType` value:

- `Length`: length
- `Index`: indices
- `Value`: values
- `IndexAndValue`: pairs of index and value

## Complexity

For a sequence of length `n`:

- `O(n log n)`
