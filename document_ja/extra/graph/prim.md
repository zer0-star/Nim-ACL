# prim

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/prim

## 公開 API

    const ATCODER_PRIM_HPP* = 1
    proc prim*[G:Graph](g:G, s:int = 0):(G.T, seq[Edge[G.T, G.U]]) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。

## 基本例

`prim(g, s)` は始点 `s` から Prim 法で最小全域木を求め、重み合計と選ばれた辺の列を返します。

```nim
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/prim

var g = initGraph(4)
g.addBiEdge(0, 1, 1)
g.addBiEdge(1, 2, 2)
g.addBiEdge(0, 2, 5)
g.addBiEdge(2, 3, 1)

let (cost, es) = prim(g, 0)

doAssert cost == 4
doAssert es.len == 3
```
