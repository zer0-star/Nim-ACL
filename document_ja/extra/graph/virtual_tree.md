# Auxiliary Tree（Virtual Tree／仮想木）

根付き木から必要な頂点と、それらのLCAだけを取り出して圧縮木を構築します。

この構造は **Auxiliary Tree**、**Virtual Tree**、**仮想木**、**補助木**などと呼ばれます。このドキュメントでは、AtCoder公式解説で使われているAuxiliary Treeを主名称とし、既存module名との対応のためVirtual Treeを併記します。

## import

~~~nim
import atcoder/extra/graph/virtual_tree
~~~

## 前処理

~~~nim
let vt = initVirtualTree(graph, root = 0)
~~~

`graph`は0-indexedの無向木です。前処理ではEuler Tour順、深さ、二分累積によるLCA情報を構築します。

## `buildVirtualTree`

~~~nim
let built = vt.buildVirtualTree(keys)
~~~

`keys`と、それらを接続するために必要なLCAを含む圧縮木を返します。

- `built.root`: 圧縮木の根の添字
- `built.vertices[i]`: 圧縮頂点`i`に対応する元の頂点
- `built.edges`: `(parent, child, dist)`の列
- `built.adj[i]`: 圧縮頂点`i`から子への辺
- `dist`: 元の木における距離

~~~nim
for edge in built.edges:
  echo built.vertices[edge.parent],
       " -> ",
       built.vertices[edge.child],
       " distance = ",
       edge.dist
~~~

## 補助API

~~~nim
echo vt.lca(u, v)
echo vt.dist(u, v)
echo vt.isAncestor(u, v)
~~~

## 計算量

元の木の頂点数を \(N\)、指定頂点数を \(K\) とします。

- 前処理: \(O(N\log N)\)
- Auxiliary Treeの構築: \(O(K\log K + K\log N)\)
- 構築後の頂点数: \(O(K)\)

## 関連資料

- [ABC340 G公式解説：Auxiliary Treeの定義と構築](https://atcoder.jp/contests/abc340/editorial/9249)
- [ABC359 G公式解説：Auxiliary Treeの適用例](https://atcoder.jp/contests/abc359/editorial/10259?lang=ja)
- [Euler Tour](euler_tour.md)

## このライブラリが使える問題

<details class="problem-examples">
<summary>問題例を表示する（解法のネタバレを含む可能性があります）</summary>
<ul>
  <li><a href="https://atcoder.jp/contests/abc340/tasks/abc340_g" target="_blank" rel="noopener">AtCoder Beginner Contest 340 G - Leaf Color</a></li>
  <li><a href="https://atcoder.jp/contests/abc359/tasks/abc359_g" target="_blank" rel="noopener">AtCoder Beginner Contest 359 G - Sum of Tree Distance</a></li>
</ul>
</details>
