---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# F(0) must be 0\r\nproc exp*[T](self: FormalPowerSeries[T], deg = -1):auto\
    \ =\r\n  assert EQUAL(self[0], T(0))\r\n  deg.revise(self.len)\r\n   when T is\
    \ ModInt:\r\n  when true:\r\n    proc onlineConvolutionExp[T](self, conv_coeff:FormalPowerSeries[T]):auto\
    \ =\r\n      let n = conv_coeff.len\r\n      assert((n and (n - 1)) == 0)\r\n\
    \      type FFTType = fft(initFormalPowerSeries[T](0)).type\r\n      var\r\n \
    \       conv_ntt_coeff = newSeq[FFTType]()\r\n        i = n\r\n      while (i\
    \ shr 1) > 0:\r\n        var g = conv_coeff.pre(i)\r\n        conv_ntt_coeff.add(fft(g))\r\
    \n        i = i shr 1\r\n      var conv_arg, conv_ret = initFormalPowerSeries[T](n)\r\
    \n      proc rec(l,r,d:int) =\r\n        if r - l <= 16:\r\n          for i in\
    \ l..<r:\r\n            var sum = T(0)\r\n            for j in l..<i: sum += conv_arg[j]\
    \ * conv_coeff[i - j]\r\n            conv_ret[i] += sum\r\n            conv_arg[i]\
    \ = if i == 0: T(1) else: conv_ret[i] / T(i)\r\n        else:\r\n          var\
    \ m = (l + r) div 2\r\n          rec(l, m, d + 1)\r\n          var pre = initFormalPowerSeries[T](r\
    \ - l)\r\n          pre[0..<m-l] = conv_arg[l..<m]\r\n          pre = ifft(dot(fft(pre),\
    \ conv_ntt_coeff[d], T), T)\r\n          for i in 0..<r - m: conv_ret[m + i] +=\
    \ pre[m + i - l]\r\n          rec(m, r, d + 1)\r\n      rec(0, n, 0)\r\n     \
    \ return conv_arg\r\n    proc expRec[T](self: FormalPowerSeries[T]):auto =\r\n\
    \       assert self[0] == T(0)\r\n      let n = self.len\r\n      var m = 1\r\n\
    \      while m < n: m *= 2\r\n      var conv_coeff = initFormalPowerSeries[T](m)\r\
    \n      for i in 1..<n: conv_coeff[i] = self[i] * T(i)\r\n      return self.onlineConvolutionExp(conv_coeff).pre(n)\r\
    \n    var ret = self\r\n    ret.setlen(deg)\r\n    return ret.expRec()\r\n\r\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/exp_old.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/exp_old.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/exp_old.nim
- /library/atcoder/extra/math/exp_old.nim.html
title: atcoder/extra/math/exp_old.nim
---
