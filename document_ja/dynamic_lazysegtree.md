
# DynamicLazySegTree

`dynamic_lazysegtree` は、実行時に `op`, `e`, `mapping`, `composition`, `id` を渡して使う遅延セグメント木です。

区間更新・区間取得を扱えます。長さ `n` は初期化時に固定されます。

## import

```text
import atcoder/dynamic_lazysegtree
```
## コンストラクタ

```nim
var st = init_lazy_segtree[S, F](
  v:seq[S],
  op:proc(a, b:S):S,
  e:proc():S,
  mapping:proc(f:F, x:S):S,
  composition:proc(f, g:F):F,
  id:proc():F
)

var st = init_lazy_segtree[S, F](
  n:int,
  op,
  e,
  mapping,
  composition,
  id
)
```
列 `v` から、または長さ `n` の単位元列から遅延セグメント木を構築します。

`S` は区間値の型、`F` は作用素の型です。

@{keyword.constraints}

- `op` は結合的
- `e()` は `op` の単位元
- `mapping(f, x)` は作用 `f` を区間値 `x` に適用した値
- `composition(f, g)` は、先に `g`、次に `f` を適用する合成
- `id()` は恒等作用

@{keyword.complexity}

- $O(n)$

## set / get

```nim
st.set(p:int, x:S):void
st.get(p:int):S
```
一点を更新・取得します。

@{keyword.constraints}

- `0 <= p < n`

@{keyword.complexity}

- $O(\log n)$

## prod

```text
st.prod(l..r):S
```
区間 `l..r` の値を取得します。

この実装の `prod` は `Slice[int]` を受け取り、`l..r` を閉区間として扱います。

@{keyword.complexity}

- $O(\log n)$

## apply

```nim
st.apply(p:int, f:F):void
st.apply(l..r, f:F):void
```
一点または区間に作用 `f` を適用します。

@{keyword.complexity}

- $O(\log n)$

## all_prod

```text
st.all_prod():S
```
全体の値を返します。

@{keyword.complexity}

- $O(1)$

## max_right / min_left

```nim
st.max_right(l:int, g:proc(s:S):bool):int
st.min_left(r:int, g:proc(s:S):bool):int
```
ACL の `lazy_segtree` と同様に、条件 `g` を満たす最大右端・最小左端を二分探索します。

@{keyword.constraints}

- `g(e()) == true`

@{keyword.complexity}

- $O(\log n)$

## 使用例

```nim
import atcoder/dynamic_lazysegtree

type Node = tuple[sum:int, len:int]

proc op(a, b:Node):Node =
  (sum: a.sum + b.sum, len: a.len + b.len)

proc e():Node =
  (sum: 0, len: 0)

proc mapping(f:int, x:Node):Node =
  (sum: x.sum + f * x.len, len: x.len)

proc composition(f, g:int):int =
  f + g

proc id():int =
  0

var st = init_lazy_segtree[Node, int](
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

doAssert st.prod(0..4).sum == 15

st.apply(1..3, 10)

doAssert st.get(2).sum == 13
doAssert st.prod(0..4).sum == 45
```
## 注意

`prod` と区間 `apply` は `Slice[int]` を閉区間として扱います。たとえば `1..3` は 1, 2, 3 を含みます。

半開区間で使いたい場合は、呼び出し側で右端を `r - 1` に変換してください。
