# verify-helper: PROBLEM https://judge.yosupo.jp/problem/bitwise_and_convolution

include atcoder/header
import atcoder/modint
import atcoder/extra/math/bitwise_convolution
import sequtils, strutils

proc main():void =
  type mint = modint998244353
  let N = nextInt()
  var a = newSeqWith(2^N, mint(nextInt()))
  var b = newSeqWith(2^N, mint(nextInt()))
  echo AndConvolution(a, b).join(" ")

main()
