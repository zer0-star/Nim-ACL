when not declared ATCODER_FACTORIZATION_HPP:
  const ATCODER_FACTORIZATION_HPP* = 1
  import math, bitops
  proc mul(a, b, m:int):int {.importcpp: "(__int128)(#) * (#) % (#)", nodecl.}
  proc power(a, b, m:int):int =
    var (a, b) = (a, b)
    result = 1
    while b != 0:
      if (b and 1) != 0: result = mul(result, a, m)
      a = mul(a, a, m)
      b = b shr 1
  proc isPrime*(n:int):bool =
    if n != 2 and n mod 2 == 0: return false
    var
      d = n - 1
      s = countTrailingZeroBits(d)
    d = d shr s
    var A:seq[int]
    if n <= 10^9:
      A = @[2, 3, 5, 7]
    else:
      A = @[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37]
    for a in A:
      var
        p = power(a, d, n)
        i = s
      while p != 1 and p != n - 1 and a mod n != 0:
        i.dec
        if i == 0: break
        p = mul(p, p, n);
      if p != n - 1 and i != s: return false
    return true
  
  proc rho(n:int):int =
    proc f(a:int):auto = mul(a, a, n) + 1
    var
      (x,y,p,i,t) = (0,0,2,1,0)
      q:int
    while t mod 40 != 0 or gcd(p, n) == 1:
      t.inc
      if x == y:
        i.inc
        x = i
        y = f(x)
      q = mul(p, abs(y - x), n)
      if q != 0:p = q
      x = f(x)
      y = f(f(y))
    return gcd(p, n)
  
  proc factor*(n:int):seq[int] =
    if n == 1: return @[]
    if isPrime(n): return @[n]
    var a = rho(n)
    assert a != n and a != 1
    result = factor(a)
    result &= factor(n div a)
