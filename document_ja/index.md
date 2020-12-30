# AC(AtCoder) Library Document

## インストール方法

- zipファイルを解凍すると、`ac-library`フォルダ, そしてその中に`atcoder`フォルダが入っているはずです。
- g++を使っている場合, `atcoder`フォルダを`main.cpp`と同じ場所に置いて、`g++ main.cpp -std=c++14 -I .`でコンパイルできます。  
  - `-std=c++14`か`-std=c++17`をつけてコンパイルする必要があります。
- 詳しくは [Appendix](./appendix.html) を参照してください。

## お約束

- 制約外の入力を入れたときの挙動はすべて未定義です。
- このドキュメントでは長い型を便宜上短く書きます
  - `unsigned int` → `uint`
  - `long long` → `ll`
  - `unsigned long long` → `ull`
- $0^0$ は $1$ です
- 明記されていない場合、多重辺や自己ループも入力可能です。

## リスト

`import atcoder/all` : 一括include

### データ構造

- [`import atcoder/fenwicktree`](./fenwicktree.html)
- [`import atcoder/segtree`](./segtree.html)
- [`import atcoder/lazysegtree`](./lazysegtree.html)
- [`import atcoder/string`](./string.html)

### 数学

- [`import atcoder/math`](./math.html)
- [`import atcoder/convolution`](./convolution.html)
- 💻[`import atcoder/modint`](./modint.html)

### グラフ

- [`import atcoder/dsu`](./dsu.html)
- [`import atcoder/maxflow`](./maxflow.html)
- [`import atcoder/mincostflow`](./mincostflow.html)
- [`import atcoder/scc`](./scc.html)
- [`import atcoder/twosat`](./twosat.html)

## エキストラライブラリ

ACLには収録されていないが、使用頻度が高そうなライブラリを追加しました。

### データ構造
- [`import atcoder/extra/structure/persistent_array`](./extra/persistent_array.html)
- [`import atcoder/extra/structure/persistent_dsu`](./extra/persistent_dsu.html)

### 数学


### グラフ

- [`import atcoder/extra/graph/graph_template`](./extra/graph_template.html)
- [`import atcoder/extra/graph/dijkstra`](./extra/dijkstra.html)


## 付録

- [Appendix / FAQ](./appendix.html)

## テスト

- [こちら](https://atcoder.jp/contests/practice2) で実際にこの Library を使う問題を解いてみることができます。

## ライセンス

ヘッダファイル群(同梱の `atcoder` フォルダ以下)はCC0ライセンスで公開しています。詳しくは`atcoder/LICENSE`を参照してください。
