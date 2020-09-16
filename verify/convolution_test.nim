# verify-helper: PROBLEM https://judge.yosupo.jp/problem/convolution_mod

include src/nim_acl/header, src/nim_acl/modint
import src/nim_acl/convolution

let N, M = nextInt()
let a = newSeqWith(N, nextInt())
let b = newSeqWith(M, nextInt())
echo convolution[998244353, int](a, b).join(" ")
