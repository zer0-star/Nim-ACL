# Slice utilities

## 概要

`sliceutils`はNimの`Slice`へ、逆順・step付き列挙、
配列の部分取得・step付き代入を追加します。

rangeをデータ構造の半開区間へ変換する用途には
`atcoder/rangeutils`を使用します。

## import

```nim
import atcoder/extra/other/sliceutils
```

## index

```nim
let values = @[10, 20, 30]
let indices = values.index

doAssert indices.a == 0
doAssert indices.b == 2
```

空の配列では`0 .. -1`を返します。

## 逆順列挙

```nim
for i in rev(1 .. 4):
  echo i
```

`4, 3, 2, 1`の順に列挙します。

UFCSでは括弧を付けます。

```nim
for i in (1 .. 4).rev():
  echo i
```

`(1 .. 4).rev`のように括弧を省略したproperty形式は
利用できません。

## step付き列挙

`>>`は小さいindexから、`<<`は大きいindexから列挙します。

```nim
for i in ((1 .. 7) >> 2):
  echo i
# 1, 3, 5, 7

for i in ((1 .. 7) << 2):
  echo i
# 7, 5, 3, 1
```

stepは0以外である必要があります。

## 整数の列挙

```nim
for i in 5:
  echo i
```

`0, 1, 2, 3, 4`を列挙します。

## 部分取得

```nim
let values = @[10, 20, 30, 40, 50]

doAssert values[1 .. 3] == @[20, 30, 40]
```

## step付き代入

```nim
var values = @[0, 0, 0, 0, 0]

values[(0 .. 4) >> 2] =
  @[10, 20, 30]

doAssert values == @[10, 0, 20, 0, 30]
```

右辺の長さは列挙される位置数と一致させてください。

## 公開API

```nim
proc index(openArray): Slice[int]
proc rev(Slice): ReversedSlice
iterator items(int): int
proc `>>`(Slice, step): StepSlice
proc `<<`(Slice, step): StepSlice
proc low(StepSlice)
proc high(StepSlice)
iterator items(ReversedSlice)
iterator items(StepSlice)
proc `[]`(openArray, Slice): seq
proc `[]=`(var openArray, StepSlice, openArray)
```

`ReversedSlice`と`StepSlice`は実装用の戻り値型です。
利用側で型名を直接指定する必要はありません。

## 境界条件

- `rev`は元のSliceの両端を含みます。
- `rev(slice)`または`slice.rev()`を使用します。
- `>>`と`<<`のstepは0にできません。
- 配列indexの範囲検査は基礎となる配列アクセスに従います。
- step付き代入では、右辺の要素数を位置数と一致させます。
- 空のSliceは要素を列挙しません。

## 計算量

列挙または操作する要素数を`k`とします。

| 操作 | 計算量 |
|---|---:|
| `index` | `O(1)` |
| `rev`の構築 | `O(1)` |
| step Sliceの構築 | `O(1)` |
| 列挙 | `O(k)` |
| 部分取得 | `O(k)` |
| step付き代入 | `O(k)` |

## 関連

- `atcoder/rangeutils`
- Nim標準の`Slice`
- Nim標準の`BackwardsIndex`

## 検証

専用testで以下を確認しています。

- `index`
- `rev(slice)`
- `slice.rev()`
- 正方向・逆方向のstep列挙
- 整数の`items`
- 部分取得
- step付き代入
- 空配列
- refc / ORC
- Nim 2.2.10 / AtCoder Nim 2.2.4
