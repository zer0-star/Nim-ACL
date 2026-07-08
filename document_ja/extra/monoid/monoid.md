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
