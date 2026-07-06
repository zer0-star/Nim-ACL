# zeta_transform

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/zeta_transform

## 公開 API

    const ATCODER_ZETA_TRANSFORM_HPP* = 1
    proc zeta_transform*[T](f:openArray[T], subset:static[bool] = false, add:proc(a:var T, b:T):void = proc(a:var T, b:T):void = a += b):seq[T] =
    proc movius_transform*[T](f:openArray[T], subset:static[bool] = false, subt:proc(a:var T, b:T):void = proc(a:var T, b:T):void = a -= b):seq[T] =
    proc zeta_superset*[T](f:openArray[T], add:proc(a:var T, b:T):void = proc(a:var T, b:T):void = a += b):seq[T] =
    proc movius_superset*[T](f:openArray[T], subt:proc(a:var T, b:T):void = proc(a:var T, b:T):void = a -= b):seq[T] =
    proc zeta_subset*[T](f:openArray[T], add:proc(a:var T, b:T):void = proc(a:var T, b:T):void = a += b):seq[T] =
    proc movius_subset*[T](f:openArray[T], subt:proc(a:var T, b:T):void = proc(a:var T, b:T):void = a -= b):seq[T] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
