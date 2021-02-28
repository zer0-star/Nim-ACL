# verify-helper: PROBLEM https://judge.yosupo.jp/problem/bitwise_and_convolution

include atcoder/header
import atcoder/modint
import atcoder/extra/math/bitwise_convolution
import sequtils, strutils

proc main():void =
  type mint = modint998244353
  let N = nextInt()
  proc bit_invert(a:seq[mint]):seq[mint] =
    result = newSeq[mint](a.len)
    let mask = (1 shl N) - 1
    for i in 0..<a.len:
      result[(not i) and mask] = a[i]
  var a = newSeqWith(2^N, mint(nextInt())).bit_invert
  var b = newSeqWith(2^N, mint(nextInt())).bit_invert
  echo OrConvolution(a, b).bit_invert.join(" ")

main()
