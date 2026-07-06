# fold

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/fold

## 公開 API

    const ATCODER_FOLD_HPP* = 1
    proc fold_associative*[T](v:seq[T], f:proc(a, b:T):T):T =
    proc fold_staircase_sum*[T](v:seq[T], sum:proc(a, b:T):T, prod:proc(a, b:T):T):T =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
