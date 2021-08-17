when not declared ATCODER_LAGLANGE_POLYNOMIAL_HPP:
  const ATCODER_LAGLANGE_POLYNOMIAL_HPP* = 1
  import std/sequtils
  import atcoder/extra/math/combination
  proc lagrange_polynomial*[T](y:seq[T], t:int):T =
    let N = y.len - 1
    if t <= N: return y[t]
    result = 0
    var dp = newSeqWith(N + 1, T(1))
    var pd = newSeqWith(N + 1, T(1))
    for i in 0..<N: dp[i + 1] = dp[i] * (t - i)
    for i in countdown(N, 1): pd[i - 1] = pd[i] * (t - i)
    for i in 0..N:
      let tmp = y[i] * dp[i] * pd[i] * T.rfact(i) * T.rfact(N - i)
      if ((N - i) and 1) != 0: result -= tmp
      else: result += tmp
