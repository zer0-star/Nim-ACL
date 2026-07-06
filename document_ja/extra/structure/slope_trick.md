# slope_trick

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/slope_trick

## 公開 API

    const ATCODER_SLOPE_TRICK_HPP* = 1
    type SlopeTrick*[T] = object
    proc initSlopeTrick*[T]():SlopeTrick[T] =
    proc push_R*[T](self: var SlopeTrick[T], a:T) =
    proc top_R*[T](self:SlopeTrick[T]):T =
    proc pop_R*[T](self:var SlopeTrick[T]):T =
    proc push_L*[T](self:var SlopeTrick[T], a:T) =
    proc top_L*[T](self: SlopeTrick[T]):T =
    proc pop_L*[T](self:var SlopeTrick[T]):T =
    proc len*[T](self:SlopeTrick[T]):int =
    type Query*[T] = object
    proc query*[T](self:SlopeTrick[T]):Query[T] =
    proc add_all*[T](self:var SlopeTrick[T], a:T) =
    proc add_a_minus_x*[T](self: var SlopeTrick[T], a:T) =
    proc add_x_minus_a*[T](self: var SlopeTrick[T], a:T) =
    proc add_abs*[T](self: var SlopeTrick[T], a:T) =
    proc clear_right*[T](self: var SlopeTrick[T]) =
    proc clear_left*[T](self: var SlopeTrick[T]) =
    proc shift*[T](self: var SlopeTrick[T], a, b:T) =
    proc shift*[T](self: var SlopeTrick[T], a:T) =
    proc get*[T](self: var SlopeTrick[T], x:T):T =
    proc merge*[T](self, st: var SlopeTrick[T]) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
