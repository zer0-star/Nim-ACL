import std/unittest
import atcoder/extra/math/fft
import atcoder/element_concepts
import atcoder/extra/math/formal_power_series

#let p = initFormalPowerSeries[float](@[3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9, 3, 2, 3, 8, 4, 6, 2, 6])
let p = initFormalPowerSeries[float](@[3, 1, 4])

const EPS = 0.0000001

proc EQUAL(a, b:float):bool =
  if abs(a - b) < EPS: return true
  if abs(a) > EPS and abs((a - b) / a) < EPS:return true
  if abs(b) > EPS and abs((a - b) / b) < EPS:return true
  return false


proc EQUAL(a, b:seq[SomeFloat]):bool =
  check a.len == b.len
  for i in 0..<a.len:
    if not EQUAL(a[i], b[i]): return false
  return true

test "InvTest":
  let q = p.inv
  check q.len == p.len
  var r = initFormalPowerSeries[float](p.len)
  r[0] = 1.0
  check EQUAL((p * q)[0..<p.len], r)

test "ExpTest":
  let
    p = @[0.0] & p
    q = p.exp()
  check q.len == p.len
  check EQUAL(q.log()[0..<p.len], p)

test "DivModTest":
  let m = initFormalPowerSeries[float](@[2, 7, 1, 8])
  let q = p div m
  let r = p mod m
  check EQUAL(q * m + r, p)

test "powModTest":
  let
    m = initFormalPowerSeries[float](@[2, 7, 1, 8])
    a = 5
    b = 6
  let u = (powMod(p, a, m) * powMod(p, b, m) mod m)[0..<m.len-1]
  let v = powMod(p, a + b, m)
  check EQUAL(u, v)
