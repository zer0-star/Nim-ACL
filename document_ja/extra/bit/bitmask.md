# Bitmask

## 概要

整数1個をbit maskとして扱うためのutilityです。

bit位置列との相互変換、bit access、bit範囲の抽出、
下位bit mask、set bit列挙、submask列挙を提供します。

複数の64bit wordが必要な場合は`BitSet`を使用してください。

## import

```nim
import atcoder/extra/bit/bitmask
```

## bit access

```nim
let bit = value[i]

value[i] = 0
value[i] = 1
```

## bit Slice

```nim
let part: uint64 = value[first .. last]
```

Sliceは両端を含みます。

bit `first`が結果のbit 0になるように右へ詰められ、
返り値の型は入力整数と同じ型です。

```nim
let value = 0b11010110'u64

doAssert value[1 .. 3] == 0b011'u64
```

`uint64`の`0 .. 63`など、整数型の全幅も取得できます。

## bit位置とmaskの変換

```nim
let mask = seqToBits[uint64](0, 2, 5)

let positions = bitsToSeq(mask)

for position in iterBits(mask):
  discard
```

`iterBits`と`bitsToSeq`は、set bitのindexを小さい順に返します。

既存の短縮表記もあります。

```nim
let positions = @mask
let mask = @^[0, 2, 5]
```

可読性を優先するコードでは名前付きAPIを推奨します。

## 下位bit mask

```nim
allSetBits[uint64](n)
```

下位`n`bitが1の値を返します。

`n = 0`と`n = sizeof(B) * 8`の両方を安全に扱えます。

## bit位置集合との演算

```nim
mask and [0, 2, 5]
mask or [0, 2, 5]
mask xor [0, 2, 5]

mask & [0, 2, 5]
mask | [0, 2, 5]
```

## submask列挙

```nim
for submask in subsets(mask):
  discard
```

`mask`の全submaskを遅延列挙します。
`uint32`や`uint64`を渡した場合も同じ整数型を返します。

bit位置列からも列挙できます。

```nim
for mask in subsets(@[1, 3, 7], uint64):
  discard
```

## 表示

```nim
toBitStr(mask)
toBitStr(mask, width)
```

## 境界条件

- bit indexは0始まりです。
- indexとSliceは整数型のbit幅内に収めてください。
- `allSetBits[B](n)`では
  `0 <= n <= sizeof(B) * 8`です。
- signed整数のset bit列挙には非負の値を使用してください。
- submaskの列挙順ではなく、列挙される集合へ依存してください。

## 計算量

`k`をset bit数、`m`を列挙対象のbit数とします。

| 操作 | 計算量 |
|---|---:|
| bit取得・更新 | `O(1)` |
| bit Slice | `O(1)` |
| `seqToBits` | `O(引数数)` |
| `iterBits`, `bitsToSeq` | `O(k)` |
| `allSetBits` | `O(1)` |
| 全submask列挙 | `O(2^m)` |
| 各submaskの追加領域 | `O(1)` |

## 使用例

```nim
import atcoder/extra/bit/bitmask

let mask = seqToBits[uint64](0, 2, 5, 63)

doAssert mask[63] == 1
doAssert bitsToSeq(mask) == @[0, 2, 5, 63]

for submask in subsets(mask):
  discard
```

## 関連

- `atcoder/extra/structure/dense_bitset`
  - 複数wordにまたがる固定長・可変長bit列
- `std/bitops`
  - 整数型に対する標準bit操作

## 検証

専用testで以下を確認しています。

- `uint8`, `uint16`, `uint32`, `uint64`, `int`
- 0bit・部分幅・全幅mask
- 全Slice endpointのrandom differential
- set bit列挙
- `uint64` submask列挙
- refc / ORC
- Nim 2.2.10 / AtCoder Nim 2.2.4


## 説明的なAPI名

```nim
let mask =
  maskFromBitIndices[uint64](0, 2, 5)

doAssert bitIndices(mask) == @[0, 2, 5]
doAssert lowBitsMask[uint64](5) == 0b11111'u64

for submask in submasks(mask):
  discard submask

for subsetMask in subsetMasks(@[1, 3, 7], uint64):
  discard subsetMask
```

| 説明的な名前 | 既存名 |
|---|---|
| `maskFromBitIndices` | `seqToBits` |
| `bitIndices` | `bitsToSeq` |
| `lowBitsMask` | `allSetBits` |
| `toBitString` | `toBitStr` |
| `submasks` | `subsets(mask)` |
| `subsetMasks` | `subsets(positions, B)` |

## 旧import pathとの互換性

```nim
import atcoder/extra/other/bitutils
```

新しいコードでは次を推奨します。

```nim
import atcoder/extra/bit/bitmask
```
