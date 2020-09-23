# TODO incomplete...
  import std/math, std/bitops

  proc mat_mul[T](A, B:seq[FormalPowerSeries[T]]):auto =
    let N = A.len
    result = newSeq[FormalPowerSeries[T]](N)
    for i in 0..<N:result[i] = initFormalPowerSeries[T](N)
    for i in 0..<N:
      for j in 0..<N:
        for k in 0..<N:
          result[i][j] += A[i][k] * B[k][j]

  # composition: calc Q(P(x)) {{{
  proc composition*[T](P, Q:FormalPowerSeries[T], deg = -1):FormalPowerSeries[T] =
    discard
    deg.revise(min(P.len, Q.len))
    if deg == 0: return @[]
    var (P, Q) = (P, Q)
    P.shrink()
    if P.len == 0:
      var R = initFormalPowerSeries[T](deg)
      R[0] = if Q.len == 0: T(0) else: Q[0]
      return R
    if deg == 1: return initFormalPowerSeries[T](@[Q.eval(P[0])])
  
    let K = max(ceil(sqrt(deg.float)).int, 2)
    assert deg <= K * K
  
    var PS = newSeq[FormalPowerSeries[T]](K + 1)
    # step 1
    PS[0] = initFormalPowerSeries[T](deg)
    PS[0][0] = T(1)
    PS[1] = P
  #  if (fps::ntt_ptr == nullptr) {
  #    for (int i = 2; i <= K; i++) PS[i] = (PS[i - 1] * P).pre(N);
  #  } else {
    let l = 1 shl (64 - countLeadingZeroBits(2 * deg - 2))
    var Pomega = initFormalPowerSeries[T](l)
    Pomega[0..<P.len] = P
    let Pomega1 = Pomega.fft()
    for i in 2..K:
      PS[i].setLen(l)
      for j in 0..<deg: PS[i][j] = PS[i - 1][j]
      PS[i] = ifft(dot(PS[i].fft, Pomega1))
      PS[i].setLen(deg)
  #    PS[i].shrink_to_fit()
  
    var TS = newSeq[FormalPowerSeries[T]](K)
  #  vector<fps> TS(K);
  #  {
      # step 2
    TS[0].setLen(deg)
    TS[0][0] = T(1)
    TS[1] = PS[K]
  #    if (fps::ntt_ptr == nullptr) {
  #      for (int i = 2; i < K; i++) TS[i] = (TS[i - 1] * TS[1]).pre(N);
  #    } else {
  #  len = 1 shl (64 - countLeadingZeroBits(2 * deg - 2));
    var Tomega = initFormalPowerSeries[T](l)
    Tomega[0..<TS[1].len] = TS[1]
  #  var Tomega = TS[1]
  #  Tomega.resize(len);
    let Tomega1 = Tomega.fft()
  #  Tomega.ntt();
    for i in 2..<K:
      TS[i].setLen(l)
      TS[i][0..<deg] = TS[i - 1][0..<deg]
      TS[i] = ifft(dot(TS[i].fft, Tomega))
  #    TS[i].ntt();
  #    for (int j = 0; j < len; j++) TS[i][j] *= Tomega[j];
  #    TS[i].intt();
      TS[i].setLen(deg)
  #    TS[i].shrink_to_fit();
  
    # step 3
    var QP = newSeq[FormalPowerSeries[T]]()
    discard PS.pop()
    var QS = newSeqWith(K, initFormalPowerSeries[T](K))
  #  vector<fps> QS(K, fps(K, mint()));
    for i in 0..<K:
      for j in 0..<K:
        let t = i * K + j
        QS[i][j] = if t < Q.len: Q[t] else: T(0)
  #  QP = FastMatProd::strassen(QS, PS);
    QP = mat_mul(QS, PS)
  
    var ans = initFormalPowerSeries[T](deg)
    # step 4,5
    for i in 0..<K: ans += (QP[i] * TS[i]).pre(deg)
    return ans






#  P.setLen(deg)
#  Q.setLen(deg)
#  let
#    M = max(1, sqrt(deg.float / log2(deg.float)).int)
#    L = (deg + M - 1) div M
#    Pm = P[0..<M]
#    Pr = P[M..^1]
#
#  let J = 31 - countLeadingZeroBits(deg - 1) + 1 + 32
#  var pms = newSeq[FormalPowerSeries[T]](J)
#  pms[0] = Pm
#  for i in 1..<J: pms[i] = (pms[i - 1] * pms[i - 1]).pre(deg)
#
#  proc comp(left, j:int, Qd:FormalPowerSeries[T], deg:int):FormalPowerSeries[T] =
#    if j == 1:
#      let
#        Q1 = if left + 0 < Qd.len: Qd[left + 0] else: T(0)
#        Q2 = if left + 1 < Qd.len: Qd[left + 1] else: T(0)
#      return (pms[0].pre(deg) * Q2 + Q1).pre(deg)
#    if Qd.len <= left: return @[]
#    let
#      Q1 = comp(left, j - 1, Qd, deg)
#      Q2 = comp(left + (1 shl (j - 1)), j - 1, Qd, deg)
#    return (Q1 + pms[j - 1].pre(deg) * Q2).pre(deg)
#
#  var
#    QPm = comp(0, J, Q, deg)
#    R = QPm
#    pw_Pr = initFormalPowerSeries[T](@[T(1)])
#    dPm = Pm.diff()
#  dPm.shrink()
#  if not (dPm.len == 0 or dPm[0] != 0):
#    echo dPm
#  assert(dPm.len == 0 or dPm[0] != 0)
#  var
#    idPm = if dPm.len == 0: @[] else: dPm.inv(deg)
#    l = 1
#    d = M
#  while l <= L and deg > d:
#    pw_Pr = (pw_Pr * Pr).pre(deg - d)
#    if dPm.len == 0:
#      R += (pw_Pr * Q[l]) shl d
#    else:
#      idPm.setLen(deg - d)
#      QPm = (QPm.diff().pre(deg - d) * idPm).pre(deg - d)
#      R += ((QPm * pw_Pr).pre(deg - d) * T.rfact(l)) shl d
#    l.inc
#    d += M
#  R.setLen(deg)
#  return R



