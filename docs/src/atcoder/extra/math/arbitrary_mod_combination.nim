when not declared ATCODER_ARBITRARY_MOD_COMBINATION_HPP:
  const ATCODER_ARBITRARY_MOD_COMBINATION_HPP* = 1
  import atcoder/internal_math, atcoder/math
  import std/math as math_lib
  
  const PRIME_POWER_BINOMIAL_M_MAX = ((2^30) - 1)
  
  type prime_power_binomial = object
    p, q, M:int
    fac, ifac:seq[int]
    delta:int
    bm, bp:Barrett
    N_MAX:int
  
  proc initPrimePowerBinomial(p, q:int, N_MAX:int):prime_power_binomial = 
    assert 1 < p and p <= PRIME_POWER_BINOMIAL_M_MAX
    assert q > 0
    var m = 1
    block:
      var q = q
      while q > 0:
        q.dec
        m *= p
        assert m <= PRIME_POWER_BINOMIAL_M_MAX
    var M = m
  
    #bm = Barrett(M), bp = Barrett(p);
    proc enumerate(self: var prime_power_binomial) =
      #let MX = min(M, PRIME_POWER_BINOMIAL_N_MAX + 10)
      let MX = min(M, self.N_MAX + 10)
      self.fac.setlen(MX)
      self.ifac.setlen(MX)
      self.fac[0] = 1
      self.ifac[0] = 1
      self.fac[1] = 1
      self.ifac[1] = 1
      block:
        var i = 2
        while i < MX:
          if i mod p == 0:
            self.fac[i] = self.fac[i - 1]
            #self.fac[i + 1] = bm.rem(1LL * fac[i - 1] * (i + 1));
            if i + 1 < MX:
              self.fac[i + 1] = self.bm.mul(self.fac[i - 1].uint, (i + 1).uint).int
            i.inc
          else:
            #fac[i] = bm.rem(1LL * fac[i - 1] * i)
            self.fac[i] = self.bm.mul(self.fac[i - 1].uint, i.uint).int
          i.inc
      self.ifac[MX - 1] = self.bm.pow(self.fac[MX - 1].uint, M div p * (p - 1) - 1).int
      block:
        var i = MX - 2
        if (MX - 1) mod p == 0:
          self.ifac[MX - 2] = self.ifac[MX - 1]
          i.dec
        while i > 1:
          if i mod p == 0:
            self.ifac[i] = self.bm.mul(self.ifac[i + 1].uint, (i + 1).uint).int
            self.ifac[i - 1] = self.ifac[i]
            i.dec
          else:
            self.ifac[i] = self.bm.mul(self.ifac[i + 1].uint, (i + 1).uint).int
          i.dec
  
    result = prime_power_binomial(p:p, q:q, M:M, bm:initBarrett(m.uint), bp:initBarrett(p.uint), N_MAX:N_MAX)
    result.enumerate()
    let delta = if p == 2 and q >= 3: 1 else: M - 1
    result.delta = delta
  
  proc Lucas(self: prime_power_binomial, n, m:int):int =
    result = 1
    var
      n = n
      m = m
    while n > 0:
      var n0, m0:int
      (n, n0) = self.bp.quorem(n.uint)
      (m, m0) = self.bp.quorem(m.uint)
      if n0 < m0: return 0
      result = self.bm.mul(result.uint, self.fac[n0].uint).int
      let buf = self.bm.mul(self.ifac[n0 - m0].uint, self.ifac[m0].uint).int
      result = self.bm.mul(result.uint, buf.uint).int
  
  proc C(self: prime_power_binomial, n, m:int):int =
    if n < m or n < 0 or m < 0: return 0
    if self.q == 1: return self.Lucas(n, m)
    block:
      var
        e0 = 0
        eq = 0
        i = 0
        r = n - m
        n = n
        m = m
      result = 1
      while n > 0:
        result = self.bm.mul(result.uint, self.fac[self.bm.rem(n)].uint).int
        result = self.bm.mul(result.uint, self.ifac[self.bm.rem(m)].uint).int
        result = self.bm.mul(result.uint, self.ifac[self.bm.rem(r)].uint).int
        n = self.bp.quo(n)
        m = self.bp.quo(m)
        r = self.bp.quo(r)
        let eps = n - m - r
        e0 += eps
        if e0 >= self.q: return 0
        i.inc
        if i >= self.q: eq += eps
      if (eq and 1) != 0: result = self.bm.mul(result.uint, self.delta.uint).int
      result = self.bm.mul(result.uint, self.bm.pow(self.p, e0).uint).int
  #
  #// constraints:
  #// (M <= 1e7 and max(N) <= 1e18) or (M < 2^30 and max(N) <= 2e7)
  
  type arbitrary_mod_binomial = object
    md: int
    M: seq[int]
    cs: seq[prime_power_binomial]
  
  proc initArbitraryModBinomial*(md:int, N_MAX = 10^7):arbitrary_mod_binomial =
    assert 1 <= md
    assert md <= PRIME_POWER_BINOMIAL_M_MAX
    var
      M = newSeq[int]()
      cs = newSeq[prime_power_binomial]()
    block:
      var md = md
      block:
        var i = 2
        while i * i <= md:
        #for (int i = 2; i * i <= md; i++) {
          if md mod i == 0:
            var
              j = 0
              k = 1
            while md mod i == 0:
              md = md div i
              j.inc
              k *= i
            M.add(k)
            cs.add(initPrimePowerBinomial(i, j, N_MAX))
            assert M[^1] == cs[^1].M
          i.inc
      if md != 1:
        M.add(md)
        cs.add(initPrimePowerBinomial(md, 1, N_MAX))
    assert M.len == cs.len
    return arbitrary_mod_binomial(md:md, M:M, cs:cs)
  
  proc C*(self:arbitrary_mod_binomial, n, m:int):int =
    if self.md == 1: return 0
    var rem, d:seq[int]
    for i in 0 ..< self.cs.len:
      rem.add(self.cs[i].C(n, m))
      d.add(self.M[i])
    return crt(rem, d)[0]

