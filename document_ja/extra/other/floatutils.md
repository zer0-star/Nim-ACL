# floatutils

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/floatutils

## 公開 API

    const ATCODER_EXTRA_OTHER_FLOATUTILS_HPP* = 1
    proc getParameters*(Real: typedesc): ptr[tuple[n: int, pi, eps, inf: Real]] =
    converter floatConverter*(a: SomeInteger): float = a.float
    converter float64Converter*(a: SomeInteger): float64 = a.float64
    converter float32Converter*(a: SomeInteger): float32 = a.float32
    converter floatConverter*(a: string): float = a.parseFloat
    converter float64Converter*(a: string): float64 = a.parseFloat.float64
    converter float32Converter*(a: string): float32 = a.parseFloat.float32
    proc getPi*(Real: typedesc): Real = Real$.pi
    proc getEPS*(Real: typedesc): Real = Real$.eps
    proc getINF*(Real: typedesc): Real = Real$.inf
    proc setEPS*(Real: typedesc, x: Real) = Real$.eps = x
    proc valid_range*[Real](l, r: Real): bool =
    proc machineEpsilon*(Real: typedesc): Real =
    template initPrec*(Real: typedesc[typed]) =
    proc `=~`*(a, b: Real): bool = abs(a - b) < Real$.eps
    proc `!=~`*(a, b: Real): bool = abs(a - b) > Real$.eps
    proc `<~`*(a, b: Real): bool = a + Real$.eps < b
    proc `>~`*(a, b: Real): bool = a > b + Real$.eps
    proc `<=~`*(a, b: Real): bool = a < b + Real$.eps
    proc `>=~`*(a, b: Real): bool = a + Real$.eps > b
    proc estimateRational*[Real](x: Real, n: int) =
    let p = round(x * q.Real)

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
