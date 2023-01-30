# verify-helper: PROBLEM https://judge.yosupo.jp/problem/longest_increasing_subsequence

import atcoder/header, atcoder/extra/dp/longest_increasing_subsequence
import atcoder/extra/other/return_type
import sequtils, strutils

let N = nextInt()
var A = newSeqWith(N, nextInt())
var i = A.longest_increasing_subsequence(strict = true, return_type = Index)
echo i.len
echo i.join(" ")
