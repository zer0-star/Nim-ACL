# Persistent Segment Tree（永続セグメント木）

1個の木がすべてのノードを管理し、`PersistentVersion`が各時点の
根を表します。

数列をコピーするときは要素を複製せず、versionを代入します。

```nim
versions[x] = versions[y]
```

## 初期化

一般形は次のとおりです。

```nim
type Tree =
  PersistentSegTreeType[S](
    op,
    e,
  )

var tree =
  Tree.init(
    valuesOrLength,
    expectedUpdates = 0,
  )
```

- `S`: 要素と区間積の型
- `op(left, right)`: 左区間と右区間の値を結合する関数
- `e()`: `op`の単位元を返す関数
- `valuesOrLength`: 初期列、または初期長
- `expectedUpdates`: 予定する一点更新回数

`op`と`e`の加算モノイドの具体例は次のとおりです。

```nim
proc op(
    left,
    right: int,
): int =
  left + right

proc e(): int =
  0
```

この`op`, `e`を一般形へ渡します。

```nim
type SumTree =
  PersistentSegTreeType[int](
    op,
    e,
  )

var tree =
  SumTree.init(
    n,
    expectedUpdates = q,
  )
```

長さだけを渡すと、すべての要素を`e()`で初期化します。

簡略constructorも使用できます。

```nim
var tree =
  initPersistentSegmentTree(
    n,
    op,
    e,
    expectedUpdates = q,
  )
```

## 初期version

```nim
let version =
  tree.initialVersion
```

`version`は軽量なroot番号です。

## 一点更新

一般形は次のとおりです。

```nim
newVersion =
  tree.set(
    version,
    position,
    value,
  )
```

- `version`: 更新元のversion
- `position`: 更新する添字
- `value`: 新しい値
- 返り値: 更新後の新しいversion

元のversionは変更されません。

```nim
versions[x] =
  tree.set(
    versions[x],
    y,
    z,
  )
```

短縮記法では、渡したversion変数を新しいversionへ更新します。

```nim
tree[version][position] = value
```

または、

```nim
tree[version, position] = value
```

## 一点取得

一般形は次のとおりです。

```nim
value =
  tree.get(
    version,
    position,
  )
```

- `version`: 読み取り対象のversion
- `position`: 読み取る添字

短縮記法は次のとおりです。

```nim
value = tree[version][position]
```

または、

```nim
value = tree[version, position]
```

## 区間積

一般形は次のとおりです。

```nim
answer =
  tree.prod(
    version,
    range,
  )
```

- `version`: 読み取り対象のversion
- `range`: 集約する範囲

半開区間の端点を直接渡すこともできます。

```nim
answer =
  tree.prod(
    version,
    left,
    right,
  )
```

短縮記法は次のとおりです。

```nim
answer = tree[version][left ..< right]
```

または、

```nim
answer = tree[version, left ..< right]
```

## 全体積

```nim
answer =
  tree.allProd(
    version
  )
```

## 配列への復元

```nim
values =
  tree.toSeq(
    version
  )
```

計算量は`O(n log n)`です。主にdebug用途です。

## version view

`tree[version]`はtreeとversionを参照する一時的なviewです。

```nim
tree[version][position] = value
answer = tree[version][range]
```

viewを変数へ保存することもできますが、元のtreeとversionより長く
保持しないでください。

## expectedUpdates

<!-- NACL_EXPECTED_UPDATES_SECTION_START -->
<!-- NIM_ACL_TUNING_PARAMETER: expectedUpdates -->

- expectedUpdates: 意味 — 将来行う一点更新回数の見積もりです。
- expectedUpdates: 既定値 — 省略時は `0` です。
- expectedUpdates: 正しさ — 値は計算結果や作成可能なversion数に影響しません。
- expectedUpdates: 小さすぎても — node storageが自動拡張され、結果は正しいままです。
- expectedUpdates: 大きすぎると — 余分なcapacityを事前確保します。
- expectedUpdates: メモリ — 初期node capacityの事前確保にだけ使います。
- 木の高さを `h` とすると、一点更新ごとに正確に `h + 1` 個のnodeを作ります。
- 初期capacityは概ね `2 * size + expectedUpdates * (h + 1)` です。

<!-- NACL_EXPECTED_UPDATES_SECTION_END -->

## raw static tuple形式

`PersistentSegTree[S, (op: ..., e: ...)]`は低水準APIです。

同じsignatureを持つ複数の匿名procをraw static tupleへ直接渡すと、
Nimが後のprocにも最初のprocを再利用する場合があります。

通常は`PersistentSegTreeType`または
`initPersistentSegmentTree`を使用してください。

## 計算量

- 初期化: `O(n)`
- versionのコピー: `O(1)`
- 一点更新: `O(log n)`時間・`O(log n)`追加memory
- 一点取得: `O(log n)`
- 区間積: `O(log n)`
- 全体積: `O(1)`
