# Slide Min / Slide Max

`slideMin` computes sliding window minimum values.  
`slideMax` computes sliding window maximum values.

## Import

~~~nim
import atcoder/extra/dp/slide_min
~~~

## Example

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/dp/slide_min

let a = @[4, 2, 5, 1, 3]

let mn = slideMin(a, 3)
let mx = slideMax(a, 3)

doAssert mn[^3 .. ^1] == @[2, 1, 1]
doAssert mx[^3 .. ^1] == @[5, 5, 5]
~~~

## Return value note

`slideMin(a, k)` includes prefix information at the beginning of the returned sequence.  
If you only need values for complete windows of length `k`, take the last `a.len - k + 1` elements.

~~~nim
let onlyFullWindows = slideMin(a, k)[^(a.len - k + 1) .. ^1]
~~~

## Complexity

For a sequence of length `n`:

- `O(n)`
