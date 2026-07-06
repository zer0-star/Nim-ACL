# factorial

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/factorial

## 公開 API

    const ATCODER_FACTORIAL_HPP* = 1
    proc factorial*[ModInt](n:int):ModInt =
    var d = ModInt.rfact(i) * ModInt.rfact((n - 1) - i)
    var p2 = initFormalPowerSeries[ModInt](2 * n)

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
