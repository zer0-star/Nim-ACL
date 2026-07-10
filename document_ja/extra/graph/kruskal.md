# kruskal

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/kruskal

## 公開 API

    const ATCODER_KRUSKAL_HPP* = 1
    proc kruskal*[G:Graph](g:G):(G.T, seq[Edge[G.T, G.U]]) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。

## 基本例

`kruskal(g)` は最小全域木の重み合計と、選ばれた辺の列を返します。

```nim
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/kruskal

var g = initGraph(4)
g.addBiEdge(0, 1, 1)
g.addBiEdge(1, 2, 2)
g.addBiEdge(0, 2, 5)
g.addBiEdge(2, 3, 1)

let (cost, es) = kruskal(g)

doAssert cost == 4
doAssert es.len == 3
```

<!-- NIM_ACL_JAPANESE_FACADE_V1 -->
## 日本語API（試験的）

~~~nim
import "atcoder/extra/ja/graph/最小全域木"

let (重み合計, 辺集合) = 最小全域木(g)
~~~

[日本語APIの一覧](../ja/index.md)も参照してください。
<!-- /NIM_ACL_JAPANESE_FACADE_V1 -->
