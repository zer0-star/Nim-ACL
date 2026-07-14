# Monoid SegTree facade

## 概要

`monoid_segtree`は、Monoid記述子から`SegTree`と`LazySegTree`を
構築するための公開facadeです。

既存のcallback constructorやcore moduleは変更しません。
新しい記述子形式を追加するため、従来のコードもそのまま利用できます。

## import

```nim
import atcoder/extra/structure/monoid_segtree
```

このimportから次をまとめて利用できます。

- `useMonoid`
- `useActedMonoid`
- `useActionMonoid`
- `SegTree`
- `LazySegTree`
- `initSegTree`
- `initLazySegTree`

`chaemon_header`を`include`したコードからも利用できます。

## Monoid記述子

```nim
proc add(a, b: int): int =
  a + b

proc zero(): int =
  0

useMonoid(
  SumMonoid,
  int,
  add,
  zero,
)
```

## SegTreeの構築

初期配列から構築できます。

```nim
var tree = initSegTree(
  SumMonoid,
  @[1, 2, 3, 4],
)
```

UFCS形式も利用できます。

```nim
var tree = SumMonoid.initSegTree(
  @[1, 2, 3, 4],
)
```

長さから構築すると、各葉は`default(S)`ではなく
Monoidの単位元で初期化されます。

```nim
var tree = SumMonoid.initSegTree(8)
```

単位元が`0`ではないMonoidでも正しく動作します。

```nim
proc minOp(a, b: int): int =
  min(a, b)

proc minIdentity(): int =
  high(int)

useMonoid(
  MinMonoid,
  int,
  minOp,
  minIdentity,
)

var minimums = MinMonoid.initSegTree(8)

doAssert minimums.prod(0..<8) == high(int)
```

## ActionMonoid

作用を表す公開形式では、作用Monoid `F`を値Monoid `S`より
先に記述します。

```nim
useActionMonoid(
  Name,
  FMonoid,
  SMonoid,
  mapping,
)
```

これは数学的な「`F`が`S`へ作用する」という読み順です。

従来形式も互換APIとして維持します。

```nim
useActedMonoid(
  Name,
  SMonoid,
  FMonoid,
  mapping,
)
```

内部実装の型順序は変更されません。

## LazySegTreeの構築

```nim
useActionMonoid(
  RangeAddMax,
  AddMonoid,
  MaxMonoid,
  mappingAdd,
)

var tree = RangeAddMax.initLazySegTree(
  @[1, 2, 3, 4],
)
```

記述子を先頭に置く形式も利用できます。

```nim
var tree = initLazySegTree(
  RangeAddMax,
  @[1, 2, 3, 4],
)
```

長さconstructorは値Monoidの単位元で初期化します。

```nim
var tree = RangeAddMax.initLazySegTree(8)
```

## 作用の合成順序

作用Monoidの演算`op(f, g)`は、`g`を適用した後に`f`を適用する
合成を表します。

```text
op(f, g)(x) = f(g(x))
```

affine変換では次の形です。

```nim
proc compose(f, g: Affine): Affine =
  (
    a: f.a * g.a,
    b: f.a * g.b + f.b,
  )
```

この順序は非可換なaffine作用を用いたtestで固定されています。

## 区間操作

構築後の操作は既存のSegTree APIと同じです。

```nim
tree.set(position, value)
tree.get(position)
tree.prod(0..<n)
tree.apply(1..<4, action)
```

`RangeType`による区間指定も利用できます。

## 既存callback APIとの共存

既存のcallback constructorは変更されません。

```nim
var tree = segtree.initSegTree[int](
  values,
  op,
  identity,
)
```

LazySegTreeのcallback constructorも維持されます。
facadeは記述子を既存callback形式へ変換する薄い層です。

## 境界条件

- 長さ`n`は0以上である必要があります。
- 長さ0の木もMonoidの空積契約に従います。
- Monoidの`op`は結合的である必要があります。
- `identity`は左右の単位元である必要があります。
- mappingはMonoid作用の法則を満たす必要があります。
- 作用合成は`f` after `g`です。

## 計算量

facadeは既存実装へ委譲するため、計算量は変わりません。

| 操作 | 計算量 |
|---|---:|
| 構築 | `O(n)` |
| `set` | `O(log n)` |
| `get` | 既存core契約 |
| `prod` | `O(log n)` |
| LazySegTreeの`apply` | `O(log n)` |

## 検証

恒久testで次を確認しています。

- `useActionMonoid`の`F, S`順
- 従来の`useActedMonoid`の`S, F`順
- descriptor-first constructor
- UFCS constructor
- 値配列と長さからの構築
- 非default単位元
- 非可換affine作用
- RangeType
- callback互換性
- `chaemon_header`
- refc / ORC
- Nim 2.2.10 / AtCoder Nim 2.2.4
