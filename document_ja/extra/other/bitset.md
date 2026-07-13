# BitSet

## 概要

`BitSet[N]`は長さをコンパイル時に指定する固定長bit列、
`DynamicBitSet`は長さを実行時に指定する可変長bit列です。

64bit wordの列として格納され、個々のbitの更新、論理演算、
shift、set bit数の計算、最初・最後のset bitの探索、
非負整数としての比較を提供します。

## import

```nim
import atcoder/extra/other/bitset
```

現在のpathは既存コードとの互換性のため維持されています。
構造を表すcanonical pathは今後compatibility shimとともに追加予定です。

## 型

```nim
type BitSet[N: static[int]]
type DynamicBitSet
type SomeBitSet = BitSet | DynamicBitSet
```

## 構築

```nim
let zero = initBitSet[128]()
let full = initBitSet1(128)

let dynamicZero = initDynamicBitSet(128)
let dynamicFull = initDynamicBitSet1(128)
```

`initBitSet1`と`initDynamicBitSet1`は全bitが1の値を返します。

typedescからも構築できます。

```nim
let zero = BitSet[128].init()
let full = BitSet[128].init1()
```

## bitアクセス

```nim
let value = bits[i]

bits[i] = 0
bits[i] = 1
```

indexは0始まりです。

## 論理演算

```nim
not bits

left and right
left or right
left xor right

left and= right
left or= right
left xor= right
```

同じ型・同じ論理サイズのbit列に対して使用します。

## shift

```nim
bits shl amount
bits shr amount
```

結果の長さは変化せず、範囲外へ移動したbitは破棄されます。
長さ以上のshiftは全bitが0の値になります。

## 集約と探索

```nim
bits.any()
bits.all()
bits.count()

bits.firstSetBit()
bits.fastLog2()
```

- `firstSetBit`は最小のset bit indexを0始まりで返します。
- set bitがない場合、`firstSetBit`は論理サイズを返します。
- `fastLog2`は最大のset bit indexを返します。
- set bitがない場合、`fastLog2`は`-1`を返します。
- 空のbit列に対する`all()`は`true`です。

## 数値比較

```nim
a < b
a <= b
```

bit列を非負整数とみなし、上位wordから比較します。
比較する二つのbit列は論理サイズが等しい必要があります。

## 表示

```nim
bits.toStr()
bits.toStr(width)
```

論理サイズに対応する二進文字列を返します。
空の`DynamicBitSet`では空文字列になります。

## copy

`DynamicBitSet`は値として代入できます。

```nim
var a = initDynamicBitSet(100)
a[3] = 1

var b = a
b[4] = 1

doAssert a[4] == 0
```

代入後の更新は元の値へ反映されません。

## 境界条件

- 有効なindexは`0 <= i < bits.getSize()`です。
- `BitSet[N]`では`N >= 1`を使用してください。
- `DynamicBitSet`は長さ0を扱えます。
- 末尾wordの未使用bitは、`not`、shift、`count`、`all`、
  比較結果へ含まれません。
- 異なる論理サイズ同士の比較・論理演算には依存しないでください。

## 計算量

`W = ceil(N / 64)`とします。

| 操作 | 計算量 |
|---|---:|
| bit取得・更新 | `O(1)` |
| `any`, `all`, `count` | `O(W)` |
| `and`, `or`, `xor`, `not` | `O(W)` |
| `shl`, `shr` | `O(W)` |
| `firstSetBit`, `fastLog2` | `O(W)` |
| `<`, `<=` | `O(W)` |
| `toStr` | `O(N)` |

## 使用例

```nim
import atcoder/extra/other/bitset

var bits = initDynamicBitSet(130)

bits[3] = 1
bits[64] = 1
bits[129] = 1

doAssert bits.count == 3
doAssert bits.firstSetBit == 3
doAssert bits.fastLog2 == 129

let shifted = bits shl 1

doAssert shifted[4] == 1
doAssert shifted[65] == 1
```

## 関連

- `atcoder/extra/other/bitutils`
  - 整数1個をbit maskとして扱うutility
- `std/bitops`
  - 整数型に対する標準bit操作
- `std/packedsets`
  - ordinal値の集合を扱う標準構造

## 検証

専用testで以下を確認しています。

- 長さ`0, 1, 2, 63, 64, 65, 127, 128, 129`
- refc / ORC
- Nim 2.2.10 / AtCoder Nim 2.2.4
- 固定長・可変長constructor
- 論理演算とin-place演算
- 左右shift
- 末尾未使用bit
- `firstSetBit`と`fastLog2`
- 数値比較
- copy semantics
- 素朴配列とのrandom differential
