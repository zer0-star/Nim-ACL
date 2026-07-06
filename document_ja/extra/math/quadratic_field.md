# quadratic_field

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/quadratic_field

## 公開 API

    const ATCODER_QUADRATIC_FIELD_HPP* = 1
    type QF*[T; d: static[int]] = object # a + b * sqrt(5)
    proc `$`*(x: QF): string =
    proc init*[Q: QF](self: typedesc[Q]; a: SomeInteger, b = 0):Q =
    proc init*[Q: QF](self: typedesc[Q]; a: Q.T, b = Q.T.init(0)):Q =
    template `{}`*[M: static[int]](t: typedesc[StaticModInt[M]], d: static[int]): typedesc = QF[StaticModInt[M], d]
    proc `+=`*(x: var QF, y: QF) = x.a += y.a;x.b += y.b
    proc `-=`*(x: var QF, y: QF) = x.a -= y.a;x.b -= y.b
    proc `+`*(x, y:QF):QF = result = x; result += y
    proc `-`*(x, y:QF):QF = result = x; result -= y
    proc `*`*(x, y:QF):QF = QF.init(x.a * y.a + x.b * y.b * QF.d, x.a * y.b + x.b * y.a)
    proc `*=`*(x: var QF, y: QF) = x = x * y
    proc inv*(x: QF):QF =
    let t = x.a * x.a - x.b * x.b * QF.d
    proc `/=`*(x: var QF, y: QF) =
    proc `/`*(x, y:QF):QF = result = x; result /= y
    proc `-`*(x:QF):QF = QF.init(-x.a, -x.b) # dummy
    proc pow*[T: QF](x: T, n:int):T =
    proc `^`*[T: QF](x: T, n:int):T = pow(x, n)
    proc get_pow2_root*[Q: QF](): tuple[g: Q, m, r: int] =
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

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
