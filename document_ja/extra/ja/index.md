# 日本語API（試験的）

Nim-ACL の既存実装を、日本語の import 名と API 名から利用するための薄い facade です。

アルゴリズム本体は複製せず、ASCII の正式 API をそのまま呼び出します。そのため、計算量・戻り値・境界条件は正式 API と同一です。

## 方針

- 正式かつ安定した API は従来の ASCII 名です。
- 日本語APIは `atcoder/extra/ja` 以下の試験的な入口です。
- 日本語facadeと正式APIの結果一致をCIで検証します。
- ファイル名のUnicode正規化衝突を自動監査します。

## 最小全域木

~~~nim
import atcoder/extra/graph/graph_template
import "atcoder/extra/ja/graph/最小全域木"

var g = initGraph(4)

g.addBiEdge(0, 1, 1)
g.addBiEdge(1, 2, 2)
g.addBiEdge(0, 2, 5)
g.addBiEdge(2, 3, 1)

let (重み合計, 辺集合) = 最小全域木(g)

doAssert 重み合計 == 4
doAssert 辺集合.len == 3
~~~

正式APIは `kruskal(g)` です。

## 最小全域有向木

~~~nim
import std/options
import atcoder/extra/graph/graph_template
import "atcoder/extra/ja/graph/最小全域有向木"

let es: Edges[int, int] = @[
  initEdge[int, int](0, 1, 1),
  initEdge[int, int](0, 2, 5),
  initEdge[int, int](1, 2, 1),
  initEdge[int, int](2, 3, 1),
]

let ans = 最小全域有向木(es, 4, 0)

doAssert ans.isSome
doAssert ans.get[0] == 3
~~~

英語の機能名は `minimumArborescence`、従来名は `minimumSpanningTreeArborescence` です。

## 素集合データ構造

~~~nim
import "atcoder/extra/ja/structure/素集合データ構造"

var uf = 素集合データ構造を初期化(5)

discard uf.併合(0, 1)
discard uf.併合(1, 2)

doAssert uf.同じ集合か(0, 2)
doAssert uf.集合の大きさ(0) == 3
doAssert uf.代表元(0) == uf.代表元(2)
~~~

正式APIは `initDSU`, `merge`, `same`, `leader`, `size`, `groups` です。

## 現在の対応表

| 日本語import | 日本語API | 正式API |
|---|---|---|
| `atcoder/extra/ja/graph/最小全域木` | `最小全域木(g)` | `kruskal(g)` |
| `atcoder/extra/ja/graph/最小全域有向木` | `最小全域有向木(es, V, root)` | `minimumArborescence(es, V, root)` |
| `atcoder/extra/ja/structure/素集合データ構造` | `併合`, `同じ集合か`, `代表元` など | `merge`, `same`, `leader` など |
