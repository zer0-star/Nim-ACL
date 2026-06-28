import atcoder/extra/other/decimal_gmp
import atcoder/extra/other/floatutils
import atcoder/extra/other/static_var

#converter toDecimal*(a:int):Decimal = Decimal(a)
#converter toDecimal*(s:string):Decimal = Decimal(s)

proc calcPi*[Real]():Real =
  var
    a = Real(1)
    b = Real(1) / sqrt(Real(2))
    c = Real(1) / Real(4)
    d = Real(1)

  var prev = Decimal(0)

  while true:
    let s = a + b
    let p = s * s / (Real(4) * c)
    if p == prev: break
    prev = p
    var
      na = (a + b) / Real(2)
      nb = sqrt(a * b)
      nc = c - d * (a - na) * (a - na)
      nd = Real(2) * d
    #swap(na, a)
    #swap(nb, b)
    #swap(nc, c)
    #swap(nd, d)
    a = na.move
    b = nb.move
    c = nc.move
    d = nd.move
  return prev

proc exp*(x:Decimal):Decimal =
  result = Decimal(0)
  var
    p = Decimal(1)
    i = 0
  while true:
    var result_old = result.clone()
    result += p
    if result == result_old: break
    p *= x
    i.inc
    p /= Decimal(i)

proc initPrec*(Real:typedesc[Decimal], n:int) =
  setPrec(n)
  # とりあえずINFは呼ばないように
  var INF_VAL = Decimal(0)
  #mpd_setspecial(INF_VAL[], MPD_POS, MPD_INF)
  #Decimal$.pi = calcPi[Real]()
  #Decimal$.eps = Decimal(10)^(-(n div 5 - 5))
  #Decimal$.eps = Decimal(1) / Decimal(10)^(n div 4)
  #Decimal$.inf = INF_VAL
  #echo "eps: ", Decimal$.eps

  Decimal.getParameters()[] = (n, calcPi[Real](), machine_epsilon() * Decimal(10)^10, INF_VAL)

proc sin_impl*(x:Decimal):Decimal =
  result = Decimal(0)
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

proc sin*(x:Decimal):Decimal =
  let r = rem(x, ((Decimal$.pi) * 2))
  return sin_impl(r)

proc cos_impl(x:Decimal):Decimal =
  result = Decimal(0)
  let mx2 = - x * x
  var
    i = 0
    p = Decimal(1)
  while true:
    var next = result + p
    if next == result: break
    result = next.move()
    p *= mx2 / ((i + 1) * (i + 2))
    i += 2

proc cos*(x:Decimal):Decimal =
  let r = rem(x, ((Decimal$.pi) * 2))
  return cos_impl(r)

proc tan*(x:Decimal):Decimal = sin(x) / cos(x)

proc sinh*(x:Decimal):Decimal =
  return (exp(x) - exp(-x)) / Decimal(2)

proc cosh*(x:Decimal):Decimal =
  return (exp(x) + exp(-x)) / Decimal(2)

proc hypot*(x, y:Decimal):Decimal = sqrt(x * x + y * y)

#proc pow*(a, b:Decimal):Decimal = a ^ b

proc arcsin*(x:Decimal):Decimal =
  result = Decimal(0)
  var
    n = 0
    p = x
    t = 1 / Decimal(2)
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

proc arccos*(x:Decimal):Decimal =
  (Decimal$.pi) / Decimal(2) - arcsin(x)

proc arctan2*(y, x:Decimal):Decimal =
  var
    a = x / sqrt(x * x + y * y)
    b = Decimal(1)
  while true:
    var
      na = (a + b) / 2
      nb = sqrt(na * b)
    if na == a:break
    a = na.move
    b = nb.move
  return y / (a * sqrt(x * x + y * y))
proc arctan*(x:Decimal):Decimal =
  return arctan2(x, Decimal(1))

#proc round*(x:Decimal):Decimal = round_to_int(x)
