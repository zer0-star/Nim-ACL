# verify-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod_1000000007

import atcoder/header, atcoder/modint
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series
import sequtils, strutils

type mint = modint1000000007

let N, M = nextInt()
let a = newSeqWith(N, nextInt().mint)
let b = newSeqWith(M, nextInt().mint)
echo (a * b).join(" ")
