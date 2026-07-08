# cycle_detection

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/cycle_detection

## 公開 API

    const ATCODER_CYCLE_DETECTION_HPP* = 1
    proc cycleDetection*[G:Graph](g:G):Option[seq[Edge[G.T, G.U]]] =
    proc cycleDetectionUndirected*[G:Graph](g:G):Option[seq[Edge[G.T, G.U]]] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。

## 基本例

`cycleDetection(g)` は有向 graph の閉路を探します。閉路が見つかると `Option[seq[Edge]]` の `some` を返します。

```nim
import std/options
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/cycle_detection

var g = initGraph(3)
g.addEdge(0, 1)
g.addEdge(1, 2)
g.addEdge(2, 0)

let c = cycleDetection(g)

doAssert c.isSome
```

無向 graph では `cycleDetectionUndirected(g)` を使えます。
