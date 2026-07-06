# convex_hull_trick_add_monotone

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/convex_hull_trick_add_monotone

## 公開 API

    const ATCODER_CONVEX_HULL_TRICK_ADD_MONOTONE* = 1
    type ConvexHullTrickAddMonotone*[T] = object
    proc initConvexHullTrickAddMonotone*[T](isMin:bool):ConvexHullTrickAddMonotone[T] =
    proc add*[T](self: var ConvexHullTrickAddMonotone[T], a, b:T) =
    proc query*[T](self: ConvexHullTrickAddMonotone[T], x:T):T =
    proc query_monotone_inc*[T](self: var ConvexHullTrickAddMonotone[T], x:T):T =
    proc query_monotone_dec*[T](self: var ConvexHullTrickAddMonotone[T], x:T):T =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
