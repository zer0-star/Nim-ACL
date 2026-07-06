# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DPL_1_D

include atcoder/header

import atcoder/extra/dp/longest_increasing_subsequence

proc main() =
  let
    N = nextInt()
    A = newSeqWith(N, nextInt())
  echo longestIncreasingSubsequence(A, true)

main()
