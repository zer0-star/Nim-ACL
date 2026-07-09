# Largest Rectangle

`largestRectangle(height)` computes the largest rectangle area in a histogram.

## Import

~~~nim
import atcoder/extra/dp/largest_rectangle
~~~

## Example

~~~nim
import atcoder/extra/dp/largest_rectangle

let h = @[2, 1, 5, 6, 2, 3]

doAssert largestRectangle(h) == 10
~~~

## Complexity

For `height.len = n`:

- `O(n)`
