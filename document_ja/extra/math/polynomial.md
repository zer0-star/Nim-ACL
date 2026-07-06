# polynomial

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/polynomial

## 公開 API

    const ATCODER_POLYNOMIAL_HPP* = 1
    type poly*[T] = seq[T]
    proc `+=`*[T](a:var poly[T], b:poly[T]) =
    proc `+`*[T](a, b:poly[T]):poly[T] =
    proc `-=`*[T](a:var poly[T], b:poly[T]) =
    proc `-`*[T](a, b:poly[T]):poly[T] =
    proc `*`*[T](a, b:poly[T]):poly[T] =
    proc `*`*[T](a:poly[T], d:T):poly[T] =
    proc eval*[T](p:poly[T], x:T):T =
    proc integral*[T](p:poly[T]):poly[T] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
