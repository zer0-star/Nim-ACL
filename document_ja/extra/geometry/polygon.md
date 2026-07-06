# polygon

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/geometry/polygon

## 公開 API

    const ATCODER_POLYGON_HPP* = 1
    type Polygon*[Real] = seq[Point[Real]]
    proc isConvex*[Real](p:Polygon[Real]):bool =
    proc convexHull*[Real](p:Polygon[Real], strict = false): Polygon[Real] =
    proc convex_cut*[Real](U: Polygon[Real], l:Line[Real]):Polygon[Real] =
    proc convex_diameter*[Real](p: Polygon[Real]):Real =
    type State* = enum
    proc contains*[Real](Q: Polygon[Real], p:Point[Real]):State =
    proc area*[Real](p: Polygon[Real]):Real =
    proc area*[Real](p:Polygon[Real], c:Circle[Real]):Real =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
