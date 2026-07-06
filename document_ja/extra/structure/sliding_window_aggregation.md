# sliding_window_aggregation

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/sliding_window_aggregation

## 公開 API

    const ATCODER_SLIDING_WINDOW_HPP* = 1
    proc initSlidingWindowAggregation*[T](f:proc(a, b:T):T, e:proc():T):SlidingWindowAggregation[T] =
    proc empty*[T](self:SlidingWindowAggregation[T]):bool =
    proc len*[T](self:SlidingWindowAggregation[T]):int =
    proc fold_all*[T](self:SlidingWindowAggregation[T]):T =
    proc push*[T](self:var SlidingWindowAggregation[T], x:T) =
    proc pop*[T](self:var SlidingWindowAggregation[T]) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
