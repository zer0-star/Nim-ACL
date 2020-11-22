# TODO incomplete...
when not declared ATCODER_COMPOSITION_HPP:
  const ATCODER_COMPOSITION_HPP* = 1
  import std/math, std/bitops, std/sequtils
  import atcoder/modint
  import atcoder/extra/math/ntt
  import atcoder/extra/math/formal_power_series

  proc mat_mul[T](A, B:seq[FormalPowerSeries[T]]):auto =
    let
      N = A.len
      K = A[0].len
      M = B[0].len
    result = newSeq[FormalPowerSeries[T]](N)
    for i in 0..<N:result[i] = initFormalPowerSeries[T](M)
    for i in 0..<N:
      for j in 0..<M:
        for k in 0..<K:
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
      PS[i] = ifft(dot(PS[i].fft, Pomega1, T), T)
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
      TS[i] = ifft(dot(TS[i].fft, Tomega1, T), T)
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
