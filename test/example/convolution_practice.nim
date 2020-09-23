include atcoder/header
import atcoder/modint
import atcoder/convolution

type mint = modint998244353

let
  n, m = nextInt()
  a = newSeqWith(n, mint(nextInt()))
  b = newSeqWith(m, mint(nextInt()))
  c = convolution(a, b)

echo c.join(" ")
