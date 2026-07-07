# UniversalSegTree

Universal SegTree は、通常のセグメント木、遅延セグメント木、双対セグメント木、区間長依存の遅延セグメント木、SegTree Beats 風の構造を、共通の実装で扱うための汎用セグメント木です。

標準の `atcoder/segtree` や `atcoder/lazysegtree` と同じ考え方で使えますが、`op`, `e`, `mapping`, `composition`, `id` などを template に渡して型を生成する設計になっています。

通常は、次の wrapper を使います。

```text
initSegTree
initDualSegTree
initLazySegTree
initLazySegTree_with_p
initSegTreeBeats
```
## import

```text
import atcoder/extra/structure/universal_segtree
```
## 通常の SegTree

```nim
var st = initSegTree[S](v:int or seq[S], op, e)
```
通常のセグメント木を作ります。

`op` は二項演算、`e` は単位元です。

@{keyword.constraints}

- `op` は結合的
- `e()` は `op` の単位元

@{keyword.complexity}

- 構築 $O(n)$
- 点更新 $O(\log n)$
- 区間取得 $O(\log n)$

### 使用例

```nim
import atcoder/extra/structure/universal_segtree

proc op(a, b:int):int = a + b
proc e():int = 0

var st = initSegTree[int](@[1, 2, 3, 4, 5], op, e)

doAssert st[0..<5] == 15
doAssert st[1..3] == 9

st[2] = 10

doAssert st[0..<5] == 22
doAssert st[2] == 10
```
## LazySegTree

```nim
var st = initLazySegTree[S, F](
  v:int or seq[S],
  op,
  e,
  mapping,
  composition,
  id
)
```
遅延セグメント木を作ります。

`S` は区間値の型、`F` は作用素の型です。

`mapping(f, x)` は、作用 `f` を区間値 `x` に適用した値を返します。

`composition(f, g)` は、先に `g`、次に `f` を適用する合成を返します。

@{keyword.constraints}

- `op` は結合的
- `e()` は `op` の単位元
- `mapping(id(), x) = x`
- `mapping(f, op(x, y)) = op(mapping(f, x), mapping(f, y))`
- `composition(f, g)` は作用の合成

@{keyword.complexity}

- 構築 $O(n)$
- 区間更新 $O(\log n)$
- 区間取得 $O(\log n)$

### 使用例：区間加算・区間和

```nim
import atcoder/extra/structure/universal_segtree

type S = tuple[sum:int, len:int]

proc op(a, b:S):S =
  (sum: a.sum + b.sum, len: a.len + b.len)

proc e():S =
  (sum: 0, len: 0)

proc mapping(f:int, x:S):S =
  (sum: x.sum + f * x.len, len: x.len)

proc composition(f, g:int):int =
  f + g

proc id():int =
  0

var st = initLazySegTree[S, int](
  @[
    (sum: 1, len: 1),
    (sum: 2, len: 1),
    (sum: 3, len: 1),
    (sum: 4, len: 1),
    (sum: 5, len: 1),
  ],
  op,
  e,
  mapping,
  composition,
  id
)

doAssert st[0..<5].sum == 15

st.apply(1..3, 10)

doAssert st[0..<5].sum == 45
doAssert st[2].sum == 13
```
## DualSegTree

```nim
var st = initDualSegTree[F](v:int or seq[F], composition, id)
```
双対セグメント木を作ります。

双対セグメント木は「区間作用・点取得」に使います。区間に作用を追加して、各点で合成済みの作用を取得します。

@{keyword.constraints}

- `composition` は結合的
- `id()` は恒等作用

@{keyword.complexity}

- 区間更新 $O(\log n)$
- 点取得 $O(\log n)$

### 使用例：区間加算・点取得

```nim
import atcoder/extra/structure/universal_segtree

proc composition(f, g:int):int =
  f + g

proc id():int =
  0

var st = initDualSegTree[int](5, composition, id)

st.apply(1..<4, 10)
st.apply(2..4, -3)

doAssert st[0] == 0
doAssert st[1] == 10
doAssert st[2] == 7
doAssert st[3] == 7
doAssert st[4] == -3
```
## LazySegTree_with_p

```nim
var st = initLazySegTree_with_p[S, F](
  v:int or seq[S],
  op,
  e,
  mapping,
  composition,
  id,
  p
)
```
区間の長さや相対位置に依存して作用を変えたい場合に使う遅延セグメント木です。

`p(f, s)` は、もとの作用 `f` を、ノードが表す区間 `s` に合わせて変換します。

たとえば、等差数列加算や、区間の位置に応じて変化する作用を扱う場合に使います。

@{keyword.complexity}

- 区間更新 $O(\log n)$
- 区間取得 $O(\log n)$

## SegTreeBeats

```nim
var st = initSegTreeBeats[S, F](
  v:int or seq[S],
  op,
  e,
  mapping,
  composition,
  id
)
```
SegTree Beats 風の処理を扱うための wrapper です。

通常の LazySegTree と異なり、`mapping(f, s)` は `Option[S]` を返します。

- `some(x)` を返した場合、そのノード全体に作用を適用できます。
- `none(S)` を返した場合、そのノードでは作用をまとめて適用できないため、子に降りて処理します。

@{keyword.constraints}

- `mapping` は `Option[S]` を返す
- `none` の場合は子に push できる必要がある

## 点更新・点取得

```text
st[p] = x
st[p]
```
`st[p] = x` で点 `p` を更新します。

`st[p]` で点 `p` の値を取得します。

`p` には通常の index のほか、`^1` のような `BackwardsIndex` も使えます。

@{keyword.constraints}

- `0 <= p < n`

@{keyword.complexity}

- $O(\log n)$

## 区間取得

```text
st.prod(p:RangeType)
st[p:RangeType]
```
区間 `p` の値を返します。

`RangeType` を使っているため、`l..<r` と `l..r` のどちらも渡せます。内部では `halfOpenEndpoints` により半開区間として扱われます。

@{keyword.constraints}

- `0 <= l <= r <= n`

@{keyword.complexity}

- $O(\log n)$

## 区間作用

```nim
st.apply(p:RangeType, f:F)
st.apply(p:IndexType, f:F)
```
遅延セグメント木または双対セグメント木で、区間または一点に作用 `f` を適用します。

@{keyword.complexity}

- $O(\log n)$

## all_prod

```text
st.all_prod()
```
全体の値を返します。

@{keyword.complexity}

- $O(1)$

## max_right / min_left

```nim
st.max_right(l, g)
st.min_left(r, g)
```
ACL の `segtree` / `lazy_segtree` と同様に、条件 `g` を満たす最大右端・最小左端を二分探索します。

@{keyword.constraints}

- `g(e()) == true`
- `g` は単調性を持つ

@{keyword.complexity}

- $O(\log n)$

## 注意

UniversalSegTree は内部実装を共通化するための高度な wrapper です。

単純な用途では、標準の `atcoder/segtree` や `atcoder/lazysegtree` の方が読みやすい場合があります。

一方で、次のような用途では UniversalSegTree が便利です。

- 通常 SegTree / LazySegTree / DualSegTree を同じ API で扱いたい
- `l..<r` と `l..r` の両方に対応したい
- 区間長や位置に依存する作用を扱いたい
- SegTree Beats 風の「まとめて適用できない場合は子に降りる」処理を書きたい

`composition(f, g)` の順序は重要です。この実装では、先に `g`、次に `f` を適用する合成として書きます。
