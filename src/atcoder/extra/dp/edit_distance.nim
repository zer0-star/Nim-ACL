# editDistance(S, T:string) {{{
import sequtils

proc editDistance(S,T:string):int =
  let
    N = S.len
    M = T.len
  dump(S)
  dump(T)
  var dp = newSeqWith(N + 1, newSeqWith(M + 1, N + M))
  for i in 0..N: dp[i][0] = i
  for j in 0..M: dp[0][j] = j
  for i in 1..N:
    for j in 1..M:
      dp[i][j] = min(dp[i][j], dp[i - 1][j] + 1)
      dp[i][j] = min(dp[i][j], dp[i][j - 1] + 1)
      dp[i][j] = min(dp[i][j], dp[i - 1][j - 1] + (if S[i - 1] != T[j - 1]: 1 else: 0))
  return dp[N][M]
# }}}
