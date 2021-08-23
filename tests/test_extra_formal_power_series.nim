import std/unittest
import atcoder/modint
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series

block:
  type mint = modint998244353
  let p = initFormalPowerSeries[mint]([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9, 3, 2, 3, 8, 4, 6, 2, 6])

  test "InvTest":
    let
      q = p.inv
    check q.len == p.len
    var r = initFormalPowerSeries[mint](p.len)
    r[0] = mint(1)
    check (p * q)[0..<p.len] == r

  test "ExpTest":
    let
      p = @[mint(0)] & p
      q = p.exp()
    check q.len == p.len
    check q.log()[0..<p.len] == p

  test "DivModTest":
    let m = initFormalPowerSeries[mint]([2, 7, 1, 8])
    let q = p div m
    let r = p mod m
    let ms = @[(0, mint(2)), (1, mint(7)), (2, mint(1)), (3, mint(8))]
    let dm = p.divMod(ms)
    check q * m + r == p
    check dm[0] == q
    check dm[1] == r

  test "powModTest":
    let
      m = initFormalPowerSeries[mint]([2, 7, 1, 8])
      a = 3782
      b = 9265
    let u = (powMod(p, a, m) * powMod(p, b, m) mod m)[0..<m.len-1]
    let v = powMod(p, a + b, m)
    check u == v

block:
  type mint = modint1000000007
  let p = initFormalPowerSeries[mint]([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9, 3, 2, 3, 8, 4, 6, 2, 6])
  test "InvTestArbitrary":
    let
      q = p.inv
    check q.len == p.len
    var r = initFormalPowerSeries[mint](p.len)
    r[0] = mint(1)
    check (p * q)[0..<p.len] == r

  test "ExpTestArbitrary":
    let
      p = @[mint(0)] & p
      q = p.exp()
    check q.len == p.len
    check q.log()[0..<p.len] == p

  test "DivModTestArbitrary":
    let m = initFormalPowerSeries[mint]([2, 7, 1, 8])
    let q = p div m
    let r = p mod m
    let ms = @[(0, mint(2)), (1, mint(7)), (2, mint(1)), (3, mint(8))]
    let dm = p.divMod(ms)
    check q * m + r == p
    check dm[0] == q
    check dm[1] == r

  test "powModTestArbitrary":
    let
      m = initFormalPowerSeries[mint]([2, 7, 1, 8])
      a = 3782
      b = 9265
    let u = (powMod(p, a, m) * powMod(p, b, m) mod m)[0..<m.len-1]
    let v = powMod(p, a + b, m)
    check u == v

block:
  type mint = modint
  mint.setMod(1000000009)
  let p = initFormalPowerSeries[mint]([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9, 3, 2, 3, 8, 4, 6, 2, 6])
  test "InvTestArbitraryDinamic":
    let
      q = p.inv
    check q.len == p.len
    var r = initFormalPowerSeries[mint](p.len)
    r[0] = mint(1)
    check (p * q)[0..<p.len] == r

  test "ExpTestArbitraryDinamic":
    let
      p = @[mint(0)] & p
      q = p.exp()
    check q.len == p.len
    check q.log()[0..<p.len] == p

  test "DivModTestArbitraryDinamic":
    let m = initFormalPowerSeries[mint]([2, 7, 1, 8])
    let q = p div m
    let r = p mod m
    let ms = @[(0, mint(2)), (1, mint(7)), (2, mint(1)), (3, mint(8))]
    let dm = p.divMod(ms)
    check q * m + r == p
    check dm[0] == q
    check dm[1] == r

  test "powModTestArbitraryDinamic":
    let
      m = initFormalPowerSeries[mint]([2, 7, 1, 8])
      a = 3782
      b = 9265
    let u = (powMod(p, a, m) * powMod(p, b, m) mod m)[0..<m.len-1]
    let v = powMod(p, a + b, m)
    check u == v
