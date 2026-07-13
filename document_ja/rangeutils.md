# Range utilities

## 概要

`rangeutils`はNimの`Slice`、`HSlice`、`BackwardsIndex`を、
データ構造内部で扱いやすい半開区間`[l, r)`へ変換します。

Fenwick Tree、Segment Tree、Lazy Segment Tree、Sparse Table、
Rolling Hashなどで共通利用されています。

## import

```nim
import atcoder/rangeutils
```

## 対応するrange表記

```nim
type RangeType =
  Slice[int] |
  HSlice[int, BackwardsIndex] |
  HSlice[BackwardsIndex, int] |
  Slice[BackwardsIndex]
```

長さ8のcontainerでは、次のように正規化されます。

| 表記 | 意味 | `[l, r)` |
|---|---|---|
| `2 .. 4` | 両端を含む | `[2, 5)` |
| `2 ..< 5` | 右端を含まない | `[2, 5)` |
| `2 .. ^1` | index 2から末尾まで | `[2, 8)` |
| `^3 .. ^1` | 末尾相対index同士 | `[5, 8)` |
| `^3 .. 6` | 末尾相対の左端 | `[5, 7)` |
| `^3 ..< 7` | 末尾相対の左端・半開 | `[5, 7)` |
| `^3 ..< 5` | 空区間 | `[5, 5)` |
| `0 ..< ^0` | 全区間 | `[0, 8)` |
| `^0 ..< ^0` | 末尾の空区間 | `[8, 8)` |
| `0 .. ^0` | clampしないclosed range | `[0, 9)` |

`^k`は`container.len - k`へ変換されます。
したがって`^1`は最後の要素、`^0`は末尾の直後を表します。

全区間には`0 ..< ^0`を使用してください。
`0 .. ^0`はclosed右端をさらに1増やすため、
通常のデータ構造に対しては範囲外になります。

## 公開API

```nim
type RangeType
type IndexType

template halfOpenEndpoints(
    p: Slice[int]
): (int, int)

template halfOpenEndpoints(
    container,
    p: RangeType
): (int, int)
```

整数endpointだけのrangeはcontainerなしでも変換できます。

```nim
doAssert halfOpenEndpoints(2 .. 4) == (2, 5)
doAssert halfOpenEndpoints(2 ..< 2) == (2, 2)
```

`BackwardsIndex`を含むrangeでは、
長さを得るためcontainerを指定します。

```nim
let values = @[10, 20, 30, 40, 50]

doAssert values.halfOpenEndpoints(1 .. ^1) == (1, 5)
doAssert values.halfOpenEndpoints(^3 .. 3) == (2, 4)
doAssert values.halfOpenEndpoints(0 ..< ^0) == (0, 5)
```

## データ構造での使用例

```nim
import atcoder/fenwicktree
import atcoder/rangeutils

var tree = initFenwickTree[int](8)

for i in 0 ..< 8:
  tree.add(i, i + 1)

doAssert tree.sum(2 .. 4) == 12
doAssert tree.sum(2 ..< 5) == 12
doAssert tree.sum(2 .. ^1) == 33
doAssert tree.sum(^3 ..< 7) == 13
doAssert tree.sum(0 ..< ^0) == 36
```

既存の`sum(l, r)`や`prod(l, r)`などの`(l, r)`形式も
引き続き利用できます。

## 境界条件

- 正規化は`O(1)`です。
- 結果は常に半開区間`[l, r)`です。
- 空の半開区間は`l == r`になります。
- endpointのclampや範囲検査は行いません。
- 範囲外のendpointは範囲外の整数へそのまま変換されます。
- `0 ..< ^0`は長さ0のcontainerでも`[0, 0)`になります。
- closed rangeの右端は内部で1加算されます。
- closed右端には`high(int)`を使用できません。
- overflow checkが有効なbuildでは、`high(int) + 1`は拒否されます。
- 実際のデータ構造が要求する`0 <= l <= r <= len`を満たす必要があります。

## 計算量

| 操作 | 計算量 |
|---|---:|
| 整数endpointの正規化 | `O(1)` |
| `BackwardsIndex`の正規化 | `O(1)` |
| 追加領域 | `O(1)` |

## 関連

- `atcoder/fenwicktree`
- `atcoder/segtree`
- `atcoder/lazysegtree`
- `atcoder/extra/other/sliceutils`

## 検証

専用testで以下を確認しています。

- 4種類すべてのendpoint型組合せ
- closed rangeとhalf-open range
- `BackwardsIndex`
- `^0`
- 長さ0のcontainer
- 空区間
- clampを行わない契約
- 最大の安全なclosed右端
- checked overflow拒否
- Fenwick Treeの公開range API
- refc / ORC
- Nim 2.2.10 / AtCoder Nim 2.2.4
