# lowlink

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/lowlink

## 公開 API

    const ATCODER_LOWLINK_HPP* = 1
    proc LowLink*(g:Graph):tuple[articulation:seq[int], bridge:seq[(int,int)]] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。

## 基本例

`LowLink(g)` は、無向 graph の関節点 `articulation` と橋 `bridge` を返します。

```nim
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/lowlink

var g = initGraph(4)
g.addBiEdge(0, 1)
g.addBiEdge(1, 2)
g.addBiEdge(1, 3)

let ll = LowLink(g)

doAssert ll.articulation == @[1]
doAssert (1, 2) in ll.bridge
```
