# cumulative_sum_2d

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/dp/cumulative_sum_2d

## 公開 API

    const ATCODER_CUMULATIVE_SUM_2D_HPP* = 1
    type CumulativeSum2D*[T] = object
    proc initCumulativeSum2D*[T](W, H:int):CumulativeSum2D[T] = CumulativeSum2D[T](data: newSeqWith(W + 1, newSeqWith(H + 1, T(0))), built:false)
    proc initCumulativeSum2D*[T](data:seq[seq[T]]):CumulativeSum2D[T] =
    proc add*[T](self:var CumulativeSum2D[T]; x, y:int, z:T) =
    proc build*[T](self:var CumulativeSum2D[T]) =
    proc `[]`*[T](self: CumulativeSum2D[T], rx, ry:Slice[int]):T =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
