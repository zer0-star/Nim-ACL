# decimal

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/decimal

## 公開 API

    proc calcPi*[Real]():Real =
    let p = s * s / (Real(4) * c)
    proc exp*(x:Decimal):Decimal =
    proc initPrec*(Real:typedesc[Decimal], n:int) =
    proc sin_impl*(x:Decimal):Decimal =
    let mx2 = - x * x
    proc sin*(x:Decimal):Decimal =
    let r = rem(x, ((Decimal$.pi) * 2))
    proc cos*(x:Decimal):Decimal =
    proc tan*(x:Decimal):Decimal = sin(x) / cos(x)
    proc sinh*(x:Decimal):Decimal =
    proc cosh*(x:Decimal):Decimal =
    proc hypot*(x, y:Decimal):Decimal = sqrt(x * x + y * y)
    proc arcsin*(x:Decimal):Decimal =
    var next = result + p / (2 * n + 1)
    proc arccos*(x:Decimal):Decimal =
    proc arctan2*(y, x:Decimal):Decimal =
    proc arctan*(x:Decimal):Decimal =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
