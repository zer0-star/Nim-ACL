when not defined ATCODER_COEF_OF_GENERATING_FUNCTION_HPP:
  const ATCODER_COEF_OF_GENERATING_FUNCTION_HPP* = 1
  import atcoder/extra/math/formal_power_series
  import atcoder/element_concepts
  # P / Q‚Ì“YŽšN‚Ì—v‘f‚ðŒvŽZ
  proc coef_of_generating_function*[T:FieldElem](P,Q:FormalPowerSeries[T],N:int):auto =
    assert Q[0] == 1
    var (P, Q, N) = (P, Q, N)
    assert Q.len <= P.len + 1, "too long: Q"
    Q.setLen(P.len + 1)
    while N > 0:
      var Q1 = Q
      for i in countup(0, Q.len - 1, 2): Q1[i] = Q[i]
      for i in countup(1, Q.len - 1, 2): Q1[i] = -Q[i]
      block:
        var PQ1 = P * Q1
        P.setLen(0)
        for i in countup(N mod 2, PQ1.len - 1, 2): P.add(PQ1[i])
        var QQ1 = Q * Q1
        Q.setLen(0)
        for i in countup(0, QQ1.len - 1, 2): Q.add(QQ1[i])
      N = N div 2
    return P[0]
