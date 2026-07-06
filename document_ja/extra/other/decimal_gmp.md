# decimal_gmp

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/decimal_gmp

## 公開 API

    const ATCODER_DECIMAL_GMP_HPP* = 1
    type Decimal* = ref mpf_t
    proc setPrec*(n:int) =
    proc finalizeDecimal*(z: Decimal) =
    proc init*(z:var Decimal, prec = -1) =
    proc clone*(x: Decimal):Decimal =
    proc newDecimal*(a:float, prec = -1):Decimal =
    proc `=copy`*(a: var Decimal, b: Decimal) =
    proc `-`*(a: Decimal):Decimal =
    proc `+=`*(a: var Decimal, b:Decimal):Decimal {.discardable.} =
    proc `-=`*(a: var Decimal, b:Decimal):Decimal {.discardable.} =
    proc `*=`*(a: var Decimal, b:Decimal):Decimal {.discardable.} =
    proc `/=`*(a: var Decimal, b:Decimal):Decimal {.discardable.} =
    proc `+`*(a, b:Decimal):Decimal =
    proc `-`*(a, b:Decimal):Decimal =
    proc `*`*(a, b:Decimal):Decimal =
    proc `/`*(a, b:Decimal):Decimal =
    proc `<`*(a, b:Decimal):bool =
    proc `>`*(a, b:Decimal):bool =
    proc `<=`*(a, b:Decimal):bool =
    proc `>=`*(a, b:Decimal):bool =
    proc `==`*(a, b:Decimal):bool =
    proc `$`*(a:Decimal):string =
    converter toDecimal*(x:int):Decimal =
    converter toDecimal*(x:float):Decimal =
    proc sqrt*(a:Decimal):Decimal =
    proc rem*(a, b:Decimal):Decimal =
    proc `^`*(a:Decimal, k:int):Decimal =
    proc floor*(a:Decimal):Decimal =
    proc machine_epsilon*(): Decimal =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
