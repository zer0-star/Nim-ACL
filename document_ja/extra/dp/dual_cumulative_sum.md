# dual_cumulative_sum

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/dp/dual_cumulative_sum

## 公開 API

    const ATCODER_DUAL_CUMULATIVE_SUM_HPP* = 1
    type DualCumulativeSum*[T] = object
    proc init*[T](self: var DualCumulativeSum[T], sz:int = 100) =
    proc initDualCumulativeSum*[T](sz:int = 100):DualCumulativeSum[T] =
    proc init*[T](self: var DualCumulativeSum[T], a:seq[T]) =
    proc initDualCumulativeSum*[T](a:seq[T]):DualCumulativeSum[T] =
    proc add*[T](self: var DualCumulativeSum[T], s:Slice[int], x:T) =
    proc add*[T](self: var DualCumulativeSum[T], i:int, x:T) = self.add(i .. i, x)
    proc `[]`*[T](self: var DualCumulativeSum[T], k:int):T =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
