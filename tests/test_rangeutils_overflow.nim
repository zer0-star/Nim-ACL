import atcoder/rangeutils


let overflowingClosed:
    Slice[int] =
  0 .. high(int)

discard halfOpenEndpoints(
  overflowingClosed,
)

echo "UNEXPECTED_RANGE_OVERFLOW_ACCEPTED"
