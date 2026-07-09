# Slide Min / Slide Max

`slideMin` は、長さ `k` の sliding window minimum を求めます。  
`slideMax` は sliding window maximum を求めます。

## import

~~~nim
import atcoder/extra/dp/slide_min
~~~

## 使用例

~~~nim
import atcoder/extra/dp/slide_min

let a = @[4, 2, 5, 1, 3]

let mn = slideMin(a, 3)
let mx = slideMax(a, 3)

doAssert mn[^3 .. ^1] == @[2, 1, 1]
doAssert mx[^3 .. ^1] == @[5, 5, 5]
~~~

## 戻り値について

`slideMin(a, k)` は実装上、先頭側の prefix 情報を含む形で返ります。  
長さ `k` の完全な window に対応する値だけを使いたい場合は、末尾 `a.len - k + 1` 個を見てください。

~~~nim
let onlyFullWindows = slideMin(a, k)[^(a.len - k + 1) .. ^1]
~~~

## 計算量

列の長さを `n` とすると、

- `O(n)`

です。
