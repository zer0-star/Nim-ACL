# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=2674

include atcoder/header


import atcoder/extra/structure/wavelet_matrix

let N = nextInt()
let X = newSeqWith(N, nextInt() + 5 * 10^8)

var matrix = initCompressedWaveletMatrix(X, 30)
let Q = nextInt()
for _ in 0..<Q:
  let L, R = nextInt() - 1
  let E = nextInt()
  echo (R - L + 1) - matrix.range_freq(L .. R, min(X[L], X[R]) - E, max(X[L], X[R]) + E + 1)
