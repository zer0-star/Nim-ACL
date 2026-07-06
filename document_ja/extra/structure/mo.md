# mo

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/mo

## 公開 API

    const ATCODER_MO_HPP* = 1
    type Mo* = object
    proc initMo*(N, Q:int):Mo =
    let width = max(1, int(1.0 * float(N) / max(1.0, sqrt(float(Q) * 2.0 / 3.0))))
    proc insert*(self:var Mo, l, r:int) =
    proc initMo*(N:int, l, r:seq[int]):Mo =
    proc run*[AL, AR, DL, DR, REM](self:Mo, add_left:AL, add_right:AR, delete_left: DL,delete_right:DR, rem:REM) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
