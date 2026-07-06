# inf

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/inf

## 公開 API

    const ATCODER_EXTRA_OTHER_INF_HPP* = 1
    template inf*(T: typedesc): untyped =
    template infRepr*[T](x: T): string =
    proc isInf*[T](x: T): bool = x >= T.inf
    proc `∞`*(T: typedesc): T = T.inf
    proc `*!`*[T: SomeInteger](a, b: T): T =
    proc `+!`*[T: SomeInteger](a, b: T): T =
    proc `-!`*[T: SomeInteger](a, b: T): T =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
