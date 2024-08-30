when not declared ATCODER_ONLINE_CONVOLUTION_HPP:
  import std/sequtils, atcoder/convolution
  const ATCODER_ONLINE_CONVOLUTION_HPP* = 1
  type RelaxedMultiplication*[T] = object
    f, g, h:seq[T]
    n:int

  proc initRelaxedMultiplication*[T]():RelaxedMultiplication[T] =
    RelaxedMultiplication[T](n:0)

  proc add*[T](self:var RelaxedMultiplication[T], a, b:T):T =
    proc calc(self:var RelaxedMultiplication[T], l1, r1, l2, r2:int) =
      let L = r1 + r2 - 1 - len(self.h)
      if L > 0:
        self.h &= T(0).repeat(r1 + r2 - 1 - len(self.h))
      for i, a in convolution(self.f[l1 ..< r1], self.g[l2 ..< r2]):
        let i = l1 + l2 + i
        self.h[i] = self.h[i] + a

    self.f.add(a)
    self.g.add(b)
    self.n += 1
    var
      n = self.n
      m = (n + 1) and -(n + 1)
      s = 0
    if m <= n:
      var d = 1
      while d <= m:
        self.calc(n - d, n, s, s + d)
        self.calc(s, s + d, n - d, n)
        s += d
        d = d shl 1
    else:
      var d = 1
      while d < (m shr 1):
        self.calc(n - d, n, s, s + d)
        self.calc(s, s + d, n - d, n)
        s += d
        d = d shl 1
      self.calc(n - d, n, s, s + d)
    return self.h[n-1]
