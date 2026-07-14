# monoid

`MonoidType` は、型 `E`、二項演算 `op`、単位元 `e` から monoid 型を作るための helper です。

```nim
import atcoder/extra/monoid/monoid

proc addInt(a, b: int): int = a + b
proc zeroInt(): int = 0

type SumMonoid = MonoidType(int, addInt, zeroInt)

doAssert SumMonoid.op(2, 3) == 5
doAssert SumMonoid.e() == 0
```

逆元を持つ場合は、4 番目の引数に `inv` を渡せます。

```nim
proc negInt(a: int): int = -a

type AddGroup = MonoidType(int, addInt, zeroInt, negInt)

doAssert AddGroup.inv(3) == -3
```

`ActedMonoidType` は、値側 monoid `MS`、作用側 monoid `MF`、作用 `mapping` から acted monoid を作ります。lazy segment tree などで使う `mapping / composition / id` の組をまとめて扱えます。

```nim
proc addMap(f, x: int): int = x + f

type AddAction = ActedMonoidType(SumMonoid, SumMonoid, addMap)

doAssert AddAction.op(2, 3) == 5
doAssert AddAction.composition(4, 5) == 9
doAssert AddAction.mapping(7, 10) == 17
```

## import

```nim
import atcoder/extra/monoid/monoid
```

## 公開 API

- `Monoid`
- `InversibleMonoid`
- `ActedMonoid`
- `MonoidType`
- `ActedMonoidType`
- `value_type`
- `S`
- `F`
- `op`
- `e`
- `composition`
- `id`
- `mapping`

## 注意

`MonoidType` / `ActedMonoidType` は、既存の低レベル API と互換性を保ったまま使うための型生成 helper です。より短い競技プログラミング向け facade は、今後 `fps` と同じ方針で追加できます。

## facade aliases

`MonoidOf`, `GroupOf`, `ActedMonoidOf` は、既存の `MonoidType` / `ActedMonoidType` の読みやすい別名です。

```nim
type Sum = MonoidOf(int, addInt, zeroInt)
type AddGroup = GroupOf(int, addInt, zeroInt, negInt)
type AddAction = ActedMonoidOf(Sum, Sum, addMap)
```

既存 API と同じ型を作るだけなので、従来の `MonoidType` / `ActedMonoidType` と併用できます。

## useMonoid helpers

`useMonoid`, `useGroup`, `useActedMonoid` を使うと、型名を先に書く形で monoid 型を宣言できます。

```nim
useMonoid(Sum, int, addInt, zeroInt)
useGroup(AddGroup, int, addInt, zeroInt, negInt)
useActedMonoid(AddAction, Sum, Sum, addMap)
```

これは次と同じ意味です。

```nim
type Sum = MonoidType(int, addInt, zeroInt)
type AddGroup = MonoidType(int, addInt, zeroInt, negInt)
type AddAction = ActedMonoidType(Sum, Sum, addMap)
```

`useMonoid` 系は、競技プログラミング中に型宣言を短く書くための convenience helper です。

<!-- NIM_ACL_ACTION_MONOID_FACADE_START -->

## ActionMonoidの公開順序

作用を表す公開facadeでは、作用Monoid `F`を値Monoid `S`より
先に提示します。

```nim
useActionMonoid(
  Name,
  FMonoid,
  SMonoid,
  mapping,
)
```

内部では既存形式へ委譲します。

```nim
useActedMonoid(
  Name,
  SMonoid,
  FMonoid,
  mapping,
)
```

`useActedMonoid`は互換APIとして維持されます。

<!-- NIM_ACL_ACTION_MONOID_FACADE_END -->
