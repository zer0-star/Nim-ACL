# coef_of_generating_function

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/coef_of_generating_function

## 公開 API

    const ATCODER_COEF_OF_GENERATING_FUNCTION_HPP* = 1
    type RationalFormalPowerSeries*[T] = object
    proc `//`*[T:FieldElem](P, Q:FormalPowerSeries[T]):RationalFormalPowerSeries[T] =
    proc `+`*[T](f, g:RationalFormalPowerSeries[T]):RationalFormalPowerSeries[T] =
    proc `*`*[T](f, g:RationalFormalPowerSeries[T]):RationalFormalPowerSeries[T] =
    proc `[]`*[T:FieldElem](r:RationalFormalPowerSeries[T],N:int):T =
    var PQ1 = P * Q1
    var QQ1 = Q * Q1

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
