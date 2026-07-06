# decimal_mp

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/decimal_mp

## 公開 API

    converter toDecimal*(a:int):DecimalType = newDecimal(a)
    converter toDecimal*(s:string):DecimalType = newDecimal(s)
    proc calcPi*[Real]():Real =
    let p = (a + b)^2/(Real(4) * c)
    proc initPrec*(Real:typedesc[DecimalType], n:int) =
    proc sin_impl*(x:DecimalType):DecimalType =
    let mx2 = - x * x
    proc sin*(x:DecimalType):DecimalType =
    let r = rem(x, ((DecimalType$.pi) * 2))
    proc cos*(x:DecimalType):DecimalType =
    proc tan*(x:DecimalType):DecimalTYpe = sin(x) / cos(x)
    proc sinh*(x:DecimalType):DecimalType =
    proc cosh*(x:DecimalType):DecimalType =
    proc hypot*(x, y:DecimalType):DecimalType = sqrt(x * x + y * y)
    proc pow*(a, b:DecimalType):DecimalType = a ^ b
    proc arcsin*(x:DecimalType):DecimalType =
    var next = result + p / (2 * n + 1)
    proc arccos*(x:DecimalType):DecimalType =
    proc arctan2*(y, x:DecimalType):DecimalType =
    proc arctan*(x:DecimalType):DecimalType =
    proc round*(x:DecimalType):DecimalType = round_to_int(x)

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
