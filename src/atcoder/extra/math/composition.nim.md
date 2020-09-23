---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# TODO incomplete...\n  import std/math, std/bitops\n\n  proc mat_mul[T](A,\
    \ B:seq[FormalPowerSeries[T]]):auto =\n    let N = A.len\n    result = newSeq[FormalPowerSeries[T]](N)\n\
    \    for i in 0..<N:result[i] = initFormalPowerSeries[T](N)\n    for i in 0..<N:\n\
    \      for j in 0..<N:\n        for k in 0..<N:\n          result[i][j] += A[i][k]\
    \ * B[k][j]\n\n  # composition: calc Q(P(x)) {{{\n  proc composition*[T](P, Q:FormalPowerSeries[T],\
    \ deg = -1):FormalPowerSeries[T] =\n    discard\n    deg.revise(min(P.len, Q.len))\n\
    \    if deg == 0: return @[]\n    var (P, Q) = (P, Q)\n    P.shrink()\n    if\
    \ P.len == 0:\n      var R = initFormalPowerSeries[T](deg)\n      R[0] = if Q.len\
    \ == 0: T(0) else: Q[0]\n      return R\n    if deg == 1: return initFormalPowerSeries[T](@[Q.eval(P[0])])\n\
    \  \n    let K = max(ceil(sqrt(deg.float)).int, 2)\n    assert deg <= K * K\n\
    \  \n    var PS = newSeq[FormalPowerSeries[T]](K + 1)\n    # step 1\n    PS[0]\
    \ = initFormalPowerSeries[T](deg)\n    PS[0][0] = T(1)\n    PS[1] = P\n  #  if\
    \ (fps::ntt_ptr == nullptr) {\n  #    for (int i = 2; i <= K; i++) PS[i] = (PS[i\
    \ - 1] * P).pre(N);\n  #  } else {\n    let l = 1 shl (64 - countLeadingZeroBits(2\
    \ * deg - 2))\n    var Pomega = initFormalPowerSeries[T](l)\n    Pomega[0..<P.len]\
    \ = P\n    let Pomega1 = Pomega.fft()\n    for i in 2..K:\n      PS[i].setLen(l)\n\
    \      for j in 0..<deg: PS[i][j] = PS[i - 1][j]\n      PS[i] = ifft(dot(PS[i].fft,\
    \ Pomega1))\n      PS[i].setLen(deg)\n  #    PS[i].shrink_to_fit()\n  \n    var\
    \ TS = newSeq[FormalPowerSeries[T]](K)\n  #  vector<fps> TS(K);\n  #  {\n    \
    \  # step 2\n    TS[0].setLen(deg)\n    TS[0][0] = T(1)\n    TS[1] = PS[K]\n \
    \ #    if (fps::ntt_ptr == nullptr) {\n  #      for (int i = 2; i < K; i++) TS[i]\
    \ = (TS[i - 1] * TS[1]).pre(N);\n  #    } else {\n  #  len = 1 shl (64 - countLeadingZeroBits(2\
    \ * deg - 2));\n    var Tomega = initFormalPowerSeries[T](l)\n    Tomega[0..<TS[1].len]\
    \ = TS[1]\n  #  var Tomega = TS[1]\n  #  Tomega.resize(len);\n    let Tomega1\
    \ = Tomega.fft()\n  #  Tomega.ntt();\n    for i in 2..<K:\n      TS[i].setLen(l)\n\
    \      TS[i][0..<deg] = TS[i - 1][0..<deg]\n      TS[i] = ifft(dot(TS[i].fft,\
    \ Tomega))\n  #    TS[i].ntt();\n  #    for (int j = 0; j < len; j++) TS[i][j]\
    \ *= Tomega[j];\n  #    TS[i].intt();\n      TS[i].setLen(deg)\n  #    TS[i].shrink_to_fit();\n\
    \  \n    # step 3\n    var QP = newSeq[FormalPowerSeries[T]]()\n    discard PS.pop()\n\
    \    var QS = newSeqWith(K, initFormalPowerSeries[T](K))\n  #  vector<fps> QS(K,\
    \ fps(K, mint()));\n    for i in 0..<K:\n      for j in 0..<K:\n        let t\
    \ = i * K + j\n        QS[i][j] = if t < Q.len: Q[t] else: T(0)\n  #  QP = FastMatProd::strassen(QS,\
    \ PS);\n    QP = mat_mul(QS, PS)\n  \n    var ans = initFormalPowerSeries[T](deg)\n\
    \    # step 4,5\n    for i in 0..<K: ans += (QP[i] * TS[i]).pre(deg)\n    return\
    \ ans\n\n\n\n\n\n\n#  P.setLen(deg)\n#  Q.setLen(deg)\n#  let\n#    M = max(1,\
    \ sqrt(deg.float / log2(deg.float)).int)\n#    L = (deg + M - 1) div M\n#    Pm\
    \ = P[0..<M]\n#    Pr = P[M..^1]\n#\n#  let J = 31 - countLeadingZeroBits(deg\
    \ - 1) + 1 + 32\n#  var pms = newSeq[FormalPowerSeries[T]](J)\n#  pms[0] = Pm\n\
    #  for i in 1..<J: pms[i] = (pms[i - 1] * pms[i - 1]).pre(deg)\n#\n#  proc comp(left,\
    \ j:int, Qd:FormalPowerSeries[T], deg:int):FormalPowerSeries[T] =\n#    if j ==\
    \ 1:\n#      let\n#        Q1 = if left + 0 < Qd.len: Qd[left + 0] else: T(0)\n\
    #        Q2 = if left + 1 < Qd.len: Qd[left + 1] else: T(0)\n#      return (pms[0].pre(deg)\
    \ * Q2 + Q1).pre(deg)\n#    if Qd.len <= left: return @[]\n#    let\n#      Q1\
    \ = comp(left, j - 1, Qd, deg)\n#      Q2 = comp(left + (1 shl (j - 1)), j - 1,\
    \ Qd, deg)\n#    return (Q1 + pms[j - 1].pre(deg) * Q2).pre(deg)\n#\n#  var\n\
    #    QPm = comp(0, J, Q, deg)\n#    R = QPm\n#    pw_Pr = initFormalPowerSeries[T](@[T(1)])\n\
    #    dPm = Pm.diff()\n#  dPm.shrink()\n#  if not (dPm.len == 0 or dPm[0] != 0):\n\
    #    echo dPm\n#  assert(dPm.len == 0 or dPm[0] != 0)\n#  var\n#    idPm = if\
    \ dPm.len == 0: @[] else: dPm.inv(deg)\n#    l = 1\n#    d = M\n#  while l <=\
    \ L and deg > d:\n#    pw_Pr = (pw_Pr * Pr).pre(deg - d)\n#    if dPm.len == 0:\n\
    #      R += (pw_Pr * Q[l]) shl d\n#    else:\n#      idPm.setLen(deg - d)\n# \
    \     QPm = (QPm.diff().pre(deg - d) * idPm).pre(deg - d)\n#      R += ((QPm *\
    \ pw_Pr).pre(deg - d) * T.rfact(l)) shl d\n#    l.inc\n#    d += M\n#  R.setLen(deg)\n\
    #  return R\n\n\n\n"
  dependsOn: []
  isVerificationFile: false
  path: src/atcoder/extra/math/composition.nim
  requiredBy: []
  timestamp: '2020-09-22 00:56:23+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/atcoder/extra/math/composition.nim
layout: document
redirect_from:
- /library/src/atcoder/extra/math/composition.nim
- /library/src/atcoder/extra/math/composition.nim.html
title: src/atcoder/extra/math/composition.nim
---
