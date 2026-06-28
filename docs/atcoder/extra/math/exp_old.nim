# F(0) must be 0
proc exp*[T](self: FormalPowerSeries[T], deg = -1):auto =
  assert EQUAL(self[0], T(0))
  deg.revise(self.len)
   when T is ModInt:
  when true:
    proc onlineConvolutionExp[T](self, conv_coeff:FormalPowerSeries[T]):auto =
      let n = conv_coeff.len
      assert((n and (n - 1)) == 0)
      type FFTType = fft(initFormalPowerSeries[T](0)).type
      var
        conv_ntt_coeff = newSeq[FFTType]()
        i = n
      while (i shr 1) > 0:
        var g = conv_coeff.pre(i)
        conv_ntt_coeff.add(fft(g))
        i = i shr 1
      var conv_arg, conv_ret = initFormalPowerSeries[T](n)
      proc rec(l,r,d:int) =
        if r - l <= 16:
          for i in l..<r:
            var sum = T(0)
            for j in l..<i: sum += conv_arg[j] * conv_coeff[i - j]
            conv_ret[i] += sum
            conv_arg[i] = if i == 0: T(1) else: conv_ret[i] / T(i)
        else:
          var m = (l + r) div 2
          rec(l, m, d + 1)
          var pre = initFormalPowerSeries[T](r - l)
          pre[0..<m-l] = conv_arg[l..<m]
          pre = ifft(dot(fft(pre), conv_ntt_coeff[d], T), T)
          for i in 0..<r - m: conv_ret[m + i] += pre[m + i - l]
          rec(m, r, d + 1)
      rec(0, n, 0)
      return conv_arg
    proc expRec[T](self: FormalPowerSeries[T]):auto =
       assert self[0] == T(0)
      let n = self.len
      var m = 1
      while m < n: m *= 2
      var conv_coeff = initFormalPowerSeries[T](m)
      for i in 1..<n: conv_coeff[i] = self[i] * T(i)
      return self.onlineConvolutionExp(conv_coeff).pre(n)
    var ret = self
    ret.setlen(deg)
    return ret.expRec()

