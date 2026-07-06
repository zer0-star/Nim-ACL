# static_graph

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/static_graph

## 公開 API

    const ATCODER_STATIC_GRAPH_HPP* = 1
    type Edge0*[T] = object
    type Edges0*[T] = object
    type StaticGraph*[T] = object
    proc len*[T](self:StaticGraph[T]):int = self.n
    proc initStaticGraph*[T](n: int):StaticGraph[T] = StaticGraph[T](n:n)
    proc addBiEdge*[T](self: var StaticGraph[T], src, dst:int, w:T = 1):int {.discardable.} =
    proc build*[T](self:var StaticGraph[T]) =
    iterator `[]`*[T](self: StaticGraph[T], u:int):Edge0[T] =
    proc degree*[T](self: StaticGraph[T], u:int):int = self.start[u + 1] - self.start[u]
    proc initStaticBiGraph*[T](n: int, u, v: seq[int]):StaticGraph[T] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
