import "~/git/nim-decimal/decimal/decimal"
import "~/git/nim-decimal/decimal/decimal_lowlevel"
import atcoder/extra/other/floatutils
import atcoder/extra/other/static_var

converter toDecimal*(a:int):DecimalType = newDecimal(a)
converter toDecimal*(s:string):DecimalType = newDecimal(s)

proc calcPi*[Real]():Real =
  var
    a = Real(1)
    b = Real(1) / sqrt(Real(2))
    c = Real(1) / Real(4)
    d = Real(1)

  var prev = newDecimal(0)

  while true:
    let p = (a + b)^2/(Real(4) * c)
    if p == prev: break
    prev = p
    var
      na = (a + b) / Real(2)
      nb = sqrt(a * b)
      nc = c - d * (a - na)^2
      nd = Real(2) * d
    swap(na, a)
    swap(nb, b)
    swap(nc, c)
    swap(nd, d)
  return prev

proc initPrec*(Real:typedesc[DecimalType], n:int) =
  setPrec(n)
  var INF_VAL = newDecimal()
  mpd_setspecial(INF_VAL[], MPD_POS, MPD_INF)
  DecimalType:::pi = calcPi[Real]()
  DecimalType:::eps = newDecimal(10)^(-(n - 5))
  DecimalType:::inf = INF_VAL

#  DecimalType.getParameters()[] = (n, calcPi[Real](), newDecimal(10)^(-(n - 5)), INF_VAL)

proc sin_impl*(x:DecimalType):DecimalType =
  result = newDecimal(0)
  let mx2 = - x * x
  var
    i = 1
    p = x
  while true:
    var next = result + p
    if next == result: break
    result = next.move()
    p *= mx2 / ((i + 1) * (i + 2))
    i += 2

proc sin*(x:DecimalType):DecimalType =
  let r = rem(x, ((DecimalType:::pi) * 2))
  return sin_impl(r)

proc cos_impl(x:DecimalType):DecimalType =
  result = newDecimal(0)
  let mx2 = - x * x
  var
    i = 0
    p = newDecimal(1)
  while true:
    var next = result + p
    if next == result: break
    result = next.move()
    p *= mx2 / ((i + 1) * (i + 2))
    i += 2

proc cos*(x:DecimalType):DecimalType =
  let r = rem(x, ((DecimalType:::pi) * 2))
  return cos_impl(r)

proc tan*(x:DecimalType):DecimalTYpe = sin(x) / cos(x)

proc sinh*(x:DecimalType):DecimalType =
  return (exp(x) - exp(-x)) / newDecimal(2)

proc cosh*(x:DecimalType):DecimalType =
  return (exp(x) + exp(-x)) / newDecimal(2)

proc hypot*(x, y:DecimalType):DecimalType = sqrt(x * x + y * y)

proc pow*(a, b:DecimalType):DecimalType = a ^ b

proc arcsin*(x:DecimalType):DecimalType =
  result = newDecimal(0)
  var
    n = 0
    p = x
    t = 1 / newDecimal(2)
    x2 = x * x
  while true:
    var next = result + p / (2 * n + 1)
    if next == result: break
    swap(next, result)

    p *= t
    p *= x2
    t += 1
    n.inc
    p /= n

proc arccos*(x:DecimalType):DecimalType =
  (DecimalType:::pi) / newDecimal(2) - arcsin(x)

proc arctan2*(y, x:DecimalType):DecimalType =
  var
    a = x / sqrt(x * x + y * y)
    b = newDecimal(1)
  while true:
    var
      na = (a + b) / 2
      nb = sqrt(na * b)
    if na == a:break
    a = na.move
    b = nb.move
  return y / (a * sqrt(x * x + y * y))
proc arctan*(x:DecimalType):DecimalType =
  return arctan2(x, newDecimal(1))

proc round*(x:DecimalType):DecimalType = round_to_int(x)
