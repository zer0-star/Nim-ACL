# triangle

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/geometry/triangle

## 公開 API

    const ATCODER_TRIANGLE_HPP* = 1
    proc centroid*[Real](a,b,c:Point[Real]):Point[Real] =
    proc incircle*[Real](a,b,c:Point[Real]):Circle[Real] =
    proc incenter*[Real](a, b, c:Point[Real]):Point[Real] =
    proc excircle*[Real](a,b,c:Point[Real]):array[3, Circle[Real]] =
    proc excenter*[Real](a, b, c:Point[Real]):array[3, Point[Real]] =
    proc circumcircle*[Real](a,b,c:Point[Real]):Circle[Real] =
    proc circumcenter*[Real](a,b,c:Point[Real]):Point[Real] =
    proc orthocenter*[Real](a,b,c:Point[Real]):Point[Real] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
