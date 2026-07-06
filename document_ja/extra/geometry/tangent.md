# tangent

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/geometry/tangent

## 公開 API

    const ATCODER_TANGENT_HPP* = 1
    proc tangent*[Real](c1: Circle[Real], p2:Point[Real]):(Point[Real], Point[Real]) =
    proc tangent*[Real](c1, c2: Circle[Real]):seq[Line[Real]] =
    let h = (c1.r + s.Real * c2.r) / sqrt(g)
    let d = 1.Real - h * h

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
