# FunctionalGraph / Doubling

`FunctionalGraph` は、各頂点から出る辺がちょうど 1 本の有向グラフです。

つまり、写像 `f: {0, ..., n-1} -> {0, ..., n-1}` と同じものです。  
競技プログラミングでは、頂点 `v` から `k` 回移動した到達点 `f^k(v)` を求める問題でよく出てきます。

`Doubling` は、このような「同じ操作を非常に多く繰り返す」処理を `O(log k)` で行うための technique です。

## 使いどころ

次のような問題でよく使います。

- `k` が `10^18` など非常に大きい写像反復
- テレポーターを `k` 回使った後の位置
- Functional graph の cycle 検出
- 木の ancestor query の基礎
- LCA / binary lifting の土台

ABC167 D “Teleporter” や ABC367 E “Permute K times” のような問題が代表例です。

## 考え方

`Doubling` では、次の表を前計算します。

- `table[0][v] = f(v)`
- `table[1][v] = f^2(v)`
- `table[2][v] = f^4(v)`
- `table[b][v] = f^(2^b)(v)`

すると、`k` を二進展開して、立っている bit に対応する `table[b]` だけを順に使えば、`f^k(v)` が求まります。

たとえば `k = 13 = 8 + 4 + 1` なら、`f^13(v)` は `f^8`, `f^4`, `f^1` を順に適用すればよいです。

## import

~~~nim
import atcoder/extra/graph/functional_graph
~~~

## 型

~~~nim
type Doubling
type FunctionalGraph
~~~

`Doubling` は一般の写像反復用です。  
`FunctionalGraph` は `to: seq[int]` と `Doubling` をまとめた wrapper です。

## コンストラクタ

~~~nim
proc initDoubling(to: openArray[int], maxLog: int = 60): Doubling
proc initFunctionalGraph(to: openArray[int], maxLog: int = 60): FunctionalGraph
~~~

- `to[v]` は頂点 `v` から 1 回移動した先です。
- `maxLog` は前計算する最大 bit です。
- `k < 2^(maxLog + 1)` の query に対応します。

## 操作

~~~nim
proc len(db: Doubling): int
proc jump[K: SomeInteger](db: Doubling, v: int, k: K): int
proc `[]`[K: SomeInteger](db: Doubling, q: tuple[v: int, k: K]): int

proc len(fg: FunctionalGraph): int
proc jump[K: SomeInteger](fg: FunctionalGraph, v: int, k: K): int
proc `[]`[K: SomeInteger](fg: FunctionalGraph, q: tuple[v: int, k: K]): int

proc cycleInfo(fg: FunctionalGraph, start: int): tuple[tail, period: int]
proc orbit(fg: FunctionalGraph, start: int): tuple[prefix, cycle: seq[int]]
~~~

- `jump(v, k)` は `v` から `k` 回移動した頂点を返します。
- `db[(v, k)]` / `fg[(v, k)]` でも同じ query ができます。
- `cycleInfo(start)` は、`start` から進んだ列の cycle までの長さ `tail` と cycle 長 `period` を返します。
- `orbit(start)` は、訪問列を `prefix` と `cycle` に分けて返します。

## 使用例

<!-- nim-line-numbers -->
~~~nim
let to = @[1, 2, 0, 4, 4]
let fg = initFunctionalGraph(to, maxLog = 60)

doAssert fg.jump(0, 0) == 0
doAssert fg.jump(0, 1) == 1
doAssert fg.jump(0, 2) == 2
doAssert fg.jump(0, 3) == 0

doAssert fg.jump(3, 1000000000000000000'u64) == 4
~~~

`[]` sugar も使えます。

~~~nim
doAssert fg[(0, 5)] == 2
doAssert fg[(3, 100)] == 4
~~~

## cycle の取得

~~~nim
let fg = initFunctionalGraph(@[1, 2, 3, 1, 5, 5])

let info = fg.cycleInfo(0)

doAssert info.tail == 1
doAssert info.period == 3

let orb = fg.orbit(0)

doAssert orb.prefix == @[0]
doAssert orb.cycle == @[1, 2, 3]
~~~

## Nim らしい使い方

Nim では tuple を使って、`fg[(v, k)]` のように書けます。

~~~nim
let ans = fg[(start, k)]
~~~

ただし、読みやすさを優先する場合は `fg.jump(start, k)` も推奨です。

## 計算量

頂点数を `n`、`B = maxLog + 1` とすると、

- 構築: `O(nB)`
- `jump`: `O(B)`
- `cycleInfo`: `O(n)`
- `orbit`: `O(n)`
- memory: `O(nB)`

です。

## 注意

- `to[v]` は `0 <= to[v] < n` を満たす必要があります。
- `jump(v, k)` は `k < 2^(maxLog + 1)` を満たす必要があります。
- `k` が大きい場合は `uint64` を使うと安全です。

## 関連資料・他言語ライブラリ

- AtCoder ABC167 D: Teleporter
- AtCoder ABC367 E: Permute K times
- cp-algorithms: Lowest Common Ancestor - Binary Lifting
- KACTL: Binary Lifting / LCA 関連
