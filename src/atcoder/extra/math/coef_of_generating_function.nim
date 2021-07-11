when not defined ATCODER_COEF_OF_GENERATING_FUNCTION_HPP:
  const ATCODER_COEF_OF_GENERATING_FUNCTION_HPP* = 1
  import atcoder/extra/math/formal_power_series
  import atcoder/element_concepts
  type RationalFormalPowerSeries*[T] = object
    num, den: FormalPowerSeries[T]
  proc `//`*[T:FieldElem](P, Q:FormalPowerSeries[T]):RationalFormalPowerSeries[T] =
    RationalFormalPowerSeries[T](num:P, den:Q)
  # P / Q‚Ì“YŽšN‚Ì—v‘f‚ðŒvŽZ
  proc `[]`*[T:FieldElem](r:RationalFormalPowerSeries[T],N:int):T =
    var
      P = r.num
      Q = r.den
      N = N
    assert Q[0] != 0
    if Q[0] != 1:
      let t = Q[0].inv
      P *= t;Q *= t
    assert Q[0] == 1
    var q = initFormalPowerSeries[T](0)
    if Q.len > P.len + 1:
      P.setLen(Q.len - 1)
    elif Q.len < P.len + 1:
      q = P div Q
      P = P mod Q
      if N < q.len: result += q[N]
#    Q.setLen(P.len + 1)
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
    result += P[0]
