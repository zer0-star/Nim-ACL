when not declared ATCODER_QUADRATIC_FIELD_HPP:
  const ATCODER_QUADRATIC_FIELD_HPP* = 1
  import atcoder/modint
  # Quadratic Field
  type QF*[T; d: static[int]] = object # a + b * sqrt(5)
    a*, b*: T

  proc `$`*(x: QF): string =
    if x.a.val() != 0:
      result &= $(x.a)
    if x.b.val() != 0:
      result &= " + " & $(x.b) & "√" & $(x.d)
    if result == "": result = "0"

  #type mint = modint998244353 # これなしでコンパイルしたい
  
  proc init*[Q: QF](self: typedesc[Q]; a: SomeInteger, b = 0):Q =
    type T = Q.T
    Q(a: T.init(a), b: T.init(b))
  proc init*[Q: QF](self: typedesc[Q]; a: Q.T, b = Q.T.init(0)):Q =
    Q(a: a, b: b)

  template `{}`*[M: static[int]](t: typedesc[StaticModInt[M]], d: static[int]): typedesc = QF[StaticModInt[M], d]
  
  # TODO: converterは沼
  #converter toP*[M, d: static[int]](a:int):QF[StaticModInt[M], d] =
  #  type mint = StaticModInt[M]
  #  QF[mint, d](a:mint.init(a), b:mint.init(0))
  #converter toP*[M: static[int]](a:StaticModInt[M]):QF[StaticModInt[M], 5] = 
  #  QF[mint, 5](a: a, b: mint.init(0))
  
  proc `+=`*(x: var QF, y: QF) = x.a += y.a;x.b += y.b
  proc `-=`*(x: var QF, y: QF) = x.a -= y.a;x.b -= y.b
  proc `+`*(x, y:QF):QF = result = x; result += y
  proc `-`*(x, y:QF):QF = result = x; result -= y
  proc `*`*(x, y:QF):QF = QF.init(x.a * y.a + x.b * y.b * QF.d, x.a * y.b + x.b * y.a)
  proc `*=`*(x: var QF, y: QF) = x = x * y
  proc inv*(x: QF):QF =
    # a + b * sqrt(d)
    result = QF.init(x.a, -x.b)
    let t = x.a * x.a - x.b * x.b * QF.d
    result.a /= t;result.b /= t
    #doAssert result * x == QF.init(1)
  proc `/=`*(x: var QF, y: QF) =
    x *= y.inv()
  proc `/`*(x, y:QF):QF = result = x; result /= y

  proc `-`*(x:QF):QF = QF.init(-x.a, -x.b) # dummy
  proc pow*[T: QF](x: T, n:int):T =
    if n == 0: return T.init(1)
    result = pow(x, n div 2)
    result *= result
    if n mod 2 == 1:
      result *= x
  proc `^`*[T: QF](x: T, n:int):T = pow(x, n)
  proc get_pow2_root*[Q: QF](): tuple[g: Q, m, r: int] =
    type mint = Q.T
    const (g, m, r) = get_pow2_root[mint]()
    return (Q.init(g), m, r)
  #proc `mod`*(self: typedesc[QF]): int = self.T.mod
  proc `+`*(x:SomeInteger, y:QF):QF = QF.init(x) + y
  proc `+`*(x:QF, y:SomeInteger):QF = x + QF.init(y)
  proc `-`*(x:SomeInteger, y:QF):QF = QF.init(x) - y
  proc `-`*(x:QF, y:SomeInteger):QF = x - QF.init(y)
  proc `*`*(x:SomeInteger, y:QF):QF = QF.init(x) * y
  proc `*`*(x:QF, y:SomeInteger):QF = x * QF.init(y)
  proc `/`*(x:SomeInteger, y:QF):QF = QF.init(x) / y
  proc `/`*(x:QF, y:SomeInteger):QF = x / QF.init(y)
  proc `+=`*(x: var QF, y: SomeInteger) = x += QF.init(y)
  proc `-=`*(x: var QF, y: SomeInteger) = x -= QF.init(y)
  proc `*=`*(x: var QF, y: SomeInteger) = x *= QF.init(y)
  proc `/=`*(x: var QF, y: SomeInteger) = x /= QF.init(y)

  proc `+`*[T;d:static[int]](x:T, y:QF[T, d]):QF = QF.init(x) + y
  proc `+`*[T;d:static[int]](x:QF[T, d], y:T):QF = x + QF.init(y)
  proc `-`*[T;d:static[int]](x:T, y:QF[T, d]):QF = QF.init(x) - y
  proc `-`*[T;d:static[int]](x:QF[T, d], y:T):QF = x - QF.init(y)
  proc `*`*[T;d:static[int]](x:T, y:QF[T, d]):QF = QF.init(x) * y
  proc `*`*[T;d:static[int]](x:QF[T, d], y:T):QF = x * QF.init(y)
  proc `/`*[T;d:static[int]](x:T, y:QF[T, d]):QF = QF.init(x) / y
  proc `/`*[T;d:static[int]](x:QF[T, d], y:T):QF = x / QF.init(y)
  proc `+=`*[T;d:static[int]](x: var QF[T, d], y: T) = x += QF.init(y)
  proc `-=`*[T;d:static[int]](x: var QF[T, d], y: T) = x -= QF.init(y)
  proc `*=`*[T;d:static[int]](x: var QF[T, d], y: T) = x *= QF.init(y)
  proc `/=`*[T;d:static[int]](x: var QF[T, d], y: T) = x /= QF.init(y)

