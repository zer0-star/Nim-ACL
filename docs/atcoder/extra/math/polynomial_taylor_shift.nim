when not declared ATCODER_POLYNOMIAL_TAYLOR_SHIFT_HPP:
  const ATCODER_POLYNOMIAL_TAYLOR_SHIFT_HPP* = 1
  import atcoder/extra/math/ntt
  import atcoder/extra/math/formal_power_series
  import atcoder/extra/math/combination
  import std/sequtils
  # https://judge.yosupo.jp/problem/polynomial_taylor_shift
  proc taylor_shift*[T](self:FormalPowerSeries[T], c:T):FormalPowerSeries[T] =
    let n = self.len
    var p = self
    for i in 0..<n: p[i] *= T.fact(i)
    p = p.rev()
    var bs = initFormalPowerSeries[T](newSeqWith(n, T(1)))
    for i in 1..<n:
      bs[i] = bs[i - 1] * c * T.rfact(i) * T.fact(i - 1)
    p = p * bs
    p = p.pre(n)
    #p = (p * bs).pre(n)
    # ここで0になる
    p = p.rev()
    for i in 0..<n: p[i] *= T.rfact(i)
    return p
