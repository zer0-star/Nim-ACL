include atcoder/header
import atcoder/convolution
import atcoder/modint

let
  n, m = nextInt()
  a = newSeqWith(n, nextInt())
  b = newSeqWith(m, nextInt())

let c = convolution[998244353, int](a, b)
# or: c = convolution<998244353>(a, b)

echo c.join(" ")
