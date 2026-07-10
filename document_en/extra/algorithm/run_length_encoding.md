# Run-Length Encoding

Run-Length Encoding groups consecutive equal values into `(value, count)` pairs.

## Import and API

~~~nim
import atcoder/extra/algorithm/run_length_encoding

proc runLengthEncode(a): seq[Run[T]]
proc rle(a): seq[Run[T]]
proc runLengthDecode(runs): seq[T]
~~~

## Example

~~~nim
let runs = rle("aaabbc")

doAssert runs == @[
  (value: 'a', count: 3),
  (value: 'b', count: 2),
  (value: 'c', count: 1),
]
~~~

## Complexity

Encoding and decoding are linear in the input/output length.
