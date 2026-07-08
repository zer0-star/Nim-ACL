# topological_sort

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/topological_sort

## 公開 API

    const ATCODER_TOPOLOGICAL_SORT_HPP* = 1
    proc topologicalSort*(g:Graph):seq[int] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。

## 基本例

`topologicalSort(g)` は DAG のトポロジカル順序を返します。

```nim
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/topological_sort

var g = initGraph(4)
g.addEdge(0, 1)
g.addEdge(0, 2)
g.addEdge(1, 3)
g.addEdge(2, 3)

let order = topologicalSort(g)

doAssert order.len == 4
```
