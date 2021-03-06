when not declared ATCODER_ERATOSTHENES_HPP:
  const ATCODER_ERATOSTHENES_HPP* = 1
  type Eratosthenes* = object
    n*:int
    pdiv*, prime*, index:seq[int]
  proc propagate(self:var Eratosthenes, i:int) =
    let p = self.prime[i]
    while self.index[i] < self.n:
      self.pdiv[self.index[i]] = p
      self.index[i] += p
  proc expand(self:var Eratosthenes, n = -1) =
    if n != -1 and n < self.n: return
    let n = if n == -1: self.n * 2 else: max(self.n * 2, n)
    self.pdiv.setLen(n)
    let old_n = self.n
    self.n = n
    for i in old_n ..< self.n:self.pdiv[i] = i
    for i,p in self.prime:
      if p * p > self.n: break
      self.propagate(i)
    for p in old_n ..< self.n:
      if self.pdiv[p] == p:
        self.prime.add(p)
        self.index.add(p * p)
        self.propagate(self.prime.len - 1)
    self.n = n
  proc initEratosthenes*(n = 10000):Eratosthenes =
    result = Eratosthenes(n: 2, pdiv: @[0,0])
    result.expand(n)
  proc isPrime*(self:var Eratosthenes, n:int): bool =
    self.expand(n + 1)
    return n != 1 and self.pdiv[n] == n
  proc primeDivisor*(self:var Eratosthenes, n:int):int =
    self.expand(n + 1)
    return self.pdiv[n]
  proc factor*(self:var Eratosthenes, n:int): seq[(int,int)] =
    result = newSeq[(int,int)]()
    var n = n
    while n > 1:
      let p = self.primeDivisor(n)
      var e = 0
      while n mod p == 0: e.inc;n = n div p
      result.add (p, e)
  proc getPrime*(self:var Eratosthenes, i:int):int =
    while i >= self.prime.len: self.expand()
    return self.prime[i]
