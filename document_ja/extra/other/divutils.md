# divutils

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/divutils

## 公開 API

    const ATCODER_DIVUTILS_HPP* = 1
    proc ceilDiv*[T:SomeInteger](a, b:T):T =
    proc ceilMod*[T:SomeInteger](a, b:T):T =
    template `/.`*[T:SomeInteger](a, b:T):T = floorDiv(a, b)
    template `/^`*[T:SomeInteger](a, b:T):T = ceilDiv(a, b)
    template `%.`*[T:SomeInteger](a, b:T):T = floorMod(a, b)
    template `%^`*[T:SomeInteger](a, b:T):T = ceilMod(a, b)

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
