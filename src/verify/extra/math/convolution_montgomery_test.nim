# verify-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod

import atcoder/header, atcoder/extra/math/modint_montgomery
import atcoder/convolution
import sequtils, strutils

type mint = modint_montgomery_998244353

let N, M = nextInt()
let a = newSeqWith(N, mint(nextInt()))
let b = newSeqWith(M, mint(nextInt()))
echo convolution(a, b).join(" ")
#echo convolution(a, b, 998244353).join(" ")
