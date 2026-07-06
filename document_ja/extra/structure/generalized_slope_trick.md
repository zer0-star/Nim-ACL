# generalized_slope_trick

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/generalized_slope_trick

## 公開 API

    const ATCODER_GENERALIZED_SLOPE_TRICK* = 1
    proc split_lower_bound*[T:SomeSplayTree](self:T, t:T.Node, key:T.D):(T.Node, T.Node) =
    proc merge_wuh*[T:SomeSplayTree](self: T, t1, t2:T.Node):T.Node =
    proc insert_lower_bound*[T:SomeSplayTree](self: var T, t:T.Node, v:T.D):T.Node =
    type GeneralizedSlopeTrick*[T, ST] = object
    proc initGeneralizedSlopeTrick*[T]:auto =
    proc g(a:T, b:int):T = a * b
    proc like*[T, ST](self: GeneralizedSlopeTrick[T, ST]):auto =
    proc push_R*[T](self:var GeneralizedSlopeTrick, a: T) =
    proc top_R*[ST:GeneralizedSlopeTrick](self: var ST):ST.T =
    proc pop_R*[ST:GeneralizedSlopeTrick](self:var ST):ST.T =
    proc push_L*[T](self: var GeneralizedSlopeTrick, a:T) =
    proc top_L*[ST:GeneralizedSlopeTrick](self: var ST):ST.T =
    proc pop_L*[ST:GeneralizedSlopeTrick](self: var ST):ST.T =
    proc len*[T](self:GeneralizedSlopeTrick):int =
    type Query*[T] = object
    proc query*[ST:GeneralizedSlopeTrick](self:var ST):Query[ST.T] =
    proc add_all*[ST:GeneralizedSlopeTrick](self:var ST, a:ST.T) =
    proc add_a_minus_x*[ST:GeneralizedSlopeTrick](self: var ST, a:ST.T) =
    proc add_x_minus_a*[ST:GeneralizedSlopeTrick](self: var ST, a:ST.T) =
    proc add_abs*[ST:GeneralizedSlopeTrick](self: var ST, a:ST.T) =
    proc clear_right*[ST:GeneralizedSlopeTrick](self: var ST) =
    proc clear_left*[ST:GeneralizedSlopeTrick](self: var ST) =
    proc shift*[ST:GeneralizedSlopeTrick](self: var ST, a, b:ST.T) =
    proc shift*[ST:GeneralizedSlopeTrick](self: var ST, a:ST.T) =
    proc get*[ST:GeneralizedSlopeTrick](self: var ST, x:ST.T):ST.T =
    proc merge*[ST:GeneralizedSlopeTrick](self: var ST, g:var ST) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
