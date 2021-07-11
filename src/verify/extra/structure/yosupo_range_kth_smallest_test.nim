# verify-helper: PROBLEM https://judge.yosupo.jp/problem/range_kth_smallest

include atcoder/header

import atcoder/extra/structure/wavelet_matrix

let N, Q = nextInt()
let A = newSeqWith(N, nextInt())
var mat = initCompressedWaveletMatrix(A, 18)
for i in 0..<Q:
  let a, b, c = nextInt()
  echo mat.kth_smallest(a ..< b, c)
