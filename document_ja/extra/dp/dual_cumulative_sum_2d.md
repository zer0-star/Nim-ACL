# dual_cumulative_sum_2d

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/dp/dual_cumulative_sum_2d

## 公開 API

    type DualCumulativeSum2D*[T] = object
    proc init*[T](self:var DualCumulativeSum2D[T], X, Y:int) =
    proc initDualCumulativeSum2D*[T](X, Y:int):DualCumulativeSum2D[T] =
    proc add*[T](self:var DualCumulativeSum2D[T]; rx, ry: Slice[int], z:T) =
    proc build*[T](self:var DualCumulativeSum2D[T]) =
    proc `[]`*[T](self: DualCumulativeSum2D[T], x:int, y:int):T =
    proc write*[T](self: DualCumulativeSum2D[T]) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
